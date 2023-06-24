require("Farid.set")

vim.cmd [[
  augroup strdr4605
    autocmd FileType typescript,typescriptreact compiler tsc | setlocal makeprg=npx\ tsc
  augroup END
]]

vim.cmd [[
augroup custom_keymaps
    autocmd!
    " autocmd VimEnter * nnoremap <C-e> $
    " autocmd VimEnter * inoremap <C-e> $
    " autocmd VimEnter * vnoremap <C-e> $
    " autocmd VimEnter * nnoremap <C-m> 0
    " autocmd VimEnter * inoremap <C-m> 0
    " autocmd VimEnter * noremap a i
    " autocmd VimEnter * noremap m h
    " autocmd VimEnter * noremap n j
    " autocmd VimEnter * noremap e k
    " autocmd VimEnter * noremap i l

    " autocmd VimEnter * nnoremap <C-Z> <Nop>

    autocmd VimEnter * nnoremap <C-A> <C-O>
   " autocmd VimEnter * vnoremap <C-m> 0
    " autocmd VimEnter * nnoremap rs :Telescope lsp_references<CR>
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
