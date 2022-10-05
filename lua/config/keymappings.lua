-- keymappings.lua


local map = vim.api.nvim_set_keymap
local cmd = vim.cmd

local options = { noremap = true }

-- Not an editor command: Wqa
cmd(':command! WQ wq')
cmd(':command! WQ wq')
cmd(':command! Wq wq')
cmd(':command! Wqa wqa')
cmd(':command! W w')
cmd(':command! Q q')

--  Basic Key Mappings
map('i', '<C-h>', '<C-w>h', options)
map('i', '<C-j>', '<C-w>j', options)
map('i', '<C-k>', '<C-w>k', options)
map('i', '<C-l>', '<C-w>l', options)

--  Remove annoying ExMode
map('n', 'Q', '<Nop> ', options)
map('n', 'q:', '<Nop> ', options)

--  Better window navigation
map('n', '<C-h>', '<C-w>h', options)
map('n', '<C-j>', '<C-w>j', options)
map('n', '<C-k>', '<C-w>k', options)
map('n', '<C-l>', '<C-w>l', options)


--  Better indenting
map('v', '<', '<gv', options)
map('v', '>', '>gv', options)

--  I hate escape more than anything else
map('i', 'jk', '<Esc>', options)
map('i', 'kj', '<Esc>', options)

--  Use alt + hjkl to resize windows
map('n', '<M-j>', ':resize -2<CR>', options)
map('n', '<M-k>', ':resize +2<CR>', options)
map('n', '<M-h>', ':vertical resize -2<CR>', options)
map('n', '<M-l>', ':vertical resize +2<CR>', options)

-- toggle telescope.nvim
options = { noremap = true }
-- esc behaves as esc in terminal mode
map('t', '<Esc>', '<C-\\><C-n>', options)
