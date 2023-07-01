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
    autocmd VimEnter * set cmdheight=1
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
