function ConfigLuaSnips()
	local ls = require('luasnip')
	local types = require("luasnip.util.types")
	require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets" })
	ls.config.set_config({
		history = true,
		-- Update more often, :h events for more info.
		update_events = "TextChanged,TextChangedI",
		-- Snippets aren't automatically removed if their text is deleted.
		-- `delete_check_events` determines on which events (:h events) a check for
		-- deleted snippets is performed.
		-- This can be especially useful when `history` is enabled.
		delete_check_events = "TextChanged",
		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = { { "", "Comment" } },
				},
			},
		},
		-- treesitter-hl has 100, use something higher (default is 200).
		ext_base_prio = 300,
		-- minimal increase in priority.
		ext_prio_increase = 1,
		enable_autosnippets = true,
		-- mapping for cutting selected text so it's usable as SELECT_DEDENT,
		-- SELECT_RAW or TM_SELECTED_TEXT (mapped via xmap).
		store_selection_keys = "<Tab>",
		-- luasnip uses this function to get the currently active filetype. This
		-- is the (rather uninteresting) default, but it's possible to use
		-- eg. treesitter for getting the current filetype by setting ft_func to
		-- require("luasnip.extras.filetype_functions").from_cursor (requires
		-- `nvim-treesitter/nvim-treesitter`). This allows correctly resolving
		-- the current filetype in eg. a markdown-code block or `vim.cmd()`.
		ft_func = function()
			return vim.split(vim.bo.filetype, ".", true)
		end,
	})

	-- More Settings --

	vim.keymap.set("n", "<Leader><CR>", "<cmd>LuaSnipEdit<cr>", { silent = true, noremap = true })
	vim.cmd([[autocmd BufEnter */snippets/*.lua nnoremap <silent> <buffer> <CR> /-- End Refactoring --<CR>O<Esc>O]])
end

return {
	-- lua snips
	'L3MON4D3/LuaSnip',
	dependencies = {
		{ 'saadparwaiz1/cmp_luasnip' }
	},
	event = "InsertEnter",
	config = ConfigLuaSnips,
}
