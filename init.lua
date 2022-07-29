-- init.lua
-- Remap leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.viminfo = '100,n$HOME/.config/nvim/viminfo'
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4


require('modules.keymappings') -- load key bindings
require('modules.settings') -- load vim settings 

require('modules.plugins') -- load plugins

require('plugins.nvimtree') -- load file explorere
require('plugins.treesitter') -- load treesitter
require('plugins.vim-rooter') -- load vimrooter 
require('plugins.vim-go') -- vim go config
require('plugins.plug-colorizer') -- vim colorize colour codes
require('plugins.which-key') -- vim which key
require('plugins.gitsigns') -- vim gitsigns

require('plugins.completions')
require('plugins.lsp')
require('plugins.luasnips') -- load code snippets
require('plugins.toggleterm')

require('modules.theme')
