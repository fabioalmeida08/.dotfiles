return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- Branch `main` do nvim-treesitter NÃO suporta `ensure_installed` (só `install_dir`),
  -- então os parsers de Elixir são instalados via build.
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate | TSInstall elixir eex heex surface",
  },
  {
    -- Sem `cmd`: o setup roda no startup, senão o ensure_installed abaixo
    -- só é processado quando você abre :Mason.
    "williamboman/mason.nvim",
    opts = function()
      return {
        ensure_installed = {
          "clangd",
          -- "clang-format",
          -- "codelldb",
          -- 🐍 Python
          "pyright",           -- LSP principal para Python
          "ruff",              -- Linter rápido + formatter
          "debugpy",           -- Debugger para Python
          "black",             -- Formatter padrão da indústria
          "isort",             -- Organizador de imports
          "mypy",              -- Type checker opcional
          "typescript-language-server",
          "eslint_d",
          "prettierd",
          "elixir-ls",
          "terraform-ls",
          -- "tofu-ls",
          -- "tflint"
        },

        PATH = "prepend",
      }
    end,
    config = function(_, opts)
      require("mason").setup(opts)

      -- Instala/atualiza manualmente tudo da lista: :MasonInstallAll
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        if opts.ensure_installed and #opts.ensure_installed > 0 then
          vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
        end
      end, {})
    end,
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig" -- Carrega sua config personalizada
    end,
  },
}
