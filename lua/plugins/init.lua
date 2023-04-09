local plugins = {
	'nvim-lua/popup.nvim',
	'nvim-lua/plenary.nvim',
	'neovim/nvim-lspconfig',
	'kyazdani42/nvim-web-devicons',
	{ 'mbbill/undotree',        event = "VeryLazy" },
	-- dap for dabs
	{ 'mfussenegger/nvim-dap' },
	{ 'rcarriga/nvim-dap-ui' },

	-- the new way to navigate
	{ 'ThePrimeagen/harpoon',   event = "VeryLazy" },
	{ 'machakann/vim-sandwich', event = { "InsertEnter" } },
	{ 'rust-lang/rust.vim',     ft = { "rs" } },
	{ 'tpope/vim-fugitive',     cmd = { "Git", "G" } }, -- git helpers inside neovim
	-- { 'catppuccin/nvim', name = "catppuccin", config = function() require("catppuccin").setup() end, lazy = false }, -- nice colorscheme
	{
		'rebelot/kanagawa.nvim',
		lazy = false,
		config = function()
			require('kanagawa').setup({})
		end
	},
	{ 'airblade/vim-rooter', cmd = { "Rooter", "RooterToggle" } }, -- set project as pwd of vim
}

return plugins
