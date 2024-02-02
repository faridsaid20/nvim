require("conform").setup({
    -- ft_parsers = {
    --         javascript = "babel",
    --         javascriptreact = "babel",
    --         typescript = "typescript",
    --         typescriptreact = "typescript",
    --     --     vue = "vue",
    --     --     css = "css",
    --     --     scss = "scss",
    --     --     less = "less",
    --     --     html = "html",
    --     --     json = "json",
    --     --     jsonc = "json",
    --     --     yaml = "yaml",
    --     --     markdown = "markdown",
    --     --     ["markdown.mdx"] = "mdx",
    --     --     graphql = "graphql",
    --     --     handlebars = "glimmer",
    --   },
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- Use a sub-list to run only the first available formatter
      javascript = {  "prettierd", "eslint_d"  },
      typescript = {  "prettierd", "eslint_d"  },
      typescriptreact = {  "prettierd", "eslint_d"  },
      javascriptreact = {  "prettierd", "eslint_d"  },
      json = {  "prettierd"  },
      html = {  "prettierd"  },
      css = {  "prettierd"  },
      scss = {  "prettierd"  },
      yaml = {  "prettierd"  },
      markdown = {  "prettierd"  },
      cpp = {  "clang_format" },
      bash = {  "beautysh", "shfmt"  },
      sh = {  "beautysh", "shfmt"  },
    },
})