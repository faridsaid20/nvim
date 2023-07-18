return {
	"folke/flash.nvim",
    lazy = true,
	config = function()
		require("flash").setup({
			modes = {
				char = {
					enabled = false,
				},
			},
			label = {
				rainbow = {
					enabled = true,
					-- number between 1 and 9
					shade = 5,
				},
			},
			-- labels = "etovxmpdygfblzhckisuranqwj/?",
		})
	end,
}
