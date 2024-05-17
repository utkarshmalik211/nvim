function ConfigMiniPlugs()
	require('mini.indentscope').setup()
	require('mini.pairs').setup()
	require('mini.comment').setup()
	require('mini.notify').setup()
end

return {
	'echasnovski/mini.nvim',
	version = '*',
	config = ConfigMiniPlugs,
	event = "VeryLazy",
}
