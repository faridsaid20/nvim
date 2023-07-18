local keymap = vim.keymap.set
return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	config = function()
		require("gitsigns").setup({
			current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
			current_line_blame_opts = {
				virt_text = true,
				virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
				delay = 100,
				ignore_whitespace = false,
			},
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, opts)
					opts = opts or {}
					opts.buffer = bufnr
					vim.keymap.set(mode, l, r, opts)
				end

				-- Navigation
				map("n", "g(", function()
					if vim.wo.diff then
						return "g("
					end
					vim.schedule(function()
						gs.next_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })

				map("n", "k(", function()
					if vim.wo.diff then
						return "k("
					end
					vim.schedule(function()
						gs.prev_hunk()
					end)
					return "<Ignore>"
				end, { expr = true })
                map("n", "<leader>hs", gs.stage_hunk, { desc = "stag/unstage hunk" })
                map("n", "<leader>hr", gs.reset_hunk, { desc = "reset hunk" })
                map("n", "<leader>hS", gs.stage_buffer, { desc = "stage buffer" })
                map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
                map("n", "<leader>hR", gs.reset_buffer, { desc = "reset buffer" })
                map("n", "<leader>hp", gs.preview_hunk, { desc = "preview hunk" })
                map("n", "<leader>hb", function()
                    gs.blame_line({ full = true })
                end, { desc = "blame line" })
                map("n", "<leader>ht", gs.toggle_current_line_blame, { desc = "toggle current line blame" })
                map("n", "<leader>hd", gs.diffthis, { desc = "diffthis" })
                map("n", "<leader>hD", function()
                    gs.diffthis("~")
                end, { desc = "diffthis ~" })
                map("n", "<leader>td", gs.toggle_deleted, { desc = "toogle deleted" })
				map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
			end,
		})
	end,
}
