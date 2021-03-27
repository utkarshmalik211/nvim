-- keymappings.lua


local map = vim.api.nvim_set_keymap
local cmd = vim.cmd


-- map the leader key
map('n', '<Space>', '', {})

options = { noremap = true }

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
map('n', 'Q','<Nop> ', options)
map('n', 'q:','<Nop> ', options)

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


--  TAB in general mode will move to text buffer
map('n', '<TAB>', ':BufferLineCycleNext<CR>', options)
--  SHIFT-TAB will go back
map('n', '<S-TAB>', ':BufferLineCyclePrev<CR>', options)

-- nvimtree
map('n', '<leader>e', ':NvimTreeToggle<CR>', options)
map('n', '<leader>r', ':NvimTreeRefresh<CR>', options)
map('n', '<leader>n', ':NvimTreeFindFile<CR>', options)


--  Use alt + hjkl to resize windows
map('n', '<M-j>',':resize -2<CR>', options)
map('n', '<M-k>',':resize +2<CR>', options)
map('n', '<M-h>',':vertical resize -2<CR>', options)
map('n', '<M-l>',':vertical resize +2<CR>', options)

-- lsp key bindings
options = { noremap = true , silent = true}
map('n','gd',  '<Cmd> lua vim.lsp.buf.definition() <CR>', options)
map('n','gD',  '<Cmd> lua vim.lsp.buf.declaration() <CR>', options)
map('n','gr',  '<Cmd> lua vim.lsp.buf.references() <CR>', options)
map('n','gi',  '<Cmd> lua vim.lsp.buf.implementation() <CR>', options)
map('n','ca',  ':Lspsaga code_action<CR>', options)
map('n', 'K',"<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", options)
map('n', '<C-k>', '<Cmd> lua vim.lsp.buf.signature_help() <CR>', options)
map('n', '<C-p>', ':Lspsaga diagnostic_jump_prev<CR>', options)
map('n', '<C-n>', ':Lspsaga dignostic_jump_next<CR>', options)
map('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", options)
map('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", options)
map('n', 'gs', "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", options)

--comment stuff out 
map('v', '<space>/', ':Commentary<CR>', options)
map('n', '<space>/', ':Commentary<CR>', options)


-- toggle telescope.nvim
options = { noremap = true }

map('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files()<cr>", options)
map('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep()<cr>", options)
map('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", options)
map('n', '<leader>fh', "<cmd>lua require('telescope.builtin').help_tags()<cr>", options)

--  Better nav for omnicomplete
--inoremap <expr> <c-j> ("\<C-n>")
--inoremap <expr> <c-k> ("\<C-p>")


--  Move selected line / block of text in visual mode
--  shift + k to move up
--  shift + j to move down
--xnoremap K :move '<-2<CR>gv-gv
--xnoremap J :move '>+1<CR>gv-gv

--  Alternate way to save
--nnoremap <silent> <C-s> :w<CR>
--  Alternate way to quit
--nnoremap <silent> <C-Q> :wq!<CR>
--  Use control-c instead of escape
--nnoremap <silent> <C-c> <Esc>
--  <TAB>: completion.
--inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

--nnoremap <C-h> <C-w>h
--nnoremap <C-j> <C-w>j
--nnoremap <C-k> <C-w>k
--nnoremap <C-l> <C-w>l

--  Terminal window navigation
--tnoremap <C-h> <C-\><C-N><C-w>h
--tnoremap <C-j> <C-\><C-N><C-w>j
--tnoremap <C-k> <C-\><C-N><C-w>k
--tnoremap <C-l> <C-\><C-N><C-w>l
--inoremap <C-h> <C-\><C-N><C-w>h
--inoremap <C-j> <C-\><C-N><C-w>j
--inoremap <C-k> <C-\><C-N><C-w>k
--inoremap <C-l> <C-\><C-N><C-w>l
--tnoremap <Esc> <C-\><C-n>


