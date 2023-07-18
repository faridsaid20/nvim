return {
	"nvim-telescope/telescope.nvim",
	version = "0.1.2",
	lazy = true,
	keys = {
		{
			"<leader>sg",
			mode = "n",
			function()
				require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
			end,
			desc = "Grep in workspace",
		},
		{
			"<leader>sv",
			mode = "v",
			function()
				require("telescope-live-grep-args.shortcuts").grep_visual_selection()
			end,
			desc = "Grep in visual",
		},
	},
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
	},
	config = function()
		-- require("telescope").load_extension("live_grep_args")
		require("telescope").setup({
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			layout_config = {
				horizontal = {
					width = 1.2,
					height = 1.2,
					preview_cutoff = 140,
				},
			},
			extensions = {
				live_grep_args = {
					auto_quoting = true, -- enable/disable auto-quoting
					-- define mappings, e.g.
					mappings = {
						-- extend mappings
						i = {
							["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
							["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({
								postfix = " --iglob ",
							}),
						},
					},
					-- ... also accepts theme settings, for example:
					-- theme = "dropdown", -- use dropdown theme
					-- theme = { }, -- use own theme spec
					-- layout_config = { mirror=true }, -- mirror preview pane
				},
			},
		})
	end,
}
