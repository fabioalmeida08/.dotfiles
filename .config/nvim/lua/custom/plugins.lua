local plugins = {
  {
    "nvim-neotest/nvim-nio",
  },
  {
    "nvim-tree/nvim-web-devicons"
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "pyright",
        "black",
        "debugpy",
        -- "eslint-lsp",
        "mypy",
        "python-lsp-server",
        -- "prettierd",
        -- "tailwindcss-language-server",
        -- "typescript-language-server",
        "clang-format",
        "codelldb",
        "clangd",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "BufRead",
  },
  {
    "rust-lang/rust.vim",
    ft= "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end
  },  
  {
    "mfussenegger/nvim-dap",
    config = function()
      require("custom.configs.dap").setup()
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dapui").setup()
    end,
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
      -- require("core.utils").load_mappings("dap_python")
    end,
  },
  {
    "ggandor/leap.nvim",
    event = "BufEnter",
    config = function()
      require("leap").add_default_mappings()
    end,
  },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
    end
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
    end
  },
  {"MunifTanjim/nui.nvim"},
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        timeout = 2000,
        fps = 60,
      })
      vim.notify = require("notify")
    end,
  },
  {
  "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          hover = {
              enabled = false,
          },
          signature = {
              enabled = false,
          },
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        }
      })
    end
  },
  { 
    'echasnovski/mini.nvim', 
    version = false ,
    lazy = false ,
    config = function()
      require('mini.indentscope').setup() 
      require('mini.animate').setup()
    end
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    dependencies = {
       "nvim-lua/plenary.nvim",
    },
    config = function()
      require("lazy").setup()
    end
  },
  {
    "nvimtools/none-ls.nvim",
    -- event = "VeryLazy",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    ft = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local opts = require "plugins.configs.treesitter"
      opts.ensure_installed = {
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "rust",
        "c",
      }
      return opts
    end,
  },
  {
    "booperlv/nvim-gomove",
    lazy = false,
    config = function()
      require("gomove").setup({
        -- whether or not to map default key bindings, (true/false)
        map_defaults = true,
        -- whether or not to reindent lines moved vertically (true/false)
        reindent = true,
        -- whether or not to undojoin same direction moves (true/false)
        undojoin = true,
        -- whether to not to move past end column when moving blocks horizontally, (true/false)
        move_past_end_col = false,
      })
    end,
  },
  {
    'stevearc/conform.nvim',
    event = {"BufReadPre", "BufNewFile"},
    opts = {},
    config = function ()
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = {"black" },
          -- Use a sub-list to run only the first available formatter
          javascript = { { "prettierd", "prettier" } },
          -- c = {"clang-format"}
          c = { "clang_format_custom"},

        },
        formatters = {
          clang_format_custom = {
            command = "clang-format",
            args = { "--style=file", "--assume-filename", vim.fn.expand("$HOME") .. "/.config/nvim/.clang-format" },
            stdin = true,
          },
        },
        format_on_save = false
        -- {
        --   -- These options will be passed to conform.format()
        --   timeout_ms = 500,
        --   lsp_format = "fallback",
        -- },
      })
    end
  },
  {
    "okuuva/auto-save.nvim",
    version = '^1.0.0', -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      -- your config goes here
      -- or just leave it empty :)
      enabled = true, -- Ativa o autosave por padrão
      execution_message = nil --{
      --     message = function()
      --         return "" -- Retorna string vazia para desativar a mensagem
      --     end,
      --     dim = 0.18, -- (opcional) intensidade do escurecimento da mensagem
      --     cleaning_interval = 1250, -- (opcional) tempo em ms para limpar a mensagem
      -- },      
    },
  },
  {
    "danymat/neogen",
    config = function()
      require('neogen').setup {}
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Neogen",
  },
 {
	"Diogo-ss/42-header.nvim",
    cmd = { "Stdheader" },
    config = function()
      require("42header").setup({
        default_map = true,
        auto_update = true,
        user = "fabialme",
        mail = "fabialme@student.42sp.org.br",
      })
    end,
  },
  { -- This plugin
  "Zeioth/compiler.nvim",
  cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"},
  dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
  opts = {},
  },
  { -- The task runner we use
    "stevearc/overseer.nvim",
    commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1
      },
    },
  },
}
return plugins