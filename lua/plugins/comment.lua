return {
	"numToStr/Comment.nvim", -- toggle comments
	lazy = true,
	keys = {
		{ "tt", mode = { "n", "v" }, ":normal gcc<CR>", { noremap = true, silent = true } },
		{ "tb", mode = { "n", "v" }, ":normal gbc<CR>", { noremap = true, silent = true } },
	},
	config = function()
		require("Comment").setup()
	end,
}
