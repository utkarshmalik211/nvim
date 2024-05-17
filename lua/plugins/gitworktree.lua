function ConfigGitWorktree()
	require("git-worktree").setup({
		update_on_change = true, -- default: true,
		clearjumps_on_change = true, -- default: true,
		autopush = true,  -- default: false,
	})
end

return {
	'ThePrimeagen/git-worktree.nvim', -- show git stuff in signcolumn
	config = ConfigGitWorktree
}
