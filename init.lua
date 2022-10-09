-- init.lua
-- Remap leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.viminfo = '100,n$HOME/.config/nvim/viminfo'
vim.bo.expandtab = true
vim.bo.shiftwidth = 4
vim.bo.tabstop = 4

require('config.keymappings') -- load key bindings
require('config.settings') -- load vim settings

require('config.plugins') -- load plugins

require('plugins.plug-colorizer') -- vim colorize colour codes
require('plugins.which-key') -- vim which key

require('plugins.completions')
require('plugins.lsp')
require('plugins.luasnips') -- load code snippets

require('config.theme')
require('custom.functions')
require('custom.augroups')

vim.g.hardtime_default_on = 1
