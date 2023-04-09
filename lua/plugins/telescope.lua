function ConfigTelescope()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local previewers = require("telescope.previewers")
	pcall(require("telescope").load_extension, "fzy_native") -- superfast sorter

	telescope.setup({
		defaults = {
			file_previewer     = previewers.vim_buffer_cat.new,
			grep_previewer     = previewers.vim_buffer_vimgrep.new,
			qflist_previewer   = previewers.vim_buffer_qflist.new,
			scroll_strategy    = "cycle",
			selection_strategy = "reset",
			layout_strategy    = "flex",
			initial_mode       = "insert",
			borderchars        = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
			layout_defaults    = {
				horizontal = {
					width_padding  = 0.1,
					height_padding = 0.1,
					preview_width  = 0.6,
				},
				vertical = {
					width_padding  = 0.05,
					height_padding = 1,
					preview_height = 0.5,
				},
			},
			mappings           = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<CR>"]  = actions.select_default + actions.center,
					["<C-v>"] = actions.select_vertical,
					["<C-x>"] = actions.select_horizontal,
					["<C-t>"] = actions.select_tab,
					["<C-c>"] = actions.close,
					["<Esc>"] = actions.close,
					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,
					["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					["<Tab>"] = actions.toggle_selection,
					-- ['<C-s>'] = actions.open_selected_files,
					-- ['<C-a>'] = actions.cycle_previewers_prev,
					-- ['<C-w>l'] = actions.preview_switch_window_right,
				},
				n = {
					["<CR>"]  = actions.select_default + actions.center,
					["<C-v>"] = actions.select_vertical,
					["<C-x>"] = actions.select_horizontal,
					["<C-t>"] = actions.select_tab,
					["<Esc>"] = actions.close,
					["j"]     = actions.move_selection_next,
					["k"]     = actions.move_selection_previous,
					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,
					["<C-q>"] = actions.send_to_qflist,
					["<Tab>"] = actions.toggle_selection,
					-- ["<C-w>l"] = actions.preview_switch_window_right,
				},
			},
		},
		extensions = {
			fzy_native = {
				override_generic_sorter = true,
				override_file_sorter = true,
			},
			media_files = {
				filetypes = { "png", "webp", "jpg", "jpeg", "pdf", "mkv" },
				find_cmd  = "rg",
			},
			frecency = {
				show_scores     = false,
				show_unindexed  = true,
				ignore_patterns = { "*.git/*", "*/tmp/*" },
				workspaces      = {
					["nvim"]        = "~/.config/nvim",
					["redirection"] = "~/dev/redirection",
				},
			},
			arecibo = {
				["selected_engine"]   = "google",
				["url_open_command"]  = "open",
				["show_http_headers"] = false,
				["show_domain_icons"] = false,
			},
		},
	})
end

return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		{ 'BurntSushi/ripgrep',                        lazy = true },
		{ 'nvim-telescope/telescope-fzy-native.nvim',  lazy = true }, -- fast search algo
		{ 'nvim-telescope/telescope-media-files.nvim', lazy = true }, -- media preview
		{ 'nvim-telescope/telescope-frecency.nvim',    lazy = true },
		{ 'nvim-telescope/telescope-dap.nvim',         lazy = true },
	},
	lazy = true,
	cmd = { "Telescope" },
	config = ConfigTelescope,
}
