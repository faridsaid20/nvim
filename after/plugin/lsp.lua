local wk = require("which-key")
local lsp = require("lsp-zero")
local lspkind = require("lspkind")

lsp.preset("recommended")

lsp.ensure_installed({
	"eslint",
	"rust_analyzer",
})
require("typescript-tools").setup({
	on_attach = on_attach,
	settings = {
		-- spawn additional tsserver instance to calculate diagnostics on it
		separate_diagnostic_server = true,
		-- "change"|"insert_leave" determine when the client asks the server about diagnostic
		publish_diagnostic_on = "insert_leave",
		-- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
		-- (see 💅 `styled-components` support section)
		tsserver_plugins = { "typescript-styled-plugin" },
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
-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require("cmp")
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
	['<Down>'] = cmp.mapping.select_next_item(cmp_select),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
	["<C-e>"] = cmp.mapping.close(),
})

cmp_mappings["<Tab>"] = nil
cmp_mappings["<C-n>"] = nil
cmp_mappings["<C-p>"] = nil
local cmp_nvim_lsp = require("cmp_nvim_lsp")

require("lspconfig").pyright.setup({
	capabilities = cmp_nvim_lsp.default_capabilities(),
	on_attach = on_attach,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "off",
			},
		},
	},
})

require("lspconfig").clangd.setup({
	on_attach = on_attach,
	init_options = {
		compilationDatabasePath = "./build/rcsos-2.4.0_x86_4.4.50-rt63/Release/",
	},
	capabilities = cmp_nvim_lsp.default_capabilities(),
	cmd = {
		"env",

		-- /usr/include/c++/11
		-- /usr/include/x86_64-linux-gnu/c++/11
		-- /usr/include/c++/11/backward
		-- /usr/lib/gcc/x86_64-linux-gnu/11/include
		-- /usr/local/include
		-- /usr/include/x86_64-linux-gnu
		-- /usr/include
		"CPATH=/usr/include/c++/11:/usr/include/x86_64-linux-gnu/c++/11:/usr/include/c++/11/backward:/usr/lib/gcc/x86_64-linux-gnu/11/include:/usr/local/include:/usr/include/x86_64-linux-gnu:/usr/include",
		"clangd",
		"--offset-encoding=utf-16",
	},
})
lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
	},
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol_text", -- show only symbol annotations
			maxwidth = 70, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
			ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

			-- The function below will be called before any actual modifications from lspkind
			-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
			before = function(entry, vim_item)
				return vim_item
			end,
		}),
	},
})

lsp.set_preferences({
	suggest_lsp_servers = true,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})
lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	wk.register({
		v = {
			name = "lsp", -- optional group name
			w = {
				function()
					vim.lsp.buf.workspace_symbol()
				end,
				"Workspace symbol",
				opts,
			},
			d = {
				function()
					vim.diagnostic.open_float()
				end,
				"diagnostic",
				opts,
			},
			a = {
				function()
					vim.lsp.buf.code_action()
				end,
				"Code action",
				opts,
			},
			r = {
				function()
					vim.lsp.buf.rename()
				end,
				"Rename",
				opts,
			}, -- create a binding with label
		},
	}, { prefix = "<leader>" })

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "gD", function()
		vim.lsp.buf.declaration()
	end, opts)
	vim.keymap.set("n", "gi", function()
		vim.lsp.buf.implementation()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("i", "<C-h>", function()
		vim.lsp.buf.signature_help()
	end, opts)
end)

-- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
-- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})

