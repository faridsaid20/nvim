return {
	"navarasu/onedark.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("onedark").setup({
			style = "deep",
			transparent = false,
			toggle_style_key = "<leader>ts", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
			toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
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
