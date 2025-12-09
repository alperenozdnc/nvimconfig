require("nvim-treesitter.configs").setup({
	ensure_installed = { "c", "lua", "python", "javascript", "typescript", "gdscript", "godot_resource", "gdshader" },
	ignore_install = {},
	sync_install = false,
	auto_install = true,
	modules = { "c", "lua", "python", "javascript", "typescript", "gdscript", "godot_resource", "gdshader" },

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},

	indent = {
		enable = true,
	},
})
