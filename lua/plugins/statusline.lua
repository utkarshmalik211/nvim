function ConfigStatusLine()
	require('lualine').setup({
		options = {
			icons_enabled = true,
			theme = 'auto',
			section_separators = '',
			component_separators = '',
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = true,
			refresh = {
				statusline = 1000,
				tabline = 1200,
				winbar = 1200,
			}
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'branch', 'diff', 'diagnostics' },
			lualine_c = {
				{
					function() return "%=" end,
					component_separators = ''
				},
				'filename'
			},
			lualine_x = { 'filetype' },
			lualine_y = { 'progress' },
			lualine_z = { 'location' }
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { 'filename' },
			lualine_x = { 'location' },
			lualine_y = {},
			lualine_z = {}
		},
		extensions = {}
	})
end

return { 'nvim-lualine/lualine.nvim', lazy = false, config = ConfigStatusLine }
