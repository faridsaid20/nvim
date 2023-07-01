local ui = require("harpoon.ui")
local mark = require("harpoon.mark")
local wk = require("which-key")
local builtin = require("telescope.builtin")
local chatgpt = require("chatgpt")
local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
local jfind = require("jfind")
local key = require("jfind.key")
local keymap = vim.keymap.set
local silent = { silent = true }
vim.g.mapleader = " "
require("harpoon").setup({
	menu = {
		width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
	},
})
local flash = require("flash")
wk.register({
	p = {
		name = "telescope/gpt", -- optional group name
		f = { builtin.find_files, "Find File" }, -- create a binding with label
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" }, -- additional options for creating the keymap
		s = { ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", "Search" }, -- just a label. don't create any mapping
		h = { builtin.help_tags, "Help tags" }, -- same as above
		c = { builtin.commands, "Commands" }, -- special label to hide it in the popup
		y = { ":NvimTreeToggle<CR>", "Toggle NvimTree" },
		w = { builtin.lsp_document_symbols, "Document symbols" },
		e = {
			function()
				chatgpt.openChat()
			end,
			"chatgpt",
			-- mode = "v"
		},
		t = { ":lua PopupTerminal()<CR>", "Terminal" },
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
				flash.jump({
					pattern = vim.fn.expand("<cword>"),
				})
			end,
			"Flash word under cursor",
		},
		g = { live_grep_args_shortcuts.grep_word_under_cursor, "Grep in workspace" },
		f = { builtin.current_buffer_fuzzy_find, "Fuzzy fund in current buffer" },
	},
	-- x = {
	-- name = "executable file",
	-- x = { "<cmd>!chmod +x %<CR>", "Make executable" },
	-- },
	b = {
		name = "build/buffers",
		b = { builtin.buffers, "Show Buffers" }, -- you can also pass functions!
		m = { "<cmd>make<CR>", "Compile/make" },
		o = { ":bnew<CR>", "New buffer" },
		c = { ":bclose<CR>", "Close buffer" },
		n = { ":bnext<CR>", "Next buffer" },
		p = { ":bprevious<CR>", "Previous buffer" },
		f = { ":bfirst<CR>", "First buffer" },
		l = { ":blast<CR>", "Last buffer" },
	},
	g = {
		name = "git",
		f = { builtin.git_files, "Git files" },
		g = { "<cmd>Git<CR>", "Git" },
		s = { "<cmd>Git status<CR>", "Git status" },
		c = { "<cmd>Git commit<CR>", "Git commit" },
		p = { "<cmd>Git push -f<CR>", "Git push" },
		-- f = { "<cmd>Git fetch<CR>", "Git fetch" },
		b = { "<cmd>Git blame<CR>", "Git blame" },
		l = { "<cmd>Git log<CR>", "Git log" },
		d = { "<cmd>DiffviewOpen<CR>", "Git diff" },
		r = { "<cmd>Git rebase<CR>", "Git rebase" },
		m = { "<cmd>Git mergetool<CR>", "Git mergetool" },
		t = { "<cmd>GitGutterToggle<CR>", "GitGutterToggle" },
	},
	m = {
		name = "Party time",
		r = { "<cmd>CellularAutomaton make_it_rain<CR>", "Make it rain" },
		l = { "<cmd>CellularAutomaton game_of_life<CR>", "Game of life" },
	},
	u = {
		name = "undo tree",
		u = { vim.cmd.UndotreeToggle, "Undo" },
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
	a = { mark.add_file, "Harpoon add" },
	h = { name = "gitSigns" },
}, { prefix = "<leader>" })

keymap("n", "<leader><Down>", "<C-W><C-J>", { silent = true, noremap = true })
keymap("n", "<leader><Up>", "<C-W><C-K>", { silent = true, noremap = true })
keymap("n", "<leader><Left>", "<C-W><C-H>", { silent = true, noremap = true })
keymap("n", "<leader><Right>", "<C-W><C-L>", { silent = true, noremap = true })

-- Context specific bindings
-- Lua
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { silent = true, noremap = true })
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { silent = true, noremap = true })
keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
--
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

-- {
-- s",
-- mode = { "n", "x", "o" },
-- function()
-- default options: exact mode, multi window, all directions, with a backdrop
-- require("flash").jump()
-- end,
-- },
-- {
-- "S",
-- mode = { "o", "x" },
-- function()
-- require("flash").treesitter()
-- end,
-- },
-- },
keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })

keymap("n", "<leader><leader>", function()
	vim.cmd("so")
	if vim.fn.exists(":PackerSync") ~= 0 then
		vim.cmd("silent! PackerSync")
	end
end)

local api = vim.api

-- keymap("n", "<CR>", ":noh<CR>", silent)

function PopupTerminal()
	local buf = api.nvim_create_buf(false, true)
	local width = math.floor(api.nvim_get_option("columns") * 0.4)
	local height = math.floor(api.nvim_get_option("lines"))
	local row = math.floor((api.nvim_get_option("lines") - height) / 2)
	local col = math.floor((api.nvim_get_option("columns") - width))

	local opts = {
		relative = "editor",
		row = row,
		col = col,
		width = width,
		height = height,
		style = "minimal",
		border = "rounded",
	}
	api.nvim_open_win(buf, true, opts)
	vim.cmd("terminal")
	api.nvim_buf_set_keymap(
		buf,
		"t",
		"<Esc>",
		"<C-\\><C-n>:close!<CR>",
		{ silent = true, nowait = true, noremap = true }
	)

	vim.cmd([[startinsert!]])
end

keymap("v", "E", ":m '>+1<CR>gv=gv", { silent = true, nowait = true, noremap = true })
keymap("v", "N", ":m '<-2<CR>gv=gv", { silent = true, nowait = true, noremap = true })
keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
-- keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

keymap("n", "<C-l>", "<C-d>zz")
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
vim.api.nvim_set_keymap("v", "<CR>", ":lua JumpToLineStartAndClearHighlights()<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<CR>", ":lua JumpToLineStartAndClearHighlights()<CR>", { silent = true, noremap = true })
function JumpToLineStartAndClearHighlights()
	vim.cmd("normal! ^")
	vim.cmd("silent! noh")
end

-- search selected code in workspace
keymap("v", "<leader>sv", live_grep_args_shortcuts.grep_visual_selection)

keymap("v", "p", '"_dP', silent)

keymap("i", "<C-c>", "<Esc>")

keymap("n", "Q", "<nop>")
-- Save file by CTRL-S
keymap("n", "<C-s>", ":w<CR>", silent)
keymap("i", "<C-s>", "<ESC> :w<CR>", silent)

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
	builtin.lsp_references({ fname_width = 100 })
end, { noremap = true, nowait = true, silent = true })

keymap(
	"n",
	"<C-c>",
	"<cmd>lua require('goto-preview').close_all_win()<CR><cmd>cclose<CR><cmd>DiffviewClose<CR>",
	{ noremap = true, nowait = true, silent = true }
)
-- toogle comments
vim.api.nvim_set_keymap("n", "tt", ":normal gcc<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "tb", ":normal gbc<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("v", "tt", ":normal gcc<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "tb", ":normal gbc<CR>", { noremap = true, silent = true })

keymap("n", "<C-b>", ui.toggle_quick_menu)
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

vim.keymap.set("i", "<c-t>", function()
	jfind.jfind({
		input = { 1, 2, 3, 4, 5 },
		preview = "figlet",
		previewPosition = "right",
		callback = function(result)
			print("result: " .. result)
		end,
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

keymap("n", "<C-z>", function()
	ui.nav_file(1)
end)
keymap("v", "<C-z>", function()
	ui.nav_file(1)
end)
keymap("x", "<C-z>", function()
	ui.nav_file(1)
end)
keymap("s", "<C-z>", function()
	ui.nav_file(1)
end)
keymap("o", "<C-z>", function()
	ui.nav_file(1)
end)
keymap("i", "<C-z>", function()
	ui.nav_file(1)
end)
keymap("c", "<C-z>", function()
	ui.nav_file(1)
end)
keymap("t", "<C-z>", function()
	ui.nav_file(1)
end)
keymap("n", "<C-f>", function()
	ui.nav_file(2)
end)
keymap("n", "<C-o>", function()
	ui.nav_file(3)
end)
keymap("n", "<C-u>", function()
	ui.nav_file(4)
end)

keymap("i", "<M-n>", "<Plug>(copilot-next)", { silent = true, noremap = true })
keymap("i", "<M-e>", "<Plug>(copilot-previous)", { silent = true, noremap = true })
keymap("i", "<M-u>", "<cmd> Copilot<CR>", { silent = true, noremap = true })

require("gitsigns").setup({
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 100,
		ignore_whitespace = false,
	},
	current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
	on_attach = function(bufnr)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			keymap(mode, l, r, opts)
		end

		-- Navigation
		map("n", "g(", function()
			if vim.wo.diff then
				return "g("
			end
			vim.schedule(function()
				gs.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "k(", function()
			if vim.wo.diff then
				return "k("
			end
			vim.schedule(function()
				gs.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		wk.register({
			h = {
				name = "gitSigns",
				s = { gs.stage_hunk, "stage / unstage" },
				-- s = {
				-- function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
				-- "stage / unstage",
				-- mode = "v"
				-- },
				r = { gs.reset_hunk, "reset hunk" },
				-- r = {
				-- function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
				-- "reset hunk",
				-- mode = "v"
				-- },
				S = { gs.stage_buffer, "stage buffer" },
				u = { gs.undo_stage_hunk, "undo stage hunk" },
				R = { gs.reset_buffer, "reset buffer" },
				p = { gs.preview_hunk, "preview hunk" },
				b = {
					function()
						gs.blame_line({ full = true })
					end,
					"blame line",
				},
				t = { gs.toggle_current_line_blame, "toggle current line blame" },
				d = { gs.diffthis, "diffthis" },
				D = {
					function()
						gs.diffthis("~")
					end,
					"diffthis ~",
				},
			},
			t = { gs.toggle_deletion, "toogle deleted" },
		}, { prefix = "<leader>" })

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
})

--flash
