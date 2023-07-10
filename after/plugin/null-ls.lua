local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions

null_ls.setup({
	debug = false,
	sources = {
		formatting.stylua,
		formatting.prettierd,
		formatting.clang_format,
		formatting.isort,
		formatting.black,
		formatting.beautysh,
        formatting.eslint_d,
		diagnostics.eslint_d,
		diagnostics.zsh,
        diagnostics.flake8,
        diagnostics.mypy,
        diagnostics.shellcheck,
		code_actions.eslint_d,
        code_actions.shellcheck,
	},
})
