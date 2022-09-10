local lsp = require('feline.providers.lsp')
local vi_mode_utils = require('feline.providers.vi_mode')

local force_inactive = {
	filetypes = {},
	buftypes = {},
	bufnames = {}
}

local winbar_components = {
	active = { {}, {}, {} },
	inactive = { {}, {}, {} },
}

local components = {
	active = { {}, {}, {} },
	inactive = { {}, {}, {} },
}


local vi_mode_colors = {
	NORMAL = 'green',
	OP = 'green',
	INSERT = 'red',
	CONFIRM = 'red',
	VISUAL = 'skyblue',
	LINES = 'skyblue',
	BLOCK = 'skyblue',
	REPLACE = 'violet',
	['V-REPLACE'] = 'violet',
	ENTER = 'cyan',
	MORE = 'cyan',
	SELECT = 'orange',
	COMMAND = 'green',
	SHELL = 'green',
	TERM = 'green',
	NONE = 'yellow'
}

local vi_mode_text = {
	NORMAL = ' Normal ',
	OP = ' OP ',
	INSERT = ' Insert ',
	VISUAL = ' Visual ',
	LINES = ' Lines ',
	BLOCK = ' Block ',
	REPLACE = ' Replace ',
	['V-REPLACE'] = ' V-Replace ',
	ENTER = ' Enter ',
	MORE = ' More ',
	SELECT = ' Select ',
	COMMAND = ' Command ',
	SHELL = ' Shell ',
	TERM = ' Term ',
	NONE = ' None ',
	CONFIRM = ' Confirm '
}


force_inactive.filetypes = {
	'NvimTree',
	'dbui',
	'packer',
	'startify',
	'fugitive',
	'fugitiveblame'
}

force_inactive.buftypes = {
	'terminal'
}

-- STATUSLINE
-- LEFT

-- vi-mode
components.active[1][1] = {
	provider = function()
		return vi_mode_text[vi_mode_utils.get_vim_mode()]
	end,
	hl = function()
		local val = {}
		val.bg = vi_mode_utils.get_mode_color()
		val.fg = 'black'
		val.style = 'bold'
		return val
	end,
	right_sep = ' '
}

-- MID
-- filename
components.active[2][1] = {
	provider = function()
		local filename  = vim.fn.expand('%:t')
		local extension = vim.fn.expand('%:e')
		local icon      = require 'nvim-web-devicons'.get_icon(filename, extension)
		if icon == nil then
			icon = ''
		end
		return icon .. " " .. vim.fn.expand("%:.")
	end,
	hl = function()
		local val        = {}
		local filename   = vim.fn.expand('%:t')
		local extension  = vim.fn.expand('%:e')
		local icon, name = require 'nvim-web-devicons'.get_icon(filename, extension)
		if icon ~= nil then
			val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
		else
			val.fg = 'white'
		end
		val.bg = 'bg'
		val.style = 'bold'
		return val
	end,
	right_sep = ' '
}

-- RIGHT
-- gitBranch
components.active[3][1] = {
	provider = 'git_branch',
	hl = {
		fg = 'yellow',
		bg = 'bg',
		style = 'bold'
	}
}
-- diffAdd
components.active[3][2] = {
	provider = 'git_diff_added',
	hl = {
		fg = 'green',
		bg = 'bg',
		style = 'bold'
	}
}
-- diffModfified
components.active[3][3] = {
	provider = 'git_diff_changed',
	hl = {
		fg = 'orange',
		bg = 'bg',
		style = 'bold'
	}
}
-- diffRemove
components.active[3][4] = {
	provider = 'git_diff_removed',
	hl = {
		fg = 'red',
		bg = 'bg',
		style = 'bold'
	},
	right_sep = '  '
}


components.active[3][5] = {
	provider = 'position',
	hl = {
		fg = 'white',
		bg = 'bg',
		style = 'bold'
	},
	right_sep = ' '
}

-- INACTIVE

-- fileType
components.inactive[1][1] = {
	provider = 'file_type',
	hl = {
		fg = 'black',
		bg = 'cyan',
		style = 'bold'
	},
	left_sep = {
		str = ' ',
		hl = {
			fg = 'NONE',
			bg = 'cyan'
		}
	},
	right_sep = {
		{
			str = ' ',
			hl = {
				fg = 'NONE',
				bg = 'cyan'
			}
		},
		' '
	}
}

-- WINBAR
-- LEFT


-- MID
-- filename
winbar_components.active[2][1] = {
	provider = function()
		local filename  = vim.fn.expand('%:t')
		local extension = vim.fn.expand('%:e')
		local icon      = require 'nvim-web-devicons'.get_icon(filename, extension)
		if icon == nil then
			icon = ''
		end
		return icon .. " " .. filename
	end,
	hl = function()
		local val        = {}
		local filename   = vim.fn.expand('%:t')
		local extension  = vim.fn.expand('%:e')
		local icon, name = require 'nvim-web-devicons'.get_icon(filename, extension)
		if icon ~= nil then
			val.fg = vim.fn.synIDattr(vim.fn.hlID(name), 'fg')
		else
			val.fg = 'white'
		end
		val.bg = 'bg'
		val.style = 'bold'
		return val
	end,
	right_sep = ' '
}
-- RIGHT
-- LspName
winbar_components.active[3][1] = {
	provider = 'lsp_client_names',
	hl = {
		fg = 'yellow',
		style = 'bold'
	},
	right_sep = ' '
}
-- diagnosticErrors
winbar_components.active[3][2] = {
	provider = 'diagnostic_errors',
	enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR) end,
	hl = {
		fg = 'red',
		style = 'bold'
	}
}
-- diagnosticWarn
winbar_components.active[3][3] = {
	provider = 'diagnostic_warnings',
	enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.WARN) end,
	hl = {
		fg = 'yellow',
		style = 'bold'
	}
}
-- diagnosticHint
winbar_components.active[3][4] = {
	provider = 'diagnostic_hints',
	enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.HINT) end,
	hl = {
		fg = 'cyan',
		style = 'bold'
	}
}
-- diagnosticInfo
winbar_components.active[3][5] = {
	provider = 'diagnostic_info',
	enabled = function() return lsp.diagnostics_exist(vim.diagnostic.severity.INFO) end,
	hl = {
		fg = 'skyblue',
		style = 'bold'
	}
}

-- INACTIVE

-- fileType
winbar_components.inactive[1][1] = {
	provider = 'file_type',
	hl = {
		fg = 'black',
		bg = 'cyan',
		style = 'bold'
	},
	left_sep = {
		str = ' ',
		hl = {
			fg = 'NONE',
			bg = 'cyan'
		}
	},
	right_sep = {
		{
			str = ' ',
			hl = {
				fg = 'NONE',
				bg = 'cyan'
			}
		},
		' '
	}
}

require('feline').setup({
	vi_mode_colors = vi_mode_colors,
	components = components,
	force_inactive = force_inactive,
})

require('feline').winbar.setup({
	components = winbar_components,
	force_inactive = force_inactive,
})
