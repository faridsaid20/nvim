return {
	"nvim-telescope/telescope.nvim",
	version = "0.1.5",
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
		require("telescope").setup({
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			layout_config = {
				horizontal = {
					width = 0.5,
					-- height = 1.2,
					-- preview_cutoff = 180,
				},
				vertical = {
					width = 0.5,
					-- height = 0.9,
					-- preview_cutoff = 180,
				},
				-- width = 0.5,
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
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
							-- <c-p> paste from clipboard
                            -- because fkn neoviDE i needed to do this
							["<C-p>"] = function()

								local cursor_pos = vim.api.nvim_win_get_cursor(0)

								vim.api.nvim_put({ "h" }, "", true, true)
								-- Paste from the clipboard in normal mode and then go back to insert mode right after the pasted text
								vim.cmd('normal! "+p')
                                -- Restore the cursor to the original position before the "h" was inserted
                                vim.api.nvim_win_set_cursor(0, cursor_pos)
                                -- Delete the character under the cursor in normal mode (the initial "h")
                                vim.cmd("normal! xA")
								vim.api.nvim_feedkeys(
									vim.api.nvim_replace_termcodes("<Right>", true, false, true),
									"i",
									false
								)
							end,
							-- '<C-o>:call setreg(\'"\', @+, \'c\')<CR><C-o>p'
						},
					},
					-- ... also accepts theme settings, for example:
					-- theme = "dropdown", -- use dropdown theme
					-- theme = { }, -- use own theme spec
					-- layout_config = { mirror=true }, -- mirror preview pane
				},
			},
		})
		require("telescope").load_extension("fzf")
		require("telescope").load_extension("live_grep_args")
	end,
}
