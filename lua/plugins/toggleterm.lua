function ConfigToggleTerm()
	require("toggleterm").setup {
		-- size can be a number or function which is passed the current terminal
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		open_mapping = [[<c-t>]],
		shade_filetypes = {},
		shade_terminals = true,
		-- shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
		shell = vim.o.shell,
		start_in_insert = false,
		persist_size = true,
		direction = 'horizontal',
	}

end

return { 'akinsho/nvim-toggleterm.lua', lazy = false, config = ConfigToggleTerm }
