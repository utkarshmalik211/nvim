vim.cmd [[packadd nvim-colorizer.lua]]
require("colorizer").setup {
  ["*"] = {
    css = true,
    css_fn = true,
    mode = "background",
  },
}
