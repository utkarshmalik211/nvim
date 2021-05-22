local wk = require("which-key")

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
      d = { "<cmd> lua vim.lsp.buf.definition() <CR>", "Go to definition" },
      D = { "<cmd> lua vim.lsp.buf.declaration() <CR>", "Go to Declaration" },
      r = { "<cmd> lua vim.lsp.buf.references() <CR>", "Show References" },
      i = { "<cmd> lua vim.lsp.buf.implementation() <CR>", "Implementation" },
      h = { "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", "Hover" },
      s = { "<cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>", "Signature Help" },
  },
 ["ca"] = {"<cmd> Lspsaga code_action<CR>", "Code Action"},
})

