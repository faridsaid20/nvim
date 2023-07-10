local ls = require("luasnip")
local types = require("luasnip.util.types")
ls.config.set_config({
	-- This tells LuaSnip to remember to keep around the last snippet.
	-- You can jump back into it even if you move outside of the selection
	history = false,

	-- This one is cool cause if you have dynamic snippets, it updates as you type!
	updateevents = "TextChanged,TextChangedI",

	-- Autosnippets:
	enable_autosnippets = true,

	-- Crazy highlights!!
	-- #vid3
	-- ext_opts = nil,
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { " « ", "NonTest" } },
			},
		},
	},
})


require("luasnip.loaders.from_vscode").lazy_load()


-- Allow jsx and tsx to use js snppets
require('luasnip').filetype_extend('javascript', { 'javascriptreact', 'typescriptreact' })



local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
keymap("i", "<C-s>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("s", "<C-s>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
keymap("i", "<C-t>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
keymap("s", "<C-t>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
