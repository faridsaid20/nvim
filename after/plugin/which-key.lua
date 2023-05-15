local ui = require("harpoon.ui")
local mark = require("harpoon.mark")
local wk = require("which-key")
local builtin = require('telescope.builtin')
local chatgpt = require("chatgpt")

local keymap = vim.keymap.set
local silent = { silent = true }
vim.g.mapleader = " "

require("harpoon").setup({
    menu = {
        width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
    },
})

wk.register({
    p = {
        name = "telescope/gpt",                                    -- optional group name
        p = { builtin.find_files, "Find File" },                   -- create a binding with label
        r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" }, -- additional options for creating the keymap
        s = { builtin.live_grep, "Search" },                       -- just a label. don't create any mapping
        h = { builtin.help_tags, "Help tags" },                    -- same as above
        c = { builtin.commands, "Commands" },                      -- special label to hide it in the popup
        b = { builtin.buffers, "Buffers" },                        -- you can also pass functions!
        f = { ":NvimTreeToggle<CR>", "Toggle NvimTree" },
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
        r = { vim.lsp.buf.rename, "rename all occurences", mode = "v" },
        s = { [[*]], "Search in current buff" },
        g = { builtin.grep_string, "Grep in workspace" },
        f = { builtin.current_buffer_fuzzy_find, "Fuzzy fund in current buffer" },
    },
    -- x = {
    -- name = "executable file",
    -- x = { "<cmd>!chmod +x %<CR>", "Make executable" },
    -- },
    b = {
        name = "build",
        c = { "<cmd>make<CR>", "Compile" },
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
        d = { "<cmd>Git diff<CR>", "Git diff" },
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
        name = "Save and quit"
    },
    f = { vim.lsp.buf.format, "Format" },
    qq = { "<cmd>q!<CR>", "Quit without saving" },
    q = { "<cmd>q<CR>", "Quit" },
    a = { mark.add_file, "Harpoon add" },
    h = { name = "gitSigns" },
    n = { "<C-w>h", "Next window", nowait = true },
    e = { "<C-w>l", "Previous window", nowait = true },
}, { prefix = "<leader>" })

-- Lua
keymap("n", "<leader>xx", "<cmd>TroubleToggle<cr>",
    { silent = true, noremap = true }
)
keymap("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
    { silent = true, noremap = true }
)
keymap("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>",
    { silent = true, noremap = true }
)
keymap("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>",
    { silent = true, noremap = true }
)
keymap("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
    { silent = true, noremap = true }
)
keymap("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
    { silent = true, noremap = true }
)

-- keymap("n", "<leader><leader>", function()
    -- vim.cmd("so")
    -- " if vim.fn.exists(':PackerSync') ~= 0 then
        -- vim.cmd('silent! PackerSync')
    -- " end
-- end)

local api = vim.api

-- keymap("n", "<CR>", ":noh<CR>", silent)

function PopupTerminal()
    local buf = api.nvim_create_buf(false, true)
    local width = math.floor(api.nvim_get_option("columns") * 0.4)
    local height = math.floor(api.nvim_get_option("lines"))
    local row = math.floor((api.nvim_get_option("lines") - height) / 2)
    local col = math.floor((api.nvim_get_option("columns") - width))
    local opts = {
        relative = 'editor',
        row = row,
        col = col,
        width = width,
        height = height,
        style = 'minimal',
        border = 'rounded',
    }
    api.nvim_open_win(buf, true, opts)
    vim.cmd("terminal")
    api.nvim_buf_set_keymap(buf, 't', '<Esc>', '<C-\\><C-n>:close!<CR>', { silent = true, nowait = true, noremap = true })

    vim.cmd([[startinsert!]])
end

keymap("v", "N", ":m '>+1<CR>gv=gv")
keymap("v", "E", ":m '<-2<CR>gv=gv")
keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
-- keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

keymap("n", "<C-f>", "<C-d>zz")
keymap("n", "<C-p>", "<C-u>zz")

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
vim.api.nvim_set_keymap('v', '<CR>', ':lua JumpToLineStartAndClearHighlights()<CR>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<CR>', ':lua JumpToLineStartAndClearHighlights()<CR>', { silent = true, noremap = true })
function JumpToLineStartAndClearHighlights()
    vim.cmd('normal! ^')
    vim.cmd('silent! noh')
end

-- keymap("n", "<C-m>", function()
-- vim.cmd("silent! noh")
-- vim.cmd("normal! 0")
-- end)
-- autocmd VimEnter * nnoremap <C-e> $
-- autocmd VimEnter * inoremap <C-e> $
-- autocmd VimEnter * vnoremap <C-e> $
-- autocmd VimEnter * nnoremap <C-m> 0
-- autocmd VimEnter * inoremap <C-m> 0
-- autocmd VimEnter * vnoremap <C-m> 0

keymap("v", "p", '"_dP', silent)

keymap("i", "<C-c>", "<Esc>")

keymap("n", "Q", "<nop>")
-- Save file by CTRL-S
keymap("n", "<C-s>", ":w<CR>", silent)
keymap("i", "<C-s>", "<ESC> :w<CR>", silent)

keymap("n", "<C-k>", "<cmd>cnext<CR>zz")
keymap("n", "<C-h>", "<cmd>cprev<CR>zz")
keymap("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap("n", "<leader>j", "<cmd>lprev<CR>zz")
keymap("n", "gp", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
    { noremap = true, nowait = true })
keymap("n", "gt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
    { noremap = true, nowait = true })
keymap("n", "rp", "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
    { noremap = true, nowait = true })

keymap("n", "<C-c>", "<cmd>lua require('goto-preview').close_all_win()<CR><cmd>cclose<CR>",
    { noremap = true, nowait = true, silent = true })
-- toogle comments
vim.api.nvim_set_keymap('n', 'tt', ':normal gcc<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'tb', ':normal gbc<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('v', 'tt', ':normal gcc<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', 'tb', ':normal gbc<CR>', { noremap = true, silent = true })

keymap("n", "<C-b>", ui.toggle_quick_menu)

keymap("n", "<C-j>", function() ui.nav_file(1) end)
keymap("n", "<C-l>", function() ui.nav_file(2) end)
keymap("n", "<C-u>", function() ui.nav_file(3) end)
keymap("n", "<C-y>", function() ui.nav_file(4) end)

keymap('i', '<M-n>', '<Plug>(copilot-next)', { silent = true, noremap = true })
keymap('i', '<M-e>', '<Plug>(copilot-previous)', { silent = true, noremap = true })
keymap('i', '<M-u>', '<cmd> Copilot<CR>', { silent = true, noremap = true })

require('gitsigns').setup {
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 100,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            keymap(mode, l, r, opts)
        end

        -- Navigation
        map('n', 'g(', function()
            if vim.wo.diff then return 'g(' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', 'v(', function()
            if vim.wo.diff then return 'v(' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        wk.register({
            h = {
                name = "gitSigns",
                s = { gs.stage_hunk, "stage / unstage" },
                s = {
                    function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                    "stage / unstage",
                    mode = "v"
                },
                r = { gs.reset_hunk, "reset hunk" },
                r = {
                    function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end,
                    "reset hunk",
                    mode = "v"
                },
                S = { gs.stage_buffer, "stage buffer" },
                u = { gs.undo_stage_hunk, "undo stage hunk" },
                R = { gs.reset_buffer, "reset buffer" },
                p = { gs.preview_hunk, "preview hunk" },
                b = { function() gs.blame_line { full = true } end, "blame line" },
                t = { gs.toggle_current_line_blame, "toggle current line blame" },
                d = { gs.diffthis, "diffthis" },
                D = { function() gs.diffthis('~') end, "diffthis ~" },
            },
            t = { gs.toggle_deletion, "toogle deleted" },
        }, { prefix = "<leader>" }
        )


        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}
