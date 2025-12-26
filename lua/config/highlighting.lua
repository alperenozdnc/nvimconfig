require("nvim-treesitter.config").setup({
	ensure_installed = {
		"c",
		"lua",
		"python",
		"javascript",
		"typescript",
		"gdscript",
		"godot_resource",
		"gdshader",
	},

	sync_install = false,
	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true,
	},
})
