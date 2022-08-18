require("modules.go-err")
local goerr_augroup = vim.api.nvim_create_augroup("Go-err", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.go",
	callback = function()
		if vim.api.nvim_buf_get_var(0, "errfolded") == false then
			vim.cmd('g/if err != nil {/silent execute("normal zcgg")')
		end
		vim.api.nvim_buf_set_var(0, "errfolded", true)
	end,
	group = goerr_augroup,
})

vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*.go",
	callback = function()
		vim.opt.foldtext = 'v:lua.GoErrFoldTxt()'
	end,
	group = goerr_augroup,
})

vim.api.nvim_create_autocmd("BufRead", {
	pattern = "*.go",
	callback = function()
		vim.api.nvim_buf_set_var(0, "errfolded", false)
		vim.cmd("setlocal fillchars=fold:\\ ")
	end,
	group = goerr_augroup,
})
