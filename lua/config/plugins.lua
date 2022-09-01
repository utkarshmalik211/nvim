vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself as an optional plugin
	use { 'wbthomason/packer.nvim', opt = true }
	use { "nvim-lua/popup.nvim" }
	use { "nvim-lua/plenary.nvim" } -- more stdlib
	use { "nvim-telescope/telescope-fzy-native.nvim" } -- fast search algo
	use { "nvim-telescope/telescope-media-files.nvim" } -- media preview
	use { "nvim-telescope/telescope-frecency.nvim" } -- media preview
	use { "kyazdani42/nvim-web-devicons" }
	use { 'feline-nvim/feline.nvim', config = function() require 'plugins.statusline' end }
	use { "navarasu/onedark.nvim", opt = false } -- nice colorscheme
	use { "b3nj5m1n/kommentary", opt = true } -- comment stuff easier
	use { "tpope/vim-fugitive", opt = false } -- git helpers inside neovim
	use { "airblade/vim-rooter", opt = false } -- set project as pwd of vim
	use { 'akinsho/nvim-toggleterm.lua', opt = false } -- set project as pwd of vim
	use { "folke/trouble.nvim" }
	use { 'folke/which-key.nvim' }
	use { "norcalli/nvim-colorizer.lua", opt = true } -- colorize hex/rgb/hsl value
	use { "nvim-treesitter/nvim-treesitter", opt = true, run = ':TSUpdate', } -- mostly for better syntax highlighting, but it has more stuff
	use { "nvim-treesitter/nvim-treesitter-context", opt = true }
	use { 'kyazdani42/nvim-tree.lua' }
	use { "nvim-telescope/telescope.nvim", opt = false, } -- extensible fuzzy finder
	use { "lewis6991/gitsigns.nvim" } -- show git stuff in signcolumn
	use { "machakann/vim-sandwich", opt = false } -- surround words with symbol
	use { "fatih/vim-go", opt = false } -- surround words with symbol
	use { "rust-lang/rust.vim", opt = false } -- surround words with symbol
	use { "mhinz/vim-sayonara", cmd = "Sayonara", opt = true, } -- better window and buffer management=
	use { 'neovim/nvim-lspconfig' }
	use { 'hrsh7th/nvim-cmp' }
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'hrsh7th/cmp-nvim-lua' }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/cmp-cmdline' }
	use { 'L3MON4D3/LuaSnip' }
	use { 'rafamadriz/friendly-snippets' }
	use { 'saadparwaiz1/cmp_luasnip' }
end)
