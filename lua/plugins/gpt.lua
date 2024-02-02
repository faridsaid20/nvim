return {
	"faridsaid20/ChatGPT.nvim",
	-- event = "VeryLazy",
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
	-- dev = true,
	-- dir = "~/workspace/lua/ChatGPT.nvim",

	config = function()
		require("chatgpt").setup({
			openai_params = {
				max_tokens = 4000,
			},
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
	},
}
