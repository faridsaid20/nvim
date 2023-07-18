vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.nvim_tree_respect_buf_cwd = 1
vim.g.nvim_tree_view_flat = 1
return {
	"nvim-tree/nvim-tree.lua", -- file tree
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>py", mode = "n", ":NvimTreeToggle<CR>", desc = "Toggle NvimTree", silent = true },
	},
	config = function()
		require("nvim-tree").setup({
			sort_by = "case_sensitive",
			view = {
				adaptive_size = true,
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
			},
		})
	end,
}
