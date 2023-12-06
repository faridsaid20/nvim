return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedark").setup({
			style = "deep",
			transparent = true,
		})
		vim.cmd([[colorscheme onedark]])
	end,
}
-- return {
-- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
-- {
-- "LazyVim/LazyVim",
-- opts = {
-- colorscheme = "catppuccin",
-- },
-- },
-- }
