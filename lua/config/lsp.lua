local keymap = require("utils").keymap

local null_ls = require("null-ls")
local f = null_ls.builtins.formatting
local cmp = require("cmp")

-- MASON
require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "stylua", "clangd", "pyright", "eslint" },
})

-- NULL_LS
null_ls.setup({
	sources = {
		f.stylua,
		f.prettier,
		f.black,
		f.gdformat,
	},
})

-- SNIPPETS
require("luasnip.loaders.from_vscode").lazy_load()

-- COMPLETIONS
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

-- LSP settings
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }

	keymap("n", "gd", vim.lsp.buf.definition, opts)
	keymap("n", "K", vim.lsp.buf.hover, opts)
	keymap("n", "gr", vim.lsp.buf.references, opts)
	keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
	keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	keymap("n", "[d", vim.diagnostic.get_prev, opts)
	keymap("n", "]d", vim.diagnostic.get_next, opts)
	keymap("n", "<leader>f", function()
		vim.lsp.buf.format({ async = true })
	end, opts)
end

local lsp_names = { "lua_ls", "clangd", "stylua", "eslint", "pyright", "gdscript" }

for _, name in pairs(lsp_names) do
	vim.lsp.config(name, { capabilities = capabilities, on_attach = on_attach })
end

vim.lsp.enable(lsp_names)

vim.diagnostic.config({
	virtual_text = {
		only_current_line = true,
	},
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})
