local lsp = require("lsp-zero")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

lsp.preset("recommended")

lsp.ensure_installed({
	"rust_analyzer",
})
require'lspconfig'.cssmodules_ls.setup {
    -- provide your on_attach to bind keymappings
    on_attach = custom_on_attach,
    -- optionally
    init_options = {
        camelCase = false,
    },
}
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
-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<Up>"] = cmp.mapping.select_prev_item(cmp_select),
	["<Down>"] = cmp.mapping.select_next_item(cmp_select),
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	["<C-Space>"] = cmp.mapping.complete(),
    ["<C-y>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
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
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{
			name = "cmdline",
			option = {
				ignore_cmds = { "Man", "!" },
			},
		},
	}),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
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

local function goToDefinition(bufnr)
	-- Get all clients attached to the buffer
	local clients = vim.lsp.buf_get_clients(bufnr)
	-- Print the client names
	local isTs = false
	for _, client in ipairs(clients) do
		if client.name == "typescript-tools" then
			isTs = true
		end
	end
	if isTs then
		vim.cmd("TSToolsGoToSourceDefinition")
	else
		vim.lsp.buf.definition()
	end
end

local function format(buf)
	local null_ls_sources = require("null-ls.sources")
	local ft = vim.bo[buf].filetype
	local has_null_ls = #null_ls_sources.get_available(ft, "NULL_LS_FORMATTING") > 0

	vim.lsp.buf.format({
		bufnr = buf,
		async = true,
		filter = function(client)
			if has_null_ls then
				return client.name == "null-ls"
			else
				return true
			end
		end,
	})
end

local keymap = function(mode, key, action, desc, buffer)
	vim.keymap.set(mode, key, action, { noremap = true, silent = true, desc = desc, buffer = buffer })
end

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }
	keymap("n", "<leader>vw", function()
		vim.lsp.buf.workspace_symbol()
	end, "Workspace symbol", bufnr)
	keymap("n", "<leader>vd", function()
		vim.diagnostic.open_float()
	end, "Diagnostic", bufnr)
	keymap("n", "<leader>va", function()
		vim.lsp.buf.code_action()
	end, "Code action", bufnr)
	keymap("n", "<leader>vr", function()
		vim.lsp.buf.rename()
	end, "Rename", bufnr)
	keymap("n", "<leader>f", function()
		format(bufnr)
	end, "Format", bufnr)

	vim.keymap.set("n", "gd", function()
		goToDefinition(bufnr)
	end, opts)
	vim.keymap.set("n", "gs", function()
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
