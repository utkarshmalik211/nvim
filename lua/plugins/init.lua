local plugins = {
	'nvim-lua/popup.nvim',
	'nvim-lua/plenary.nvim',
	'neovim/nvim-lspconfig',
	'kyazdani42/nvim-web-devicons',
	'mbbill/undotree',
	'lewis6991/gitsigns.nvim', -- show git stuff in signcolumn
	'nvim-lualine/lualine.nvim', -- nice line
	-- dap for dabs
	{ 'mfussenegger/nvim-dap' },
	{ 'rcarriga/nvim-dap-ui' },

	-- the new way to navigate
	{ 'ThePrimeagen/harpoon', lazy = false },

	{ 'folke/trouble.nvim', lazy = false },
	{ 'machakann/vim-sandwich', event = { "InsertEnter" } },
	{ 'rust-lang/rust.vim', ft = { "rs" } },
	{ 'akinsho/nvim-toggleterm.lua', lazy = false },
	{ 'tpope/vim-fugitive', cmd = { "Git", "G" } }, -- git helpers inside neovim
	{ 'catppuccin/nvim', name = "catppuccin", lazy = false }, -- nice colorscheme
	{ 'airblade/vim-rooter', cmd = { "Rooter", "RooterToggle" } }, -- set project as pwd of vim
	{ 'folke/which-key.nvim', lazy = false },
	{ 'norcalli/nvim-colorizer.lua' }, -- colorize hex/rgb/hsl value
}

return plugins
