vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer can manage itself as an optional plugin
    use {'wbthomason/packer.nvim', opt = true}
    use {
        'glepnir/galaxyline.nvim', branch = 'main', config = function() require'plugins.statusline' end,
        requires = {'kyazdani42/nvim-web-devicons'},
    }
    use { "dracula/vim", opt = false } -- nice colorscheme
    use { "tomasiser/vim-code-dark", opt = false } -- nice colorscheme
    use { "windwp/nvim-autopairs", opt = true } -- autopairs brackets, braces etc
    use { "b3nj5m1n/kommentary", opt = true } -- comment stuff easier
    use { "brooth/far.vim", opt = false } -- project wide search and replace
    use { "tpope/vim-fugitive", opt = false } -- git helpers inside neovim
    use { "airblade/vim-rooter", opt = false } -- set project as pwd of vim
    use { 'mhinz/vim-startify', opt = false } -- set project as pwd of vim
    use { 'tpope/vim-commentary', opt = false } -- set project as pwd of vim
    use { 'akinsho/nvim-toggleterm.lua', opt = false } -- set project as pwd of vim
    use { 'folke/which-key.nvim', config = function()
         require("which-key").setup {
			triggers = {"<leader>"}
		}
	end
	}
    use {
      "mhartington/formatter.nvim",
      opt = true,
      cmd = "Format",
    } -- helper for fast formatting
    use { "norcalli/nvim-colorizer.lua", opt = true } -- colorize hex/rgb/hsl value
    use {
      "nvim-treesitter/nvim-treesitter",
      opt = true,
      run = ':TSUpdate',
    } -- mostly for better syntax highlighting, but it has more stuff
    use {
      "junegunn/goyo.vim",
      ft = { "text", "markdown" },
      opt = true,
    } -- no distraction mode a.k.a zen mode
    use {
      "junegunn/vim-easy-align",
      opt = false,
    } -- easy align using delimiter
    use { "kyazdani42/nvim-tree.lua", opt = true } -- super fast file tree viewer
    use { "akinsho/nvim-bufferline.lua", opt = true } -- snazzy bufferline
    use { "neovim/nvim-lspconfig", opt = true } -- builtin lsp config
    use { "glepnir/lspsaga.nvim", opt = true } -- better UI for builtin LSP
    use { "hrsh7th/nvim-compe", opt = true } -- better UI for builtin LSP
    use { "windwp/nvim-ts-autotag", opt = true } -- auto-close html tag
    use {
      "nvim-telescope/telescope.nvim",
      opt = false,
      requires = {
        { "nvim-lua/popup.nvim" },
        { "nvim-lua/plenary.nvim" }, -- more stdlib
        { "nvim-telescope/telescope-fzy-native.nvim" }, -- fast search algo
        { "nvim-telescope/telescope-media-files.nvim" }, -- media preview
        { "nvim-telescope/telescope-frecency.nvim" }, -- media preview
      },
    } -- extensible fuzzy finder
    use { "lewis6991/gitsigns.nvim", opt = true } -- show git stuff in signcolumn
     -- sort of like git blame but in floating window
    use { "machakann/vim-sandwich", opt = false } -- surround words with symbol
    use { "fatih/vim-go", opt = false } -- surround words with symbol
    use { "rust-lang/rust.vim", opt = false } -- surround words with symbol
    use {
      "glacambre/firenvim",
      run = function() vim.fn["firenvim#install"](13) end,
    }
    use {
      "mhinz/vim-sayonara",
      cmd = "Sayonara",
      opt = true,
    } -- better window and buffer management=
end) 
