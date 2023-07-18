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

require("lazy").setup({
	{"nvim-telescope/telescope.nvim",
		version = "0.1.2",
		-- or                            , branch = '0.1.x'
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			config = function()
				require("telescope").load_extension("live_grep_args")
			end,
		},
	},

	{"nvim-treesitter/nvim-treesitter-context"}, -- sticky headers
	{"nvim-treesitter/nvim-treesitter",  build = ":TSUpdate" },
	
	{"theprimeagen/harpoon",
		config = function()
			require("harpoon").setup({
				menu = {
					width = 100,
				},
			})
		end,
	},
	{"mbbill/undotree"}, -- undo tree
	
	{"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			-- 
			{ "neovim/nvim-lspconfig" }, -- Required
			{
				-- Optional
				"williamboman/mason.nvim",
				build = ":MasonUpdate",
			},
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "onsails/lspkind-nvim" }, -- Optional
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-nvim-lua" },
			{ "hrsh7th/cmp-cmdline" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
		},
	},
	{"rafamadriz/friendly-snippets"},
	{"nvim-lua/plenary.nvim"},
	
	{"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	},
	 {"zbirenbaum/copilot.lua" },
	
	{	"numToStr/Comment.nvim", -- toggle comments
		config = function()
			require("Comment").setup()
		end,
	},
	
	{"nvim-tree/nvim-tree.lua", -- file tree
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	 {"sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" }, -- diffview
	{"jose-elias-alvarez/null-ls.nvim"}, -- required
	{"nvim-lualine/lualine.nvim"}, -- statusline

	{"eandrju/cellular-automaton.nvim"}, -- party time
	
	{	"folke/flash.nvim",
		config = function()
			require("flash").setup({
				modes = {
					char = {
						enabled = false,
					},
				},
				label = {
					rainbow = {
						enabled = true,
						-- number between 1 and 9
						shade = 5,
					},
				},
				-- labels = "etovxmpdygfblzhckisuranqwj/?",
			})
		end,
	},
	
	{	"ThePrimeagen/refactoring.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
		config = function()
			require("refactoring").setup({
				prompt_func_return_type = {
					go = true,
					cpp = true,
					c = true,
					java = true,
				},
				-- prompt for function parameters
				prompt_func_param_type = {
					go = true,
					cpp = true,
					c = true,
					java = true,
				},
			})
		end,
	},
	-- Packer
	
	{	"folke/noice.nvim", -- noice is a nice way to configure Neovim
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
				messages = {
					enabled = false,
				},
				-- you can enable a preset for easie rconfiguration
				presets = {
					bottom_search = false, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = false, -- add a border to hover docs and signature help
				},
			})
		end,
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	
	{	"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "mg979/vim-visual-multi", branch = "master" }, -- multiple cursors
	-- Lua
	
	{	"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				operators = { gc = "Comments", presets = true },
			})
		end,
	},
	
	{	"jake-stewart/jfind.nvim",
		branch = "2.0",
	},
	-- Packer
	
	{	
    "faridsaid20/ChatGPT.nvim",
		config = function()
			require("chatgpt").setup({
			})
		end,
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	},
	
	{	"windwp/nvim-autopairs", -- autopairs for nvim written by lua
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	
	{	"lewis6991/gitsigns.nvim",
	},
  {
    "navarasu/onedark.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
       require('onedark').setup {
        style = 'dark',
        transparent = true,  -- Show/hide background
    }
      -- load the colorscheme here
      vim.cmd([[colorscheme onedark]])
    end,
  },
	{"lukas-reineke/indent-blankline.nvim"}, -- highlight scope lines
	{"RRethy/vim-illuminate"}, -- highlight other uses of the word under the cursor
	
	{	"rmagatti/goto-preview", -- preview definition
		config = function()
			require("goto-preview").setup({})
		end,
	},
	{ "kevinhwang91/nvim-bqf" }, -- quickfix preview window
	 {"windwp/nvim-ts-autotag" }, -- auto close tags
	{"norcalli/nvim-colorizer.lua"},-- colorize hex colors
	 {"akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	 {"echasnovski/mini.ai", branch = "stable" },
	 { dir = "/home/ubuntu/workspace/logsitter.nvim", dependencies = { "nvim-treesitter/nvim-treesitter" } },
	{
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-/>]],
			})
		end,
	},
	{"ThePrimeagen/vim-be-good"}
})
