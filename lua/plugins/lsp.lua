vim.cmd [[packadd nvim-lspconfig]]
vim.cmd [[packadd trouble.nvim]]
vim.cmd [[packadd cmp-nvim-lsp]]

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

capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

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
vim.cmd [[autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)]]
vim.cmd [[autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 1000)]]
vim.cmd [[autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)]]
vim.cmd [[autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 1000)]]

--------------TROUBLE config---------------------------
require("trouble").setup {
	position = "bottom", -- position of the list can be: bottom, top, left, right
	height = 10, -- height of the trouble list when position is top or bottom
	width = 50, -- width of the list when position is left or right
	icons = true, -- use devicons for filenames
	mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
	fold_open = "", -- icon used for open folds
	fold_closed = "", -- icon used for closed folds
	group = true, -- group results by file
	padding = true, -- add an extra new line on top of the list
	action_keys = { -- key mappings for actions in the trouble list
		-- map to {} to remove a mapping, for example:
		-- close = {},
		close = "q", -- close the list
		cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
		refresh = "r", -- manually refresh
		jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
		open_split = { "<c-x>" }, -- open buffer in new split
		open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
		open_tab = { "<c-t>" }, -- open buffer in new tab
		jump_close = { "o" }, -- jump to the diagnostic and close the list
		toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
		toggle_preview = "P", -- toggle auto_preview
		hover = "K", -- opens a small popup with the full multiline message
		preview = "p", -- preview the diagnostic location
		close_folds = { "zM", "zm" }, -- close all folds
		open_folds = { "zR", "zr" }, -- open all folds
		toggle_fold = { "zA", "za" }, -- toggle fold of current file
		previous = "k", -- preview item
		next = "j" -- next item
	},
	indent_lines = true, -- add an indent guide below the fold icons
	auto_open = false, -- automatically open the list when you have diagnostics
	auto_close = false, -- automatically close the list when you have no diagnostics
	auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
	auto_fold = false, -- automatically fold a file trouble list at creation
	auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
	signs = {
		-- icons / text used for a diagnostic
		error = "",
		warning = "",
		hint = "",
		information = "",
		other = "﫠"
	},
	use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}
