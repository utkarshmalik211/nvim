function ConfigLSP()
	local nvim_lsp = require("lspconfig")
	local protocol = require 'vim.lsp.protocol'
	local on_attach_vim = function()
		protocol.CompletionItemKind = {
			'', -- Text          = 1;
			'm', -- Method        = 2;
			'', -- Function      = 3;
			'', -- Constructor   = 4;
			'', -- Field         = 5;
			'', -- Variable      = 6;
			'', -- Class         = 7;
			'', -- Interface     = 8;
			'', -- Module        = 9;
			'', -- Property      = 10;
			'', -- Unit          = 11;
			'', -- Value         = 12;
			'', -- Enum          = 13;
			'', -- Keyword       = 14;
			'', -- Snippet       = 15;
			'', -- Color         = 16;
			'', -- File          = 17;
			'', -- Reference     = 18;
			'', -- Folder        = 19;
			'', -- EnumMember    = 20;
			'', -- Constant      = 21;
			'', -- Struct        = 22;
			'', -- Event         = 23;
			'', -- Operator      = 24;
			'', -- TypeParameter = 25;
		}
	end
	local capabilities = protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
	if not status_ok then
		return
	end

	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, {
			underline = true, -- Enable underline, use default values
			virtual_text = true -- Enable virtual text only on Warning or above, override spacing to 2
		}
	)

	nvim_lsp.gopls.setup {
		on_attach = on_attach_vim,
		root_dir = nvim_lsp.util.root_pattern('go.mod', '.git'),
		capabilities = capabilities,
		cmd = { "gopls", "--remote=auto" },
		settings = {
			gopls = {
				analyses = {
					nilness = true,
					shadow = true,
					unusedparams = true,
					unusewrites = true,
				},
				staticcheck = true,
				gofumpt = true,
				usePlaceholders = true,
			},
		},
	}

	nvim_lsp.lua_ls.setup {
		on_attach = on_attach_vim,
		settings = {
			Lua = {
				runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
				diagnostics = {
					enable = true,
					globals = {
						"vim", "describe", "it", "before_each", "after_each"
					},
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					}
				}
			}
		}
	}

	nvim_lsp.pyright.setup {
		on_attach = on_attach_vim,
		capabilities = capabilities,
	}
	nvim_lsp.tsserver.setup {
		on_attach = on_attach_vim,
		capabilities = capabilities,
		settings = {
			completions = {
				completeFunctionCalls = true
			},
			javascript = {
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = true,
				},
			},
			typescript = {
				inlayHints = {
					includeInlayEnumMemberValueHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayVariableTypeHints = true,
				},
			},
		},
	}
	nvim_lsp.rust_analyzer.setup {
		on_attach = on_attach_vim,
		capabilities = capabilities,
		root_dir = nvim_lsp.util.root_pattern('Cargo.toml', '.git'),
		settings = {
			["rust-analyzer"] = {
				trace = { server = "verbose" },
				server = {
					path = "rust-analyzer"
				},
				cargo = {
					target = "aarch64-apple-darwin"
				},
			}
		}
	}

	nvim_lsp.zls.setup {
		-- Server-specific settings. See `:help lspconfig-setup`
		on_attach = on_attach_vim,
		capabilities = capabilities,
		root_dir = nvim_lsp.util.root_pattern('build.zig', '.git'),
		-- the following line can be removed if ZLS is in your PATH
		cmd = { '/Users/utkarshmalik/dev/zig/zls/zig-out/bin/zls' },
		-- There are two ways to set config options:
		--   - edit your `zls.json` that applies to any editor that uses ZLS
		--   - set in-editor config options with the `settings` field below.
		--
		-- Further information on ZLS config options:
		-- https://github.com/zigtools/zls#configuration-options
	}
	vim.cmd [[autocmd BufWritePre *.rs lua vim.lsp.buf.format({}, 1000)]]
	vim.cmd [[autocmd BufWritePre *.py lua vim.lsp.buf.format({}, 1000)]]
	vim.cmd [[autocmd BufWritePre *.go lua vim.lsp.buf.format({}, 1000)]]
	vim.cmd [[autocmd BufWritePre *.lua lua vim.lsp.buf.format({}, 1000)]]
	vim.cmd [[autocmd BufWritePre *.zig lua vim.lsp.buf.format({}, 1000)]]
end

function ConfigCompletions()
	ConfigLSP()
	local cmp = require('cmp')
	local luasnip = require('luasnip')

	cmp.setup({
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body) -- For `luasnip` users.
			end,
		},
		view = {
			entries = { name = 'custom', selection_order = 'near_cursor' }
		},
		mapping = cmp.mapping.preset.insert({
			['<C-b>'] = cmp.mapping.scroll_docs(-4),
			['<C-f>'] = cmp.mapping.scroll_docs(4),
			['<C-Space>'] = cmp.mapping.complete(),
			['<C-e>'] = cmp.mapping.abort(),
			-- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
			['<CR>'] = cmp.mapping.confirm({ select = true }),
			["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
			["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
			["<Tab>"] = cmp.mapping(function(fallback)
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		formatting = {
			fields = { "abbr", "kind" },
		},
		experimental = {
			native_menu = false,
			ghost_text = true,
		},
		sources = {
			{ name = 'nvim_lsp' },
			{ name = 'luasnip' },
			{ name = 'path' },
			{ name = 'nvim_lua' },
			{ name = 'buffer',  keyword_length = 3 },
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
		{ 'j-hui/fidget.nvim' },
	},
	config = ConfigCompletions,
	event = "VeryLazy",
}
