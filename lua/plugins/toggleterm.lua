return {
	"akinsho/toggleterm.nvim",
	verson = "*",
	lazy = true,
	keys = {
		{
			"<leader>gt",
			mode = "n",
			"<cmd>lua lazygit:open()<cr>",
            desc = "Open lazygit",
		},
		{
			"<leader>tt",
			mode = "n",
			"<cmd>lua term:open()<cr>",
            desc = "Open terminal",
		},
	},
	config = function()
		local Terminal = require("toggleterm.terminal").Terminal
		_G.lazygit =
			Terminal:new({ cmd = "lazygit", hidden = true, direction = "float", float_opts = { border = "double" } })

		_G.term = Terminal:new({
			hidden = true,
			direction = "float",
			float_opts = { border = "double" },
			on_open = function(term)
				vim.cmd("startinsert!")
			end,
		})

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<C-w>", function()
				term:close()
				lazygit:close()
			end, opts)
		end

		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

		require("toggleterm").setup({
			open_mapping = [[<c-/>]],
		})
	end,
}
