local wk = require("which-key")
opts = {
  mode = "n", -- NORMAL mode
  -- prefix: use "<leader>f" for example for mapping everything related to finding files
  -- the prefix is prepended to every mapping part of `mappings`
  prefix = "", 
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}
wk.register({
  ["<leader>"] = {
    f = {
      name = "+file",
      f = { "<cmd>Telescope find_files<cr>", "Find File" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      g = { "<cmd>Telescope live_grep<cr>", "Search" },
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      n = { "<cmd>enew<cr>", "New File" },
    },
    e = {"<cmd>NvimTreeToggle<CR>", "Open Explorer"},
    r = {"<cmd>NvimTreeRefresh<CR>", "Refresh Explorer"}
  },
  ["<leader>/"] = {"<cmd> Commentary<CR>", "Comment"},
  ["<TAB>"] = {"<cmd> BufferLineCycleNext<CR>", "Next Buffer"},
  ["<S-TAB>"] = {"<cmd> BufferLineCyclePrev<CR>", "Previous Buffer"},
  ["g"] = {
      name = "+LSP",
      d = { "<cmd> lua require'lspsaga.provider'.preview_definition()<CR>", "Show definition" },
      D = { "<cmd> lua vim.lsp.buf.declaration() <CR>", "Go to Declaration" },
      r = { "<cmd> lua vim.lsp.buf.references() <CR>", "Show References" },
      i = { "<cmd> lua vim.lsp.buf.implementation() <CR>", "Implementation" },
      h = { "<cmd> lua require'lspsaga.provider'.lsp_finder()<CR>", "LSP Finder" },
      s = { "<cmd> lua require('lspsaga.signaturehelp').signature_help()<CR>", "Signature Help" },
  },
 ["ca"] = {"<cmd> Lspsaga code_action<CR>", "Code Action"},
 ["K"] = {"<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", "Hover"},
 ["<C-p>"] = {"<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", "Previous Error"},
 ["<C-n>"] = {"<cmd>lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", "Previous Error"},
 ["<C-f>"] = {"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", "Smart Scroll up"},
 ["<C-b>"] = {"<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", "Smart Scroll down"},
}, opts)

