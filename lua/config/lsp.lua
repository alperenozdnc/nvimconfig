require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "stylua", "clangd", "pyright", "eslint" },
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.gdformat,
        null_ls.builtins.formatting.clangd
	},
})

local cmp = require("cmp")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<TAB>"] = cmp.mapping.select_next_item(),
		["<S-TAB>"] = cmp.mapping.select_prev_item(),
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
	}, {
		{ name = "buffer" },
	}),
})

-- shared LSP settings
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "[d", vim.diagnostic.get_prev, opts)
	vim.keymap.set("n", "]d", vim.diagnostic.get_next, opts)
	vim.keymap.set("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
end

vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
			workspace = { library = vim.api.nvim_get_runtime_file("", true) },
		},
	},
})

vim.lsp.config("clangd", { capabilities = capabilities, on_attach = on_attach })
vim.lsp.config("stylua", { capabilities = capabilities, on_attach = on_attach })
vim.lsp.config("eslint", { capabilities = capabilities, on_attach = on_attach })
vim.lsp.config("pyright", { capabilities = capabilities, on_attach = on_attach })
vim.lsp.config("tailwindcss", { capabilities = capabilities, on_attach = on_attach })
vim.lsp.config("gdscript", {
	capabilities = capabilities,
	on_attach = on_attach,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "gd", "tscn", "godot" },
	callback = function()
		vim.fn.serverstart("127.0.0.1:6004")
		print("> started watching godot lsp")
	end,
})

vim.lsp.enable({
	"lua_ls",
	"clangd",
	"stylua",
	"eslint",
	"pyright",
	"tailwindcss",
	"gdscript",
})

vim.diagnostic.config({
	virtual_text = {
		only_current_line = true,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

