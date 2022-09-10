local wk = require("which-key")
-- local automations = require("modules.automations")
local opts = {
	mode = "n", -- NORMAL mode
	-- prefix: use "<leader>f" for example for mapping everything related to finding files
	-- the prefix is prepended to every mapping part of `mappings`
	prefix = "",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}
wk.register({
	["<leader>"] = {
		f = {
			name = "+file",
			f = { "<cmd>Telescope find_files<cr>", "Find File" },
			r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
			g = { "<cmd>Telescope live_grep<cr>", "Search" },
			b = { "<cmd>Telescope buffers<cr>", "Buffers" },
			q = { "<cmd>Telescope quickfix<cr>", "Quick Fix List" },
			n = { "<cmd>enew<cr>", "New File" },
		},
		e = { "<cmd>NvimTreeToggle<CR> <cmd>lua print('DONT USE TREE')<CR>", "Open Explorer" },
		r = { "<cmd>NvimTreeRefresh<CR>", "Refresh Explorer" },
		c = {
			name = "+QuickFix List",
			n = { "<cmd>:cn<CR>", "Next item in QuickFix list" },
			N = { "<cmd>:cp<CR>", "Prev item in QuickFix list" },
			q = { "<cmd>:cclose<CR>", "Close QuickFix list" },
			g = { "<cmd>:cfirst<CR>", "First item in QuickFix list" },
			G = { "<cmd>:clast<CR>", "Last item in QuickFix list" },
			o = { "<cmd>:copen<CR>", "Open QuickFix list" },
		},
		t = {
			name = "+Terminal",
			t = { "<cmd>ToggleTerm size=15<CR>", "Toggle Terminal" },
			a = { "<cmd>ADDTERM<CR>", "Open another terminal" }
		},
		l = {
			name = "+LSP",
			D = { function() vim.diagnostic.open_float() end, "View Diagnostic Message" },
			d = { function() vim.lsp.buf.definition() end, "Go to Declaration" },
			r = { function() vim.lsp.buf.references() end, "Show References" },
			i = { function() vim.lsp.buf.implementation() end, "Implementation" },
			t = { "<cmd>:TroubleToggle<CR>", "toggle trouble diagnostics" },
			tr = { "<cmd>:TroubleRefresh<CR>", "toggle trouble diagnostics" },
		},
		g = {
			name = "+Git",
			b = { "<cmd> Telescope git_branches <CR>", "Show git branches" },
			c = { "<cmd> Git commit <CR>", "commit" },
			C = { "<cmd> Gwrite * | Git commit <CR>", "add/stage + commit" },
			s = { "<cmd> Gwrite * <CR>", "add/stage" },
			S = { "<cmd> Git stash <CR>", "stash" },
			f = { "<cmd> G fetch --all <CR>", "pull" },
			p = { "<cmd> G push <CR>", "push" },
			t = { "<cmd> <CR>", "tag" },
			D = { "<cmd> <CR>", "deploy (merge dev with main and create tag)" },
		},
		a = { function() require("harpoon.mark").add_file() end, "Harpoon add" },
	},
	["ca"]       = { function() vim.lsp.buf.code_action() end, "Code Action" },
	["K"]        = { function() vim.lsp.buf.hover() end, "Hover" },
	["<C-p>"]    = { function() vim.diagnostic.goto_prev() end, "Previous Error" },
	["<C-n>"]    = { function() vim.diagnostic.goto_next() end, "Previous Error" },
	-- harpoon bindings
	["<C-e>"]    = { function() require("harpoon.ui").toggle_quick_menu() end, "Harpoon UI" },
	["<C-1>"]    = { function() require("harpoon.ui").nav_file(1) end, "Go to file 1" },
	["<C-2>"]    = { function() require("harpoon.ui").nav_file(2) end, "Go to file 1" },
	["<C-3>"]    = { function() require("harpoon.ui").nav_file(3) end, "Go to file 1" },
	["<C-4>"]    = { function() require("harpoon.ui").nav_file(4) end, "Go to file 1" },
}, opts)
