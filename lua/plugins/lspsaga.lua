vim.cmd [[packadd lspsaga.nvim]]
local saga = require 'lspsaga'

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = 'ﯧ',
  border_style = 1,
}
