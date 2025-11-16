vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gd", "tscn", "godot" },
	callback = function()
		vim.fn.serverstart("127.0.0.1:6004")
		print("> started watching godot lsp")
	end,
})
