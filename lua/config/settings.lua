local o = vim.o
local wo = vim.wo
local bo = vim.bo
local opt = vim.opt
local g = vim.g

o.termguicolors = true
o.syntax = 'enable' --  Enables syntax highlighing
o.hidden = true --  Required to keep multiple buffers open multiple buffers
o.encoding = 'utf-8' --  The encoding displayed
o.whichwrap = o.whichwrap .. '<,>,[,],h,l'
o.swapfile = false

o.pumheight = 10 --  Makes popup menu smaller
o.fileencoding = 'utf-8' --  The encoding written to file
o.ruler = true --  Show the cursor position all the time
o.splitbelow = true --  Horizontal splits will automatically be below
o.splitright = true --  Vertical splits will automatically be to the right
o.autoindent = true --  Good auto indent
o.background = 'dark' --  tell vim what the background color looks like
o.showtabline = 1 --  Always show tabs
o.showmode = false --  We don't need to see things like -- INSERT -- anymore
o.backup = false --  This is recommended by coc
o.writebackup = false --  This is recommended by coc
o.shortmess = o.shortmess .. 'c' --  Don't pass messages to |ins-completion-menu|.
o.updatetime = 300 --  Faster completion
o.timeoutlen = 400 --  By default timeoutlen is 1000 ms
o.clipboard = 'unnamedplus' --  Copy paste between vim and everything else
o.incsearch = true
o.scrolloff = 7
o.sidescrolloff = 7
o.laststatus = 3
o.smarttab = true --  Makes tabbing smarter will realize you have 2 vs 4
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldnestmax = 10
o.foldlevel = 9
o.autoread = true
o.cmdheight = 0

opt.undodir = "/Users/utkarshmalik/.config/nvim/.undo"
opt.undofile = true
opt.undolevels = 100
opt.undoreload = 100
opt.mouse = ""
opt.equalalways = true

wo.conceallevel = 0 --  So that I can see `` in markdown files
wo.wrap = false --  Display long lines as just one line
wo.signcolumn = 'yes' --  Always show the signcolumn, otherwise it would shift the text each time
wo.number = true --  Line numbers
wo.relativenumber = true --  Line numbers
wo.cursorline = true --  Enable highlighting of the current line

bo.tabstop = 4 --  Insert 2 spaces for a tab
bo.softtabstop = 4 --  Insert 2 spaces for a tab
bo.shiftwidth = 4 --  Change the number of space characters inserted for indentation
bo.expandtab = true --  Converts tabs to spaces
bo.smartindent = true --  Makes indenting smart

bo.formatoptions = bo.formatoptions:gsub('cro', '') -- Stop newline continution of commenaaaaats

