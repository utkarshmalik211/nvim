function ConfigCompletions()
	local cmp = require('cmp')
	local luasnip = require('luasnip')

	local kind_icons = {
		Text = "",
		Method = "m",
		Function = "",
		Constructor = "",
		Field = "",
		Variable = "",
		Class = "",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "",
		Enum = "",
		Keyword = "",
		Snippet = "",
		Color = "",
		File = "",
		Reference = "",
		Folder = "",
		EnumMember = "",
		Constant = "",
		Struct = "",
		Event = "",
		Operator = "",
		TypeParameter = "",
	}

	local check_backspace = function()
		local col = vim.fn.col "." - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		mapping = {
			["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<C-e>"] = cmp.mapping { i = cmp.mapping.abort(), c = cmp.mapping.close() },
			["<C-y>"] = cmp.config.disable,
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<CR>"] = cmp.mapping.confirm { select = true },
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif check_backspace() then
					fallback()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
				vim_item.menu = ({
					buffer = "[buf]",
					nvim_lsp = "[lsp]",
					nvim_lua = "[api]",
					luasnip = "[snip]",
					path = "[path]",
				})[entry.source.name]
				return vim_item
			end,
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			{ name = 'path' },
			{ name = 'nvim_lua' },
			{ name = 'buffer',  keyword_length = 3 }
		},
	})
	require "fidget".setup {}
end

return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/cmp-nvim-lua' },
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/cmp-path' },
		{ 'hrsh7th/cmp-cmdline' },
		{ 'j-hui/fidget.nvim' }
	},
	config = ConfigCompletions,
	event = "VeryLazy",
}
