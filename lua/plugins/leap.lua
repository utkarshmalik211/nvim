function ConfigLeap()
	require('leap').add_default_mappings()
end

return {
	'ggandor/leap.nvim',
	config = ConfigLeap,
	lazy = false
}
