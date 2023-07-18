function ColorMyPencils(color)
    vim.cmd [[set t_ut=]]
    vim.cmd [[highlight IndentBlanklineContextChar guifg=#C678DD gui=nocombine]]
    vim.cmd [[highlight IndentBlanklineChar guifg=#666666 gui=nocombine]]
    vim.cmd [[highlight NotifyBackground guibg=#000000 gui=nocombine]]

    --require("indent_blankline").setup {
       -- space_char_blankline = " ",
      --  show_current_context = true,
     --   show_current_context_start = true,
    --    show_end_of_line = true,
   -- }

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
