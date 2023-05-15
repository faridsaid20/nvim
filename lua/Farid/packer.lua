-- Thi file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x'
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use 'nvim-treesitter/nvim-treesitter-context' -- sticky headers
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use { 'theprimeagen/harpoon',
        config = function()
            require("harpoon").setup({
                menu = {
                    width = 100
                },
            })
        end
    }
    use('mbbill/undotree')    -- undo tree
    use('tpope/vim-fugitive') -- git
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'onsails/lspkind-nvim' }, -- Optional
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
            { 'saadparwaiz1/cmp_luasnip' },     -- Optional

        }
    }
    use("github/copilot.vim") -- github copilot
    use {
        'phaazon/hop.nvim',   -- hop motion
        branch = 'v2',        -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }
    use {
        'numToStr/Comment.nvim', -- toggle comments
        config = function()
            require('Comment').setup()
        end
    }
    use {
        'nvim-tree/nvim-tree.lua', -- file tree
        requires = {
            'nvim-tree/nvim-web-devicons',
        },

        config = function()
            require("nvim-tree").setup {}
        end
    }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' } -- diffview
    use "jose-elias-alvarez/null-ls.nvim"                                -- required
    use 'nvim-lualine/lualine.nvim'                                      -- statusline

    use 'eandrju/cellular-automaton.nvim'                                -- party time
    -- Packer
    use({
        "folke/noice.nvim", -- noice is a nice way to configure Neovim
        config = function()
            require("noice").setup({
                popupmenu = {
                    backend = "cmp",
                },
                progress = {

                    enabled = false,
                },
                -- add any options here lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                -- you can enable a preset for easie rconfiguration
                presets = {
                    bottom_search = false,        -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
            })
        end,
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        }
    })
    use { 'mg979/vim-visual-multi', branch = 'master' } -- multiple cursors
    -- Lua
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
                operators = { gc = "Comments", presets = true },
            }
        end
    }
    -- Packer
    use({
        "/home/ubuntu/.config/nvim/ChatGPT.nvim",
        config = function()
            require("chatgpt").setup({
                actions_path = "/home/ubuntu/.config/nvim/lua/Farid/gptactions.json",
            })
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim"
        }
    })
    use {
        "windwp/nvim-autopairs", -- autopairs for nvim written by lua
        config = function() require("nvim-autopairs").setup {} end
    }
    use {
        'lewis6991/gitsigns.nvim',
    }
    use 'Mofiqul/vscode.nvim'
    use 'tomasiser/vim-code-dark'
    -- use { "olimorris/onedarkpro.nvim",
    -- }
    -- Using Packer
    use 'navarasu/onedark.nvim'
    use "lukas-reineke/indent-blankline.nvim" -- highlight scope lines
    use "RRethy/vim-illuminate"               -- highlight other uses of the word under the cursor
    use {
        'rmagatti/goto-preview',              -- preview definition
        config = function()
            require('goto-preview').setup {}
        end
    }
    -- Lua
    use {
        "folke/trouble.nvim", -- preview definition
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    use { 'kevinhwang91/nvim-bqf' }   -- quickfix preview window
    use { "windwp/nvim-ts-autotag" }  -- auto close tags
    use 'norcalli/nvim-colorizer.lua' -- colorize hex colors
end)
