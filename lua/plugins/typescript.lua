return {
	"pmizio/typescript-tools.nvim",
    event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	config = function()
		require("typescript-tools").setup({
			on_attach = function(client)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
			settings = {
				-- spawn additional tsserver instance to calculate diagnostics on it
				separate_diagnostic_server = true,
				-- "change"|"insert_leave" determine when the client asks the server about diagnostic
				publish_diagnostic_on = "insert_leave",
				-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
				-- (see 💅 `styled-components` support section)
				tsserver_plugins = { "@styled/typescript-styled-plugin", "typescript-plugin-css-modules" },
				-- described below
				tsserver_format_options = {},
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = false,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayVariableTypeHintsWhenTypeMatchesName = false,
					includeInlayFunctionLikeReturnTypeHints = true,
				},
			},
		})
	end,
}
