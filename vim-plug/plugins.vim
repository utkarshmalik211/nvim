" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

" Better Comments
Plug 'tpope/vim-commentary'
" Change dates fast
Plug 'tpope/vim-speeddating'
" Convert binary, hex, etc..
Plug 'glts/vim-radical'
" Repeat stuff
Plug 'tpope/vim-repeat'
" Text Navigation
Plug 'unblevable/quick-scope'
" Useful for React Commenting 
Plug 'suy/vim-context-commentstring'
" Easymotion
Plug 'easymotion/vim-easymotion'
" Surround
Plug 'tpope/vim-surround'
" Have the file system follow you around
Plug 'airblade/vim-rooter'
" auto set indent settings
Plug 'tpope/vim-sleuth'
" Better Syntax Support
Plug 'sheerun/vim-polyglot'
" Treesitter
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/playground'
" Cool Icons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
" Auto pairs for '(' '[' '{'
Plug 'jiangmiao/auto-pairs'
" Closetags
Plug 'alvan/vim-closetag'
" Themes
Plug 'christianchiarulli/nvcode-color-schemes.vim'
" Intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Status Line
Plug 'glepnir/galaxyline.nvim'
Plug 'kevinhwang91/rnvimr'
" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf.vim'
" Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" Terminal
Plug 'voldikss/vim-floaterm'
" Start Screen
Plug 'mhinz/vim-startify'
" Vista
" See what keys do like in emacs
Plug 'liuchengxu/vim-which-key'
" Zen mode
Plug 'junegunn/goyo.vim'
" Better tabline
Plug 'romgrk/barbar.nvim'
" Smooth scroll
Plug 'psliwka/vim-smoothie'
Plug 'mattn/webapi-vim'
" Colorizer
Plug 'norcalli/nvim-colorizer.lua'
" Intuitive buffer closing
Plug 'moll/vim-bbye'
" Debugging
Plug 'puremourning/vimspector'
Plug 'szw/vim-maximizer'
" Neovim in Browser
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(69) } }
" golang  support
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
