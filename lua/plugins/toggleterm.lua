return {
	"akinsho/toggleterm.nvim",
	tag = "*",
    lazy = true,
	config = function()
		require("toggleterm").setup({
			open_mapping = [[<c-/>]],
		})
	end,
}
