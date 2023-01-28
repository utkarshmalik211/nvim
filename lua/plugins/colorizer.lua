function ConfigColourizer()
	require("colorizer").setup {
		["*"] = {
			css = true,
			css_fn = true,
			mode = "background",
		},
	}
end

return { 'norcalli/nvim-colorizer.lua', config = ConfigColourizer }
