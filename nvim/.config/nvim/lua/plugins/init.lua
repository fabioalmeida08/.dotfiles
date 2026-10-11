return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- Branch `main` do nvim-treesitter: é a única compatível com Neovim 0.12+.
  -- A `master` não suporta 0.12 e quebra o highlight nas injeções.
  -- Exige o CLI `tree-sitter` (instalado via Mason: `tree-sitter-cli`).
  -- `ensure_installed` não auto-instala, mas alimenta o :TSInstallAll do NvChad.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "lua", "luadoc", "printf", "vim", "vimdoc",
        "elixir", "eex", "heex", "surface",
        "python",
      },
    },
    build = ":TSUpdate",
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
          -- 🌳 Exigido pelo nvim-treesitter branch `main` (nvim 0.12+)
          "tree-sitter-cli",
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
