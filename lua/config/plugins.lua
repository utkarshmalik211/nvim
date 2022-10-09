local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system {
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	}
	print "Installing packer close and reopen Neovim..."
	vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init {
	display = {
		open_fn = function()
			return require("packer.util").float { border = "rounded" }
		end,
	},
}

-- Install your plugins here
return packer.startup(function(use)
	-- IMPORTANT
	use { 'wbthomason/packer.nvim' }
	use { 'nvim-lua/popup.nvim' }
	use { 'nvim-lua/plenary.nvim' }
	use { 'neovim/nvim-lspconfig' }
	use { 'kyazdani42/nvim-web-devicons' }

	use {
		-- treesitter
		'nvim-treesitter/nvim-treesitter',
		opt = true,
		run = ':TSUpdate',
		requires = {
			{ 'nvim-treesitter/nvim-treesitter-context', opt = true },
			{ 'nvim-treesitter/playground', opt = true },
		},
		config = function() require "plugins.treesitter" end,
	}

	use {
		--telescope
		'nvim-telescope/telescope.nvim',
		opt = true,
		cmd = { "Telescope" },
		requires = {
			{ 'BurntSushi/ripgrep', opt = true },
			{ 'nvim-telescope/telescope-fzy-native.nvim', opt = true }, -- fast search algo
			{ 'nvim-telescope/telescope-media-files.nvim', opt = true }, -- media preview
			{ 'nvim-telescope/telescope-frecency.nvim', opt = true },
			{ 'nvim-telescope/telescope-dap.nvim', opt = true },
		},
		config = function() require "plugins.telescope" end,
	}

	-- nvim cmp
	use { 'hrsh7th/nvim-cmp' }
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'hrsh7th/cmp-nvim-lua', opt = true, ft = { "lua" } }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/cmp-cmdline' }

	-- lua snips
	use { 'L3MON4D3/LuaSnip' }
	use { 'rafamadriz/friendly-snippets' }
	use { 'saadparwaiz1/cmp_luasnip' }

	-- dap for dabs
	use { 'mfussenegger/nvim-dap', opt = true }
	use { 'rcarriga/nvim-dap-ui', opt = true }

	-- the new way to navigate
	use { 'ThePrimeagen/harpoon', opt = true, event = { "BufRead" } }

	use { 'folke/trouble.nvim', opt = true, cmd = { "Trouble", "TroubleToggle" } }
	use {
		'kyazdani42/nvim-tree.lua',
		opt = true,
		cmd = { "NvimTreeToggle" },
		config = function() require 'plugins.nvimtree' end,
	}
	use { 'machakann/vim-sandwich', opt = true, event = { "InsertEnter" } } -- surround words with symbol
	use { 'rust-lang/rust.vim', opt = true, ft = { "rs" } } -- surround words with symbol
	use {
		'akinsho/nvim-toggleterm.lua',
		opt = true,
		cmd = { "ToggleTerm" },
		config = function() require('plugins.toggleterm') end,
	}
	use { 'tpope/vim-fugitive', opt = true, cmd = { "Git", "G" } } -- git helpers inside neovim
	use { 'lewis6991/gitsigns.nvim', opt = true, event = { "BufReadPost" },
		config = function() require 'plugins.gitsigns' end } -- show git stuff in signcolumn
	use {
		'nvim-lualine/lualine.nvim',
		config = function() require 'plugins.statusline' end,
	} -- nice line
	use { 'catppuccin/nvim', as = "catppuccin", opt = false } -- nice colorscheme
	use {
		'airblade/vim-rooter',
		opt = true,
		cmd = { "Rooter", "RooterToggle" },
		config = function() require 'plugins.vim-rooter' end
	} -- set project as pwd of vim
	use { 'folke/which-key.nvim', opt = false }
	use { 'norcalli/nvim-colorizer.lua', opt = true } -- colorize hex/rgb/hsl value
	use { 'takac/vim-hardtime' }

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
