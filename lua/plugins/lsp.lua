
vim.cmd [[packadd nvim-lspconfig]]
vim.cmd [[packadd lspsaga.nvim]]

local nvim_lsp = require("lspconfig")
local protocol = require'vim.lsp.protocol'
--local mappings = require("modules.lsp._mappings")
--local is_cfg_present = require("modules._util").is_cfg_present

--require("modules.lsp._diagnostic")
require("lspsaga").init_lsp_saga({
  border_style = 1,
  code_action_prompt = {
     enable = true,
     sign = true,
     sign_priority = 20,
     virtual_text = false,
   },
})


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
		'?';             -- Text          = 1;
		'Ä';             -- Method        = 2;
		'Ä';             -- Function      = 3;
		'?';             -- Constructor   = 4;
		'?';            -- Field         = 5;
		'??';             -- Variable      = 6;
		'?';             -- Class         = 7;
		'?';             -- Interface     = 8;
		'?';             -- Module        = 9;
		'Property';      -- Property      = 10;
		'Unit';          -- Unit          = 11;
		'Value';         -- Value         = 12;
		'?';            -- Enum          = 13;
		'?';             -- Keyword       = 14;
		'?';             -- Snippet       = 15;
		'Color';         -- Color         = 16;
		'?';             -- File          = 17;
		'Reference';     -- Reference     = 18;
		'?';             -- Folder        = 19;
		'?';             -- EnumMember    = 20;
		'?';             -- Constant      = 21;
		'?';             -- Struct        = 22;
		'Event';         -- Event         = 23;
		'Operator';      -- Operator      = 24;
		'TypeParameter'; -- TypeParameter = 25;
	}
end

local capabilities = protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
 vim.lsp.diagnostic.on_publish_diagnostics, {
   underline = false, -- Enable underline, use default values
   virtual_text = false -- Enable virtual text only on Warning or above, override spacing to 2
 }
)

-- nvim_lsp.gopls.setup{
--   cmd = {'/Users/utkarsh-sib/go/bin/gopls', '--remote=auto'},
-- }
nvim_lsp.gopls.setup{
	on_attach = on_attach_vim,
    root_dir = nvim_lsp.util.root_pattern('go.mod', '.git');
	capabilities = capabilities,
	cmd = {"/Users/utkarsh-sib/go/bin/gopls", "--remote=auto"},
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
			},
			staticcheck = true,
		},
	},
}
vim.cmd[[autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 1000)]]
vim.cmd[[autocmd BufWritePre *.go lua vim.lsp.buf.formatting_sync(nil, 1000)]]
vim.cmd[[autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync(nil, 1000)]]

