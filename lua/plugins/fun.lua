return {
	"eandrju/cellular-automaton.nvim",
	lazy = true,
	keys = {
		{
			"<leader>mr",
			mode = "n",
			"<cmd>CellularAutomaton make_it_rain<CR>",
			desc = "Make it rain",
		},
		{ "<leader>ml", mode = "n", "<cmd>CellularAutomaton game_of_life<CR>", desc = "Game of life" },
	},
}
