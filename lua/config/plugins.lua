-- Automatically install lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup("plugins", {
	defaults = { lazy = true },
	install = { colorscheme = { "kanagawa-dragon" } },
	checker = {
		enabled = true,
		notify = false, -- get a notification when new updates are found
		frequency = 3600*24, -- check for updates every hour
	},
	dev = {
		-- directory where you store your local plugin projects
		path = "~/dev/neovim-plugins/",
		fallback = false, -- Fallback to git when local plugin doesn't exist
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"netrw",
				"matchparen",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
