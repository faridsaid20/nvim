require("Farid.set")

vim.cmd([[
  augroup strdr4605
    autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc
  augroup END
]])

vim.cmd([[
augroup custom_keymaps
    autocmd!
    autocmd VimEnter * nnoremap <C-A> <C-O>

    autocmd VimEnter * inoremap <C-t> <Nop>
    autocmd VimEnter * set cmdheight=1
    autocmd FileType python setlocal scroll=30
augroup END
]])

vim.cmd([[
augroup custom_cursor
    autocmd!
    autocmd VimEnter * set ttimeout
    autocmd VimEnter * set ttimeoutlen=1
    autocmd VimEnter * set ttyfast
    autocmd VimEnter * highlight Cursor guibg=violet
    " autocmd VimEnter * highlight iCursor guibg=white
    " autocmd VimEnter * set guicursor+=i:ver100-iCursor
    " autocmd VimEnter * set guicursor+=i:blinkon175
    autocmd VimEnter * set guicursor+=v:block-Cursor
augroup END
]])

local aug = vim.api.nvim_create_augroup("buf_large", { clear = true })

vim.api.nvim_create_autocmd({ "BufReadPre" }, {
	callback = function()
		local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
		if ok and stats and (stats.size > 100000) then
			vim.b.large_buf = true
			vim.cmd("syntax off")
			vim.cmd("IlluminatePauseBuf") -- disable vim-illuminate
			vim.opt_local.foldmethod = "manual"
		else
			vim.b.large_buf = false
		end
	end,
	group = aug,
	pattern = "*",
})

vim.cmd([[ autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false}) ]])
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.g.neovide then
	-- Put anything you want to happen only in Neovide here
	vim.g.neovide_cursor_unfocused_outline_width = 0.125

	vim.g.neovide_confirm_quit = false

	vim.g.neovide_floating_blur_amount_x = 2.0
	vim.g.neovide_floating_blur_amount_y = 2.0
	vim.g.neovide_fullscreen = false
    vim.g.neovide_cursor_animate_in_insert_mode = true
	vim.g.neovide_scroll_animation_far_lines = 10
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
