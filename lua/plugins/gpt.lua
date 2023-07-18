return {
	"faridsaid20/ChatGPT.nvim",
	keys = {
		{
			"<leader>pe",
			mode = "n",
			function()
				require("chatgpt").openChat()
			end,
			desc = "chatgpt",
		},
	},
	config = function()
		require("chatgpt").setup({})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
