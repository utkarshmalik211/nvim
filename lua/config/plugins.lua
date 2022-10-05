vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- IMPORTANT
	use { 'wbthomason/packer.nvim', opt = true }
	use { 'nvim-lua/popup.nvim' }
	use { 'nvim-lua/plenary.nvim' }
	use { 'neovim/nvim-lspconfig' }
	use { 'kyazdani42/nvim-web-devicons' }

	-- treesitter
	use { 'nvim-treesitter/nvim-treesitter', opt = true, run = ':TSUpdate', } -- mostly for better syntax highlighting, but it has more stuff
	use { 'nvim-treesitter/nvim-treesitter-context', opt = true }
	use { 'nvim-treesitter/playground', opt = true }

	--telescope
	use { 'BurntSushi/ripgrep', opt = true }
	use { 'nvim-telescope/telescope.nvim', opt = false, } -- extensible fuzzy finder
	use { 'nvim-telescope/telescope-fzy-native.nvim', opt = false } -- fast search algo
	use { 'nvim-telescope/telescope-media-files.nvim', opt = false } -- media preview
	use { 'nvim-telescope/telescope-frecency.nvim', opt = false } -- media preview

	-- nvim cmp
	use { 'hrsh7th/nvim-cmp' }
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'hrsh7th/cmp-nvim-lua' }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/cmp-cmdline' }

	-- lua snips
	use { 'L3MON4D3/LuaSnip' }
	use { 'rafamadriz/friendly-snippets' }
	use { 'saadparwaiz1/cmp_luasnip' }

	-- dap for dabs
	use { 'mfussenegger/nvim-dap' }
	use { 'nvim-telescope/telescope-dap.nvim' } -- media preview
	use { 'rcarriga/nvim-dap-ui' }

	-- the new way to navigate
	use { 'ThePrimeagen/harpoon', opt = false }

	use { 'folke/trouble.nvim', opt = false }
	use { 'kyazdani42/nvim-tree.lua', opt = false }
	use { 'machakann/vim-sandwich', opt = true } -- surround words with symbol
	use { 'rust-lang/rust.vim', opt = true } -- surround words with symbol
	use { 'akinsho/nvim-toggleterm.lua', opt = false } -- set project as pwd of vim
	use { 'tpope/vim-fugitive', opt = false } -- git helpers inside neovim
	use { 'lewis6991/gitsigns.nvim' } -- show git stuff in signcolumn
	-- use { 'feline-nvim/feline.nvim', config = function() require 'plugins.statusline' end }
	use { 'nvim-lualine/lualine.nvim', config = function() require 'plugins.statusline' end } -- nice line
	use { 'catppuccin/nvim', as = "catppuccin", opt = false } -- nice colorscheme
	use { 'airblade/vim-rooter', opt = false } -- set project as pwd of vim
	use { 'folke/which-key.nvim', opt = false }
	use { 'norcalli/nvim-colorizer.lua', opt = true } -- colorize hex/rgb/hsl value
	use { 'takac/vim-hardtime' }

end)
