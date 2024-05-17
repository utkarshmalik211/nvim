function ConfigWhichKey()
	local wk = require("which-key")
	-- local automations = require("modules.automations")
	local opts = {
		mode = "n", -- NORMAL mode
		prefix = "",
		buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
		silent = true, -- use `silent` when creating keymaps
		noremap = true, -- use `noremap` when creating keymaps
		nowait = false, -- use `nowait` when creating keymaps
	}
	wk.register({
		["<leader>"] = {
			a = { function() require("aerial").toggle() end, "Aerial" },
			b = {
				name = "+buffers",
				l = { "<cmd>Telescope buffers<cr>", "Buffers" },
			},
			f = {
				name = "+file",
				f = { "<cmd>Telescope git_files<cr>", "Find File" },
				r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
				g = { "<cmd>Telescope live_grep<cr>", "Search" },
				q = { "<cmd>Telescope quickfix<cr>", "Quick Fix List" },
				n = { "<cmd>enew<cr>", "New File" },
			},
			e = { "<cmd>NvimTreeToggle<CR>", "NvimTree" },
			r = { "<cmd>NvimTreeRefresh<CR>", "Refresh Explorer" },
			q = {
				name = "+QuickFix List",
				n = { "<cmd>:cn<CR>", "Next item in QuickFix list" },
				N = { "<cmd>:cp<CR>", "Prev item in QuickFix list" },
				q = { "<cmd>:cclose<CR>", "Close QuickFix list" },
				g = { "<cmd>:cfirst<CR>", "First item in QuickFix list" },
				G = { "<cmd>:clast<CR>", "Last item in QuickFix list" },
				o = { "<cmd>:copen<CR>", "Open QuickFix list" },
			},
			l = {
				name = "+LSP",
				D = { function() vim.diagnostic.open_float() end, "View Diagnostic Message" },
				d = { function() vim.lsp.buf.definition() end, "Go to Declaration" },
				r = { function() require("trouble").toggle("lsp_references") end, "Show References" },
				R = { function() LspRename() end, "Show References" },
				i = { function() vim.lsp.buf.implementation() end, "Implementation" },
				t = { function() require("trouble").toggle() end, "toggle trouble diagnostics" },
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
				w = {
					name = "+Git Worktree",
					s = {
						function() require('telescope').extensions.git_worktree.git_worktrees() end,
						"Switch" },
					c = {
						function()
							require('telescope').extensions.git_worktree
							    .create_git_worktree()
						end, "Create" },
				},
				h = {
					name = "+Github",
					c = {
						name = "+Commits",
						c = { "<cmd>GHCloseCommit<cr>", "Close" },
						e = { "<cmd>GHExpandCommit<cr>", "Expand" },
						o = { "<cmd>GHOpenToCommit<cr>", "Open To" },
						p = { "<cmd>GHPopOutCommit<cr>", "Pop Out" },
						z = { "<cmd>GHCollapseCommit<cr>", "Collapse" },
					},
					i = {
						name = "+Issues",
						p = { "<cmd>GHPreviewIssue<cr>", "Preview" },
					},
					l = {
						name = "+Litee",
						t = { "<cmd>LTPanel<cr>", "Toggle Panel" },
					},
					r = {
						name = "+Review",
						b = { "<cmd>GHStartReview<cr>", "Begin" },
						c = { "<cmd>GHCloseReview<cr>", "Close" },
						d = { "<cmd>GHDeleteReview<cr>", "Delete" },
						e = { "<cmd>GHExpandReview<cr>", "Expand" },
						s = { "<cmd>GHSubmitReview<cr>", "Submit" },
						z = { "<cmd>GHCollapseReview<cr>", "Collapse" },
					},
					p = {
						name = "+Pull Request",
						c = { "<cmd>GHClosePR<cr>", "Close" },
						d = { "<cmd>GHPRDetails<cr>", "Details" },
						e = { "<cmd>GHExpandPR<cr>", "Expand" },
						o = { "<cmd>GHOpenPR<cr>", "Open" },
						p = { "<cmd>GHPopOutPR<cr>", "PopOut" },
						r = { "<cmd>GHRefreshPR<cr>", "Refresh" },
						t = { "<cmd>GHOpenToPR<cr>", "Open To" },
						z = { "<cmd>GHCollapsePR<cr>", "Collapse" },
					},
					t = {
						name = "+Threads",
						c = { "<cmd>GHCreateThread<cr>", "Create" },
						n = { "<cmd>GHNextThread<cr>", "Next" },
						t = { "<cmd>GHToggleThread<cr>", "Toggle" },
					},
				},
			},
			H = { function() require("harpoon.mark").add_file() end, "Harpoon add" },
			h = { function() require("harpoon.ui").toggle_quick_menu() end, "Harpoon add" },
			u = { vim.cmd.UndotreeToggle, "undo tree toggle" },
			z = { "<cmd>ZenMode<CR>", "Zen Mode toggle" },
		},
		["-"]        = { "<CMD>Oil<CR>", "oil" },
		["ca"]       = { function() vim.lsp.buf.code_action() end, "Code Action" },
		["K"]        = { function() vim.lsp.buf.hover() end, "Hover" },
		["<C-p>"]    = { function() vim.diagnostic.goto_prev() end, "Previous Error" },
		["<C-n>"]    = { function() vim.diagnostic.goto_next() end, "Previous Error" },
		-- harpoon bindings
		["<C-1>"]    = { function() require("harpoon.ui").nav_file(1) end, "Go to file 1" },
		["<C-2>"]    = { function() require("harpoon.ui").nav_file(2) end, "Go to file 2" },
		["<C-3>"]    = { function() require("harpoon.ui").nav_file(3) end, "Go to file 3" },
		["<C-4>"]    = { function() require("harpoon.ui").nav_file(4) end, "Go to file 4" },
	}, opts)
end

return { 'folke/which-key.nvim', lazy = false, config = ConfigWhichKey }
