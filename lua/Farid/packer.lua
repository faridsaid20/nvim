-- Thi file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd([[packadd packer.nvim]])
return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		-- or                            , branch = '0.1.x'
		requires = {
			{ "/vim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope-live-grep-args.nvim" },
			config = function()
				require("telescope").load_extension("live_grep_args")
			end,
		},
	})

	use("nvim-treesitter/nvim-treesitter-context") -- sticky headers
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	use({
		"theprimeagen/harpoon",
		config = function()
			require("harpoon").setup({
				menu = {
					width = 100,
				},
			})
		end,
	})
	use("mbbill/undotree") -- undo tree
	use("tpope/vim-fugitive") -- git
	use({
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{
				-- Optional
				"williamboman/mason.nvim",
				run = ":MasonUpdate",
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
	})
	use("nvim-lua/plenary.nvim")
	use({
		"pmizio/typescript-tools.nvim",
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	})
	use({ "zbirenbaum/copilot.lua" })
	use({
		"numToStr/Comment.nvim", -- toggle comments
		config = function()
			require("Comment").setup()
		end,
	})
	use({
		"nvim-tree/nvim-tree.lua", -- file tree
		requires = {
			"nvim-tree/nvim-web-devicons",
		},
	})
	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" }) -- diffview
	use("jose-elias-alvarez/null-ls.nvim") -- required
	use("nvim-lualine/lualine.nvim") -- statusline

	use("eandrju/cellular-automaton.nvim") -- party time
	use({
		"folke/flash.nvim",
		config = function()
			require("flash").setup({
				modes = {
					char = {
						enabled = false,
					},
				},
				highlight = {
					label = {
						rainbow = {
							enabled = true,
							-- number between 1 and 9
							shade = 5,
						},
					},
				},
				-- labels = "etovxmpdygfblzhckisuranqwj/?",
			})
		end,
	})
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
		requires = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	})
	use({
		"goolord/alpha-nvim",
		requires = { "nvim-tree/nvim-web-devicons" },
	})
	use({ "mg979/vim-visual-multi", branch = "master" }) -- multiple cursors
	-- Lua
	use({
		"folke/which-key.nvim",
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
	})
	use({
		"jake-stewart/jfind.nvim",
		branch = "2.0",
	})
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
			"nvim-telescope/telescope.nvim",
		},
	})
	use({
		"windwp/nvim-autopairs", -- autopairs for nvim written by lua
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})
	use({
		"lewis6991/gitsigns.nvim",
	})
	use("navarasu/onedark.nvim")
	use("folke/tokyonight.nvim")
	use("lukas-reineke/indent-blankline.nvim") -- highlight scope lines
	use("RRethy/vim-illuminate") -- highlight other uses of the word under the cursor
	use({
		"rmagatti/goto-preview", -- preview definition
		config = function()
			require("goto-preview").setup({})
		end,
	})
	-- Lua
	use({
		"folke/trouble.nvim", -- preview definition
		requires = "nvim-tree/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})
	use({ "kevinhwang91/nvim-bqf" }) -- quickfix preview window
	use({ "windwp/nvim-ts-autotag" }) -- auto close tags
	use("norcalli/nvim-colorizer.lua") -- colorize hex colors
	use({ "akinsho/bufferline.nvim", tag = "*", requires = "nvim-tree/nvim-web-devicons" })
	use({ "echasnovski/mini.ai", branch = "stable" })
	use({ "/home/ubuntu/workspace/logsitter.nvim", requires = { "nvim-treesitter/nvim-treesitter" } })
	use({
		"akinsho/toggleterm.nvim",
		tag = "*",
		config = function()
			require("toggleterm").setup({
				open_mapping = [[<c-/>]],
			})
		end,
	})
end)
