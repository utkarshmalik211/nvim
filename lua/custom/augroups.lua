-- err folding
require("custom.go-err")
-- local ts_utils = require 'nvim-treesitter.ts_utils'
local gofmt_augroup = vim.api.nvim_create_augroup("Go-Formats", { clear = true })
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*.go",
-- 	callback = function()
-- 		if vim.api.nvim_buf_get_var(0, "errfolded") == false then
-- 			vim.cmd('g/if err != nil {/silent execute("normal zcgg")')
-- 		end
-- 		vim.api.nvim_buf_set_var(0, "errfolded", true)
-- 	end,
-- 	group = goerr_augroup,
-- })
--
-- vim.api.nvim_create_autocmd("BufEnter", {
-- 	pattern = "*.go",
-- 	callback = function()
-- 		vim.opt.foldtext = 'v:lua.GoErrFoldTxt()'
-- 	end,
-- 	group = goerr_augroup,
-- })
--
--vim.api.nvim_create_autocmd("BufRead", {
--	pattern = "*_test.go",
--	callback = function()
--		vim.cmd('%g / {/ normal! zf%')
--	end,
--	group = gofmt_augroup,
--})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.go",
	callback = function()
	        local r,c = unpack(vim.api.nvim_win_get_cursor(0))
		vim.fn.jobstart("goimports -w .", {
			on_exit = function()
				vim.cmd("e!")
			        vim.api.nvim_win_set_cursor(0, { r, c })
			end
		}
		)
	end,
	group = gofmt_augroup,
})


-- run tests
local test_function_query_string = [[
(
 (function_declaration
  name: (identifier) @name
  parameters:
    (parameter_list
     (parameter_declaration
      name: (identifier)
      type: (pointer_type
          (qualified_type
           package: (package_identifier) @_package_name
           name: (type_identifier) @_type_name)))))

 (#eq? @_package_name "testing")
 (#eq? @_type_name "T")
 (#eq? @name "%s")
)
]]

local find_tests_names_infile = [[
(
 (function_declaration
  name: (identifier) @name
  parameters:
    (parameter_list
     (parameter_declaration
      name: (identifier)
      type: (pointer_type
          (qualified_type
           package: (package_identifier) @_package_name
           name: (type_identifier) @_type_name)))))

 (#eq? @_package_name "testing")
 (#eq? @_type_name "T")
)
]]

local find_test_names = function(state)
	local query = vim.treesitter.parse_query("go", string.format(find_tests_names_infile))
	local parser = vim.treesitter.get_parser(state.bufnr, "go", {})
	local tree = parser:parse()[1]
	local root = tree:root()

	for id, node in query:iter_captures(root, state.bufnr, 0, -1) do
		if id == 1 then
			local range = { node:range() }
			local testname = vim.treesitter.query.get_node_text(node)[1]
			state.tests[testname] = {
				line = range[1],
				name = testname,
				output = {},
			}
		end
	end
end

local find_test_line = function(go_bufnr, name)
	local query = vim.treesitter.parse_query("go", string.format(test_function_query_string, name))
	local parser = vim.treesitter.get_parser(go_bufnr, "go", {})
	local tree = parser:parse()[1]
	local root = tree:root()

	for id, node in query:iter_captures(root, go_bufnr, 0, -1) do
		if id == 1 then
			local range = { node:range() }
			return range[1]
		end
	end
end

local make_key = function(entry)
	assert(entry.Test, "Must have Test:" .. vim.inspect(entry))
	return string.format("%s", entry.Test)
end

local add_golang_test = function(state, entry)
	state.tests[make_key(entry)] = {
		name = entry.Test,
		line = find_test_line(state.bufnr, entry.Test),
		output = {},
	}
end

local add_golang_output = function(state, entry)
	assert(state.tests, vim.inspect(state))
	table.insert(state.tests[make_key(entry)].output, vim.trim(entry.Output))
end

local mark_success = function(state, entry)
	state.tests[make_key(entry)].success = entry.Action == "pass"
end


local ns = vim.api.nvim_create_namespace "live-tests"

local attach_to_buffer = function(state)
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup(string.format("gotest-%s", state.bufnr), { clear = true }),
		pattern = "*.go",
		callback = function()
			find_test_names(state)
			local tests = {}
			for name, _ in pairs(state.tests) do
				table.insert(tests, name)
			end
			local tests_to_run = table.concat(tests, "|")
			tests_to_run = string.format("^(%s)$", tests_to_run)
			local command = { "go", "test", "-timeout", "30s", "-v", "-json", "-count", "1", "-run",
				tests_to_run,
				state.package }
			vim.api.nvim_buf_clear_namespace(state.bufnr, ns, 0, -1)
			vim.fn.jobstart(command, {
				stdout_buffered = true,
				on_stdout = function(_, data)
					if not data then
						return
					end
					for _, line in ipairs(data) do
						print(line)
						local decoded = vim.json.decode(line)
						if decoded.Action == "run" then
							add_golang_test(state, decoded)
						elseif decoded.Action == "output" then
							if not decoded.Test then
								return
							end
							add_golang_output(state, decoded)
						elseif decoded.Action == "pass" or decoded.Action == "fail" then
							mark_success(state, decoded)
							local test = state.tests[make_key(decoded)]
							if test.success then
								local text = { "✅  PASS" }
								vim.api.nvim_buf_set_extmark(state.bufnr, ns, test.line,
									0, {
										virt_text = { text },
									})
							end
						elseif decoded.Action == "pause" or decoded.Action == "cont" then
							-- Do nothing
						elseif decoded.Action == "skip" then
							mark_success(state, decoded)
							local test = state.tests[make_key(decoded)]
							local text = { "⏭  SKIP" }
							vim.api.nvim_buf_set_extmark(state.bufnr, ns, test.line, 0, {
								virt_text = { text },
							})
						else
							error("Failed to handle" .. vim.inspect(data))
						end
					end
				end,

				on_exit = function()
					local failed = {}
					for _, test in pairs(state.tests) do
						if test.line then
							if not test.success then
								table.insert(failed, {
									bufnr = state.bufnr,
									lnum = test.line,
									col = 0,
									severity = vim.diagnostic.severity.ERROR,
									source = "go-test",
									message = "Test Failed  \n" ..
									    table.concat(test.output, " \n"),
									user_data = {},
								})
							end
						end
					end

					vim.diagnostic.set(ns, state.bufnr, failed, {})
				end,
			})
		end,
	})
end

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.go",
	callback = function()
		local bufnr = vim.api.nvim_get_current_buf()
		vim.api.nvim_buf_create_user_command(bufnr, "AttachLiveTest", function()
			local state = {
				bufnr = bufnr,
				tests = {},
				package = vim.fn.expand('%:h'),
			}
			attach_to_buffer(state)
		end, {})
	end,
	group = gofmt_augroup,
})
