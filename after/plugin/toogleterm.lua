local keymap = vim.keymap.set

vim.g.mapleader = " "
local Terminal = require("toggleterm.terminal").Terminal
local lazygit =
	Terminal:new({ cmd = "lazygit", hidden = true, direction = "float", float_opts = { border = "double" } })

local term = Terminal:new({
	hidden = true,
	direction = "float",
	float_opts = { border = "double" },
	on_open = function(term)
		vim.cmd("startinsert!")
	end,
})

keymap("n", "<leader>gt", function()
	lazygit:open()
end, { noremap = true, silent = true })

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set("t", "<C-w>", function ()
        term:close()
        lazygit:close()
	end, opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

keymap("n", "<leader>tt", function()
	term:open()
end, { noremap = true, silent = true })
