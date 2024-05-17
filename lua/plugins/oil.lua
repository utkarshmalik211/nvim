function ConfigOil()
	require("oil").setup({})
end

return {
	'stevearc/oil.nvim', -- show all fucntions in file
	config = ConfigOil
}
