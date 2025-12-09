return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
{
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
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
      },
      
      PATH = "prepend",
    }
  end,
  config = function(_, opts)
    require("mason").setup(opts)
    
    -- Auto-instalar pacotes ao iniciar
    vim.api.nvim_create_user_command("MasonInstallAll", function()
      if opts.ensure_installed and #opts.ensure_installed > 0 then
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end
    end, {})
    
    -- Executar na inicialização
    vim.g.mason_binaries_list = opts.ensure_installed
  end,
},

{
  "neovim/nvim-lspconfig",
  config = function()
    require("nvchad.configs.lspconfig").defaults()
    require("configs.lspconfig")  -- Carrega sua config personalizada
  end,
},
}
