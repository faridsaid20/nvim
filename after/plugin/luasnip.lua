local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
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

ls.add_snippets("all", {
	s("trn", {
		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		i(1, "cond"),
		t(" ? "),
		i(2, "then"),
		t(" : "),
		i(3, "else"),
	}),
	s("print", {
		t("RFC_printf("),
		i(1, ""),
		t(")"),
	}),
	s("cl", {
		t("console.log("),
		i(1, ""),
		t(")"),
	}),

	s("exd", {
		t("export default"),
		i(1, ""),
	}),
})


ls.add_snippets("http", {

	s("lh", {
		t("http://localhost"),
		i(1, ""),
	}),

	s("ctj", {
		t("content-type: application/json"),
		i(1, ""),
	}),
})

-- vim.keymap.set({ "i", "s" }, "<C-y>", function()
	-- if ls.expand_or_jumpable() then
		-- ls.expand_or_jump()
	-- end
-- end, { silent = true })

local function load_snippets()
  ls.filetype_extend("javascript", { "all" })
  ls.filetype_extend("typescript", { "all" })
end
load_snippets()
