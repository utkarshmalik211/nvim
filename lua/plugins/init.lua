local plugins = {
	'nvim-lua/popup.nvim',
	'nvim-lua/plenary.nvim',
	'neovim/nvim-lspconfig',
	'kyazdani42/nvim-web-devicons',
	{ 'mbbill/undotree' },

	-- dap for dabs
	{ 'mfussenegger/nvim-dap' },
	{ 'rcarriga/nvim-dap-ui' },

	-- the new way to navigate
	{ 'ThePrimeagen/harpoon' },
	{ 'machakann/vim-sandwich', event = { "InsertEnter" } },
	{ 'rust-lang/rust.vim',     ft = { "rs" } },
	{ 'tpope/vim-fugitive',     cmd = { "Git", "G" } }, -- git helpers inside neovim
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
			})
		end
	},
	{ 'airblade/vim-rooter',            event = "VeryLazy" }, -- set project as pwd of vim
	{ 'christoomey/vim-tmux-navigator', lazy = false }, -- set project as pwd of vim
}

return plugins
