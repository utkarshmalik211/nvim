-- vim.cmd [[packadd nvim-lspconfig]]
-- vim.cmd [[packadd trouble.nvim]]
-- vim.cmd [[packadd cmp-nvim-lsp]]
local nvim_lsp = require("lspconfig")
local protocol = require 'vim.lsp.protocol'

--- Document highlights
local function document_highlight()
	vim.api.nvim_exec([[
		hi LspReferenceRead  guibg=#121111 guifg=#FFFF00
		hi LspReferenceText  guibg=#121111 guifg=#FFFF00
		hi LspReferenceWrite guibg=#121111 guifg=#FFFF00
		augroup lsp_document_highlight
			autocmd!
			autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
	]], false)
end

--- Custom attach
local on_attach_vim = function()
	document_highlight()

	protocol.CompletionItemKind = {
		'?'; -- Text          = 1;
		'Ä'; -- Method        = 2;
		'Ä'; -- Function      = 3;
		'?'; -- Constructor   = 4;
		'?'; -- Field         = 5;
		'??'; -- Variable      = 6;
		'?'; -- Class         = 7;
		'?'; -- Interface     = 8;
		'?'; -- Module        = 9;
		'Property'; -- Property      = 10;
		'Unit'; -- Unit          = 11;
		'Value'; -- Value         = 12;
		'?'; -- Enum          = 13;
		'?'; -- Keyword       = 14;
		'?'; -- Snippet       = 15;
		'Color'; -- Color         = 16;
		'?'; -- File          = 17;
		'Reference'; -- Reference     = 18;
		'?'; -- Folder        = 19;
		'?'; -- EnumMember    = 20;
		'?'; -- Constant      = 21;
		'?'; -- Struct        = 22;
		'Event'; -- Event         = 23;
		'Operator'; -- Operator      = 24;
		'TypeParameter'; -- TypeParameter = 25;
	}
end

local capabilities = protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "rounded",
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "rounded",
})

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
	root_dir = nvim_lsp.util.root_pattern('go.mod', '.git');
	capabilities = capabilities,
	cmd = { "/Users/utkarshmalik/go/bin/gopls", "--remote=auto" },
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

nvim_lsp.sumneko_lua.setup {
	on_attach = on_attach_vim,
	settings = {
		Lua = {
			runtime = { version = "LuaJIT", path = vim.split(package.path, ';'), },
			diagnostics = { enable = true, globals = {
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

nvim_lsp.pyright.setup {}
vim.cmd [[autocmd BufWritePre *.rs lua vim.lsp.buf.format({}, 1000)]]
vim.cmd [[autocmd BufWritePre *.py lua vim.lsp.buf.format({}, 1000)]]
vim.cmd [[autocmd BufWritePre *.go lua vim.lsp.buf.format({}, 1000)]]
vim.cmd [[autocmd BufWritePre *.lua lua vim.lsp.buf.format({}, 1000)]]
