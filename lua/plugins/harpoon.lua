return {
	"theprimeagen/harpoon",
	lazy = true,
	keys = {
        {
            "<leader>a",
            mode = "n",
			function()
            require("harpoon.mark").add_file()
			end,
            desc = "Add file to Harpoon",
        },
		{
			"<C-b>",
			mode = "n",
			function()
				require("harpoon.ui").toggle_quick_menu()
			end,
			desc = "Toggle Harpoon Menu",
		},
		{
			"<C-z>",
			mode = { "n", "v", "i", "t", "c", "s", "x", "o" },
			function()
				require("harpoon.ui").nav_file(1)
			end,
			desc = "open file 1",
		},
		{
			"<C-f>",
			mode = { "n" },
			function()
				require("harpoon.ui").nav_file(2)
			end,
			desc = "open file 2",
		},
		{
			"<C-o>",
			mode = { "n" },
			function()
				require("harpoon.ui").nav_file(3)
			end,
			desc = "open file 3",
		},
        {
			"<C-u>",
			mode = { "n"},
			function()
				require("harpoon.ui").nav_file(4)
			end,
			desc = "open file 4",
		}
	},
	config = function()
		require("harpoon").setup({
			menu = {
				width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
			},
		})
	end,
}
