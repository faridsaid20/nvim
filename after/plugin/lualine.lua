local status, lualine = pcall(require, "lualine")
if not status then
	return
end

local nightfly = require("lualine.themes.onedark")
local new_colors = {
	yellow = "#e0af68",
	green = "#3EFFDC",
	violet = "#FF61EF",
	black = "#000000",
	blue = "#61D1FF",
	red = "#e86671",
}
-- nightfly.normal.a.bg = new_colors.blue
-- nightfly.insert.a.bg = new_colors.green
-- nightfly.visual.a.bg = new_colors.violet
-- nightfly.replace.a.bg = new_colors.red
-- nightfly.command = {
-- a = {
-- bg = new_colors.yellow,
-- fg = new_colors.black,
-- gui = "bold"
-- }
-- }

-- nightfly.normal.c.bg = nil
-- nightfly.inactive.c.bg = nil
lualine.setup({
	options = {
		theme = nightfly,
		disabled_filetypes = { "packer", "NvimTree" },
	},
	sections = {
		lualine_b = {
			{
				"branch",
				"diff",
				"diagnostics",
			},
		},
		lualine_c = {
			{
				"filename",
				path = 3,
			},
		},
	},
	inactive_sections = {
		lualine_a = { "mode" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})
