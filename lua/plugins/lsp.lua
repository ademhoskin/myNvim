return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "clangd", "gopls", "rust_analyzer", "ts_ls", "nixd", "dockerls" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      -- Configure diagnostics
      vim.diagnostic.config({
        virtual_text = {
          severity = { min = vim.diagnostic.severity.WARN },
          source = "if_many",
          prefix = "●",
        },
        float = {
          source = "if_many",
          border = "rounded",
          header = "",
          prefix = "",
        },
        signs = {
          severity = { min = vim.diagnostic.severity.HINT },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Define diagnostic signs
      local signs = {
        Error = " ",
        Warn = " ",
        Hint = " ",
        Info = " "
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.pyright.setup({})
      lspconfig.clangd.setup({})
      lspconfig.gopls.setup({})
      lspconfig.ts_ls.setup({})
      lspconfig.rust_analyzer.setup({})
      lspconfig.nixd.setup({})
      lspconfig.dockerls.setup({})
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.rubocop,
          null_ls.builtins.diagnostics.rubocop,
          null_ls.builtins.diagnostics.cppcheck.with({
            extra_args = { "--enable=all", "--suppress=missingIncludeSystem" },
          }),
          null_ls.builtins.formatting.nixpkgs_fmt,
          null_ls.builtins.diagnostics.hadolint,
          require("none-ls.diagnostics.ruff"),
          require("none-ls.diagnostics.eslint_d"),
        },
      })
    end,
  },
}