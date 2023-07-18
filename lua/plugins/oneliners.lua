return {
	{ "nvim-treesitter/nvim-treesitter-context" },
	{ "rafamadriz/friendly-snippets" },
	{ "nvim-lua/plenary.nvim" },
	{
		"windwp/nvim-autopairs", -- autopairs for nvim written by lua
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{ "lukas-reineke/indent-blankline.nvim",
    config = function ()
        require("indent_blankline").setup {
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
            show_end_of_line = true,
        }
    end}, -- highlight scope lines
	{ "RRethy/vim-illuminate" }, -- highlight other uses of the word under the cursor
	{ "kevinhwang91/nvim-bqf" }, -- quickfix preview window
	{ "windwp/nvim-ts-autotag" }, -- auto close tags
	{
		"norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
		config = function()
			require("colorizer").setup()
		end,
	}, -- colorize hex colors
	{ "echasnovski/mini.ai", branch = "stable" },
	{ "ThePrimeagen/vim-be-good" },
	{ "mg979/vim-visual-multi", branch = "master" }, -- multiple cursors
}
