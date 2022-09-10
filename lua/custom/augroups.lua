-- err folding
require("custom.go-err")
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
-- vim.api.nvim_create_autocmd("BufRead", {
-- 	pattern = "*.go",
-- 	callback = function()
-- 		vim.api.nvim_buf_set_var(0, "errfolded", false)
-- 		vim.cmd("setlocal fillchars=fold:\\ ")
-- 	end,
-- 	group = goerr_augroup,
-- })

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "*.go",
	callback = function()
		vim.fn.jobstart("goimports -w .", {
			on_exit = function()
				vim.cmd("e")
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
	assert(entry.Package, "Must have Package:" .. vim.inspect(entry))
	assert(entry.Test, "Must have Test:" .. vim.inspect(entry))
	return string.format("%s/%s", entry.Package, entry.Test)
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

-- local display_golang_output = function(state, bufnr) end

local ns = vim.api.nvim_create_namespace "live-tests"

local attach_to_buffer = function(bufnr, command)
	local state = {
		bufnr = bufnr,
		tests = {},
	}

	vim.api.nvim_buf_create_user_command(bufnr, "GoTestLineDiag", function()
		-- print(vim.inspect(state))
		local line = vim.fn.line "." - 1
		for _, test in pairs(state.tests) do
			if test.line == line then
				vim.cmd.vnew()
				vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), 0, -1, false, test.output)
			end
		end
	end, {})

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup(string.format("gotest-%s", bufnr), { clear = true }),
		pattern = "*.go",
		callback = function()
			vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)

			state = {
				bufnr = bufnr,
				tests = {},
			}

			vim.fn.jobstart(command, {
				stdout_buffered = true,
				on_stdout = function(_, data)
					if not data then
						return
					end

					for _, line in ipairs(data) do
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
								local text = { "✓" }
								vim.api.nvim_buf_set_extmark(bufnr, ns, test.line, 0, {
									virt_text = { text },
								})
							end
						elseif decoded.Action == "pause" or decoded.Action == "cont" then
							-- Do nothing
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
									bufnr = bufnr,
									lnum = test.line,
									col = 0,
									severity = vim.diagnostic.severity.ERROR,
									source = "go-test",
									message = "Test Failed",
									user_data = {},
								})
							end
						end
					end

					vim.diagnostic.set(ns, bufnr, failed, {})
				end,
			})
		end,
	})
end

-- attach_to_buffer(80, { "go", "run", "main.go" })
-- attach_to_buffer(16, { "go", "test", "./...", "-v", "-json" })
-- attach_to_buffer(1, { "go", "test", "./...", "-v", "-json", "-run", "TestDoesFailStill" })
