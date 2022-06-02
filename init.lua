-- init.lua

-- Remap leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.viminfo='100,n$HOME/.config/nvim/viminfo'



require('modules.keymappings') 	-- load key bindings
require('modules.settings') 	-- load vim settings 

require('modules.plugins')  	-- load plugins

require('plugins.nvimtree') 	-- load file explorere
require('plugins.bufferline') 	-- load top bufferline
require('plugins.treesitter') 	-- load top bufferline
require('plugins.vim-rooter') 	-- load vimrooter 
require('plugins.vim-go') 	-- vim go config
require('plugins.plug-colorizer') -- vim colorize colour codes
require('plugins.which-key') 	-- vim which key
require('plugins.gitsigns') 	-- vim gitsigns

require('plugins.lsp')
require('plugins.completions')
require('plugins.toggleterm')

require('modules.theme')
