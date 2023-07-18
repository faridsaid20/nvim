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
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		config = function()
			require("indent_blankline").setup({
				space_char_blankline = " ",
				show_current_context = true,
				show_current_context_start = true,
				show_end_of_line = true,
			})
		end,
	}, -- highlight scope lines
	{ "RRethy/vim-illuminate", event = "InsertEnter" }, -- highlight other uses of the word under the cursor
	{ "kevinhwang91/nvim-bqf", lazy = false }, -- quickfix preview window
	{ "windwp/nvim-ts-autotag", event = "InsertEnter" }, -- auto close tags
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
	{ "mg979/vim-visual-multi", branch = "master", event = "InsertEnter", }
}
