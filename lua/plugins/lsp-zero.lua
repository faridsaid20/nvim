return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v2.x",
	dependencies = {
		--
		{ "neovim/nvim-lspconfig" }, -- Required
		{
			-- Optional
			"williamboman/mason.nvim",
			build = ":MasonUpdate",
		},
		{ "williamboman/mason-lspconfig.nvim" }, -- Optional

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" }, -- Required
		{ "hrsh7th/cmp-nvim-lsp" }, -- Required
		{ "onsails/lspkind-nvim" }, -- Optional
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "hrsh7th/cmp-cmdline" },

		-- Snippets
		{ "L3MON4D3/LuaSnip" }, -- Required
		{ "saadparwaiz1/cmp_luasnip" }, -- Optional
	},
}
