return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"stevearc/oil.nvim",
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
		lazy = false,
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"theprimeagen/harpoon",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"williamboman/mason.nvim",
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
	{
		"neovim/nvim-lspconfig",
	},
	{
		"nvimtools/none-ls.nvim",
	},
	{
		"hrsh7th/nvim-cmp",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"saadparwaiz1/cmp_luasnip",
			"rafamadriz/friendly-snippets",
		},
	},
	{
		"OXY2DEV/markview.nvim",
		lazy = false,
	},
}
