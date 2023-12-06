local wk = require("which-key")
local jfind = require("jfind")
local key = require("jfind.key")
local keymap = vim.keymap.set
local silent = { silent = true }
wk.register({
	p = {
		name = "telescope/gpt", -- optional group name
		f = {
			function()
				require("telescope.builtin").find_files()
			end,
			"Find File",
		}, -- create a binding with label
		r = {
			function()
				require("telescope.builtin").oldfiles()
			end,
			"Open Recent File",
		}, -- additional options for creating the keymap
		s = { ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", "Search" }, -- just a label. don't create any mapping
		h = {
			function()
				require("telescope.builtin").help_tags()
			end,
			"Help tags",
		}, -- same as above
		c = {
			function()
				require("telescope.builtin").commands()
			end,
			"Commands",
		}, -- special label to hide it in tse popup
		w = {
			function()
				require("telescope.builtin").lsp_document_symbols()
			end,
			"Document symbols",
		},
	},
	t = {
		name = "tab",
		o = { ":tabnew<CR>", "New tab" },
		c = { ":tabclose<CR>", "Close tab" },
		n = { ":tabnext<CR>", "Next tab" },
		p = { ":tabprevious<CR>", "Previous tab" },
	},
	s = {
		name = "search/replace",
		r = { vim.lsp.buf.rename, "rename all occurences" },
		s = { [[*]], "Search in current buff" },
		w = {
			function()
				require("flash").jump({
					pattern = vim.fn.expand("<cword>"),
				})
			end,
			"Flash word under cursor",
		},
		f = {
			function()
				require("telescope.builtin").current_buffer_fuzzy_find()
			end,
			"Fuzzy fund in current buffer",
		},
	},
	-- x = {
	-- name = "executable file",
	-- x = { "<cmd>!chmod +x %<CR>", "Make executable" },
	-- },
	b = {
		name = "build/buffers",
		b = {
			function()
				require("telescope.builtin").buffers()
			end,
			"Show Buffers",
		}, -- you can also pass functions!
		m = { "<cmd>make<CR>", "Compile/make" },
		o = { ":bnew<CR>", "New buffer" },
		c = { ":bclose<CR>", "Close buffer" },
		n = { ":bnext<CR>", "Next buffer" },
		p = { ":bprevious<CR>", "Previous buffer" },
		f = { ":bfirst<CR>", "First buffer" },
		l = { ":blast<CR>", "Last buffer" },
	},
	w = {
		w = { "<cmd>bufdo write<CR>", "Save all" },
		q = { "<cmd>wq<CR>", "Save and quit" },
		a = { "<cmd>wqa<CR>", "Save all and quit" },
		s = { "<C-w>s", "Create horizontal window" },
		v = { "<C-w>v", "Create vertical window" },
		name = "Save and quit",
	},
	qq = { "<cmd>q!<CR>", "Quit without saving" },
	q = { "<cmd>q<CR>", "Quit" },
}, { prefix = "<leader>" })

keymap("n", "<leader><Down>", "<C-W><C-J>", { silent = true, noremap = true })
keymap("n", "<leader><Up>", "<C-W><C-K>", { silent = true, noremap = true })
keymap("n", "<leader><Left>", "<C-W><C-H>", { silent = true, noremap = true })
keymap("n", "<leader><Right>", "<C-W><C-L>", { silent = true, noremap = true })

keymap("o", "r", function()
	require("flash").remote()
end)

keymap("o", "R", function()
	require("flash").treesitter_search()
end)

keymap("x", "R", function()
	require("flash").treesitter_search()
end)

keymap("n", "s", "<cmd>lua require('flash').jump()<CR>", { silent = true, noremap = true })
keymap("x", "s", "<cmd>lua require('flash').jump()<CR>", { silent = true, noremap = true })
keymap("o", "s", "<cmd>lua require('flash').jump()<CR>", { silent = true, noremap = true })
keymap("n", "S", "<cmd>lua require('flash').treesitter()<CR>", { silent = true, noremap = true })
keymap("o", "S", "<cmd>lua require('flash').treesitter()<CR>", { silent = true, noremap = true })
keymap("x", "S", "<cmd>lua require('flash').treesitter()<CR>", { silent = true, noremap = true })
keymap("n", "<leader>sw", function()
	require("flash").jump({
		pattern = ".", -- initialize pattern with any char
		search = {
			mode = function(pattern)
				-- remove leading dot
				if pattern:sub(1, 1) == "." then
					pattern = pattern:sub(2)
				end
				-- return word pattern and proper skip pattern
				return ([[\v<%s\w*>]]):format(pattern), ([[\v<%s]]):format(pattern)
			end,
		},
		-- select the range
		jump = { pos = "range" },
	})
end, { silent = true, noremap = true, desc = "Flash select word" })

keymap("n", "<leader><leader>", function()
	vim.cmd("so")
end)

keymap("n", "<ESC>", ":noh<CR>", silent)

keymap("v", "E", ":m '>+1<CR>gv=gv", { silent = true, nowait = true, noremap = true })
keymap("v", "N", ":m '<-2<CR>gv=gv", { silent = true, nowait = true, noremap = true })
keymap("n", "J", "mzJ`z")

keymap("n", "<PageUp>", "<C-u>zz")
keymap("n", "<PageDown>", "<C-d>zz")

-- keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- keymap("n", "<C-l>", "<C-d>zz")
-- keymap("n", "<C-p>", "<C-u>zz")

keymap("n", "d", '"_d', silent)
keymap("n", "D", '"_D', silent)
keymap("n", "dd", '"_dd', silent)
keymap("v", "d", '"_d', silent)
keymap("v", "D", '"_D', silent)
keymap("v", "dd", '"_dd', silent)
keymap("n", "x", '"_x', silent)
keymap("n", "X", '"_X', silent)
keymap("v", "x", '"_x', silent)
keymap("v", "X", '"_X', silent)

keymap("v", "<C-e>", "$")
keymap("n", "<C-e>", "$")
keymap("v", "<C-m>", ":lua jumptolinestartandclearhighlights()<CR>", { silent = true, noremap = true })
keymap("n", "<C-m>", ":lua JumpToLineStartAndClearHighlights()<CR>", { silent = true, noremap = true })
function JumpToLineStartAndClearHighlights()
	vim.cmd("normal! ^")
	vim.cmd("silent! noh")
end

keymap("n", "<leader>pb", "<CMD>Oil<CR>", { desc = "Open parent directory", noremap = true })
keymap("v", "p", '"_dP', silent)

keymap("i", "<C-c>", "<Esc>")

keymap("n", "Q", "<nop>")

-- Save file by ESC
keymap("n", "<ESC>", ":w<CR>", silent)
keymap("i", "<ESC>", "<ESC>:w<CR>", silent)

keymap("n", "<S-m>", "<cmd>cnext<CR>zz")
keymap("n", "<S-e>", "<cmd>cprev<CR>zz")
keymap("n", "<C-K>", "<cmd>copen<CR>zz")
keymap("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, nowait = true })
keymap(
	"n",
	"gt",
	"<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
	{ noremap = true, nowait = true }
)
keymap(
	"n",
	"<leader>rp",
	"<cmd>lua require('goto-preview').goto_preview_references()<CR>",
	{ silent = true, noremap = true, nowait = true }
)

-- show references of word under cursor
keymap("n", "<leader>rs", function()
	require("telescope.builtin").lsp_references({ fname_width = 100 })
end, { noremap = true, nowait = true, silent = true, desc = "Show references" })

keymap(
	"n",
	"<C-c>",
	"<cmd>lua require('goto-preview').close_all_win()<CR><cmd>cclose<CR><cmd>DiffviewClose<CR>",
	{ noremap = true, nowait = true, silent = true }
)

keymap("n", "<C-h>", "<cmd>ClangdSwitchSourceHeader<CR>", silent)
-- {'n', 'v', 'x', 's', 'o', 'i', 'c', 't'}
vim.keymap.set("n", "<leader>pp", function()
	jfind.findFile({
		formatPaths = true,
		hidden = true,
		preview = true,
		previewPosition = "right",
		wrap_item_list = true,
		callback = {
			[key.DEFAULT] = vim.cmd.edit,
			[key.CTRL_S] = vim.cmd.split,
			[key.CTRL_V] = vim.cmd.vsplit,
		},
	})
end)

local preview
if vim.fn.executable("bat") == 1 then
	preview = "bat --color always --theme ansi --style plain"
else
	preview = "cat"
end
preview = preview .. " $(echo {} | awk -F: '{print $1}')"
vim.keymap.set("n", "<leader>pl", function()
	jfind.jfind({
		exclude = { "*.hpp" }, -- overrides setup excludes
		hidden = true, -- grep hidden files/directories
		caseSensitivity = "smart", -- sensitive, insensitive, smart
		--     will use vim settings by default
		preview = preview,
		query = "",
		formatPaths = true,
		wrap_item_list = true,
		previewPosition = "right",
		history = "~/.cache/jfind_live_grep_args_history",
		command = "bash -c 'rg '{}",
		callback = {
			[key.DEFAULT] = jfind.editGotoLine,
			[key.CTRL_B] = jfind.splitGotoLine,
			[key.CTRL_N] = jfind.vsplitGotoLine,
		},
	})
end)

keymap("i", "<M-n>", "<Plug>(copilot-next)", { silent = true, noremap = true })
keymap("i", "<M-e>", "<Plug>(copilot-previous)", { silent = true, noremap = true })
keymap("i", "<M-u>", "<cmd> Copilot<CR>", { silent = true, noremap = true })

keymap({ "n", "i" }, "<C-l>", function()
	require("logsitter").log()
end, { silent = true, noremap = true })

keymap("x", "<leader>re", function()
	require("refactoring").refactor("Extract Function")
end, { desc = "Extract Function" })
keymap("x", "<leader>rf", function()
	require("refactoring").refactor("Extract Function To File")
end, { desc = "Extract Function To File" })
-- Extract function supports only visual mode
keymap("x", "<leader>rv", function()
	require("refactoring").refactor("Extract Variable")
end, { desc = "Extract Variable" })
-- Extract variable supports only visual mode
keymap({ "n", "x" }, "<leader>ri", function()
	require("refactoring").refactor("Inline Variable")
end, { desc = "Inline Variable" })
-- Inline var supports both normal and visual mode

keymap("n", "<leader>rb", function()
	require("refactoring").refactor("Extract Block")
end, { desc = "Extract Block" })
keymap("n", "<leader>rbf", function()
	require("refactoring").refactor("Extract Block To File")
end, { desc = "Extract Block To File" })

-- prompt for a refactor to apply when the remap is triggered
vim.keymap.set({ "n", "x" }, "<leader>rr", function()
	require("refactoring").select_refactor()
end, { noremap = true, silent = true, desc = "Select Refactoring" })
-- Note that not all refactor support both normal and visual mode
