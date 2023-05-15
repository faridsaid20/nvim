vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.nvim_tree_view_flat = 1
-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        width = 40,
    },
    renderer = {
        group_empty = true,
    },
    update_focused_file = {
        enable = true,
        update_root = false,
        ignore_list = {},
    },
    filters = {
        dotfiles = false,
    },
    git = {
        enable = false,
        ignore = {},
    },
})
