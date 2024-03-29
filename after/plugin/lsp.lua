local lsp = require("lsp-zero")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

lsp.preset("recommended")

lsp.ensure_installed({
	"rust_analyzer",
})
require("lspconfig").cssmodules_ls.setup({
	-- provide your on_attach to bind keymappings
	on_attach = lsp.on_attach,
	-- optionally
	init_options = {
		camelCase = false,
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
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
require("lspconfig").pyright.setup({
	on_attach = lsp.on_attach,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "off",
			},
		},
	},
})
require("lspconfig").clangd.setup({
	on_attach = function(client, bufnr)
		lsp.on_attach(client, bufnr)
	end,

	init_options = {
		usePlaceholders = true,
		clangdFileStatus = true,
	},
	cmd = {
		"clangd",
		"--clang-tidy",
		"--completion-style=detailed",
		"--offset-encoding=utf-16",
		"--background-index",
		"--all-scopes-completion",
		"--query-driver=/opt/sdks/rcsos-2.4.0/x86_4.4.50-rt63/sysroots/x86_64-rcssdk-linux/usr/bin/i586-rcs-linux/i586-rcs-linux-g++",
	},
})

-- require("lspconfig").clangd.setup({
-- on_attach = on_attach,
-- init_options = {
-- usePlaceholders = true,
-- completeUnimported = true,
-- clangdFileStatus = true,
-- },
-- capabilities = cmp_nvim_lsp.default_capabilities(),
-- cmd = {
-- "env",
-- /usr/include/c++/11
-- /usr/include/x86_64-linux-gnu/c++/11
-- /usr/include/c++/11/backward
-- /usr/lib/gcc/x86_64-linux-gnu/11/include
-- /usr/local/include
-- /usr/include/x86_64-linux-gnu
-- /usr/include
-- "CPATH=/usr/include/c++/11:/usr/include/x86_64-linux-gnu/c++/11:/usr/include/c++/11/backward:/usr/lib/gcc/x86_64-linux-gnu/11/include:/usr/local/include:/usr/include/x86_64-linux-gnu:/usr/include",
-- "clangd",
-- "--clang-tidy",
-- "--background-index",
-- "--header-insertion=iwyu",
-- "--completion-style=detailed",
-- "--function-arg-placeholders",
-- "--fallback-style=llvm",
-- "--offset-encoding=utf-16",
-- "--query-driver=/opt/sdks/rcsos-2.4.0/x86_4.4.50-rt63/sysroots/x86_64-rcssdk-linux/usr/bin/i586-rcs-linux/i586-rcs-linux-g++"
-- "--query-driver=/opt/sdks/rcsos-3.3.0/x86-64_4.19.180-rt73/sysroots/x86_64-rcsossdk-linux/usr/bin/x86_64-rcsos-linux/x86_64-rcsos-linux-g++"
-- },
-- })
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

local function goToDefinition()
	local success, err = pcall(function()
		vim.cmd("TSToolsGoToSourceDefinition")
	end)
	-- If TSToolsGoToSourceDefinition fails, call vim.lsp.buf.definition()
	if not success then
		vim.lsp.buf.definition()
	end
end

local keymap = function(mode, key, action, desc, buffer)
	vim.keymap.set(mode, key, action, { noremap = true, silent = true, desc = desc, buffer = buffer })
end

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	if client.server_capabilities.inlayHintProvider then
		vim.lsp.inlay_hint.enable(bufnr, true)
	else
		print("no inlay hints available")
	end
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
		require("conform").format({ bufnr = bufnr })
	end, "Format", bufnr)

	vim.keymap.set("n", "gd", function()
		goToDefinition()
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
lsp.capabilities = capabilities

-- vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
-- vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
