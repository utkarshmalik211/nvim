return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	config = function()
		require("nvim-tree").setup {
			update_focused_file = {
				enable = true,
			},
			view = {
			    side = 'right',
			    width = 40
			}
		}
	end,
	cmd = { "NvimTreeToggle", "NvimTreeRefresh" },
}
