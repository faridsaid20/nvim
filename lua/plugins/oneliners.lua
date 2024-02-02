return {
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "rafamadriz/friendly-snippets", lazy = true },
	{ "nvim-lua/plenary.nvim" },
	{
		"windwp/nvim-autopairs", -- autopairs for nvim written by lua
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{ "RRethy/vim-illuminate", lazy = false }, -- highlight other uses of the word under the cursor
	{ "kevinhwang91/nvim-bqf", lazy = false }, -- quickfix preview window
	{ "windwp/nvim-ts-autotag", event = "InsertEnter" }, -- auto close tags
	{
		"barrett-ruth/import-cost.nvim",
		build = "sh install.sh npm",
		lazy = false,
		config = function()
			require("import-cost").setup()
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = "VeryLazy",
		config = function()
			require("colorizer").setup()
		end,
	}, -- colorize hex colors
	{
		"echasnovski/mini.ai",
		branch = "stable",
		event = "InsertEnter",
		config = function()
			require("mini.ai").setup()
		end,
	},

	{ "ThePrimeagen/vim-be-good", lazy = true },
	{ "mg979/vim-visual-multi", branch = "master", event = "InsertEnter" },
}
