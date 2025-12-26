require("nvim-treesitter").install({
	"c",
	"lua",
	"python",
	"javascript",
	"typescript",
	"gdscript",
	"godot_resource",
	"gdshader",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local bufnr = args.buf
		local ft = vim.bo[bufnr].filetype

		-- map filetype -> treesitter language (new API)
		local lang = vim.treesitter.language.get_lang(ft)

		if not lang then
			return
		end

		pcall(vim.treesitter.start, bufnr, lang)
	end,
})

vim.filetype.add({
	extension = {
		h = "c",
	},
})
