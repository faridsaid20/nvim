require("Farid.set")

vim.cmd [[
  augroup strdr4605
    autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc
  augroup END
]]

vim.cmd [[
augroup custom_keymaps
    autocmd!
    autocmd VimEnter * nnoremap <C-A> <C-O>

    autocmd VimEnter * inoremap <C-t> <Nop>
    autocmd VimEnter * set cmdheight=1
    autocmd FileType python setlocal scroll=30
augroup END
]]

vim.cmd [[
augroup custom_cursor
    autocmd!
    autocmd VimEnter * set ttimeout
    autocmd VimEnter * set ttimeoutlen=1
    autocmd VimEnter * set ttyfast
    autocmd VimEnter * highlight Cursor guibg=violet
    autocmd VimEnter * highlight iCursor guibg=white
    autocmd VimEnter * set guicursor+=i:ver100-iCursor
    autocmd VimEnter * set guicursor+=i:blinkon175
    autocmd VimEnter * set guicursor+=v:block-Cursor
augroup END
]]

vim.cmd [[ autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false}) ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "
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
