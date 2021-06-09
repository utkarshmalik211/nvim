-- init.lua

-- Remap leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "


require('modules.plugins')  -- load plugins

require('modules.keymappings') -- load key bindings
require('modules.settings') -- load vim settings 

require('plugins.nvimtree') -- load file explorere
require('plugins.bufferline') -- load top bufferline
require('plugins.treesitter') -- load top bufferline
require('plugins.vim-rooter') -- load vimrooter 
require('plugins.vim-go') -- vim go config
require('plugins.lspsaga') -- lspsaga
require('plugins.plug-colorizer') -- vim colorize colour codes
require('plugins.which-key') -- vim colorize colour codes

require('plugins.lsp')
require('plugins.compe')
require('plugins.toggleterm')

vim.cmd [[colorscheme dracula]]
vim.g.guifont = "CasaydiaCove Nerd Font Regular:h14"