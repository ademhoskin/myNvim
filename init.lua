vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "m4xshen/autoclose.nvim",
      config = function()
        require("autoclose").setup({})
      end,
    },
    {
      "sainnhe/gruvbox-material",
      lazy = false,
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.gruvbox_material_enable_italic = true
        vim.cmd.colorscheme("gruvbox-material")
      end,
    },
    {
      "nvim-telescope/telescope.nvim",
      branch = "0.1.x",
      dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
          ensure_installed = {
            "c",
            "lua",
            "rust",
            "go",
            "bash",
            "sql",
            "ruby",
            "python",
            "css",
            "javascript",
            "html",
            "typescript",
          },
          highlight = { enable = true },
          indent = { enable = true },
        })
      end,
    },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
    },
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
          ensure_installed = { "lua_ls", "pyright", "clangd", "gopls", "rust_analyzer", "tsserver" },
        })
      end,
    },
    {
      "neovim/nvim-lspconfig",
      dependencies = {
        "nvimtools/none-ls-extras.nvim",
      },
      config = function()
        local lspconfig = require("lspconfig")
        lspconfig.lua_ls.setup({})
        lspconfig.pyright.setup({})
        lspconfig.clangd.setup({})
        lspconfig.gopls.setup({})
        lspconfig.tsserver.setup({})
        lspconfig.rust_analyzer.setup({})

        vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
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
            require("none-ls.formatting.ruff"),
            null_ls.builtins.formatting.isort,
            null_ls.builtins.formatting.gofmt,
            null_ls.builtins.formatting.rubocop,
            null_ls.builtins.diagnostics.rubocop,
            require("none-ls.diagnostics.ruff"),
            require("none-ls.diagnostics.eslint_d"),
          },
        })
        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
      end,
    },
    {
      "hrsh7th/cmp-nvim-lsp",
    },
    {
      "L3MON4D3/LuaSnip",
      dependencies = {
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
      },
    },
    {
      "hrsh7th/nvim-cmp",
      config = function()
        local cmp = require("cmp")
        require("luasnip.loaders.from_vscode").lazy_load()
        cmp.setup({
          snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
          }, {
            { name = "buffer" },
          }),
        })
      end,
    },
    { "nvim-neotest/nvim-nio" },
    {
      "mfussenegger/nvim-dap",
      config = function()
        local dap = require("dap")
        --node
        require("dap").adapters["pwa-node"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            -- 💀 Make sure to update this path to point to your installation
            args = { "~/vscode-js-debug-1.92.0/src/dapDebugServer.js", "${port}" },
          },
        }
        require("dap").configurations.javascript = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
        }

        vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, {})
        vim.keymap.set("n", "<Leader>dc", dap.continue, {})
      end,
    },
    {
      "mfussenegger/nvim-dap-python",
      ft = "python",
      dependencies = {
        "mfussenegger/nvim-dap",
      },
      config = function()
        local path = "~/my-venv/bin/python" -- must have debugpy installed in this venv
        require("dap-python").setup(path)
      end,
    },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = "mfussenegger/nvim-dap",
      config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close()
        end
      end,
    },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "gruvbox" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

-- Keybindings for Telescope and Neo-tree
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>")
