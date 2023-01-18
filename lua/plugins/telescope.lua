return { 'nvim-telescope/telescope.nvim',
	dependencies = {
		{ 'BurntSushi/ripgrep', lazy = true },
		{ 'nvim-telescope/telescope-fzy-native.nvim', lazy = true }, -- fast search algo
		{ 'nvim-telescope/telescope-media-files.nvim', lazy = true }, -- media preview
		{ 'nvim-telescope/telescope-frecency.nvim', lazy = true },
		{ 'nvim-telescope/telescope-dap.nvim', lazy = true },
	},
	lazy = true,
	cmd = { "Telescope" }
}
