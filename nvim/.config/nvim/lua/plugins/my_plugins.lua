return {
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "BufRead",
  },
  -- {
  --   "ggandor/leap.nvim",
  --   event = "BufEnter",
  --   config = function()
  --     require("leap").add_default_mappings()
  --   end,
  -- },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  -- {
  --   "sphamba/smear-cursor.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  -- {
  --   "karb94/neoscroll.nvim",
  --   event = "VeryLazy",
  --   opts = {},
  -- },
  {
    "folke/todo-comments.nvim",
    lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      -- require("todo-comments").setup()
      require("todo-comments").setup {
        keywords = {
          FIX = { icon = " ", color = "error" },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning" },
          PERF = { icon = " ", color = "perf" },
          NOTE = { icon = "󱞁 ", color = "hint", alt = {} },
          INFO = { icon = " ", color = "info2", alt = {} },
          REFACTOR = { icon = "", color = "warning"},
          TEST = { icon = "󰙨", color = "test" },
        },
        colors = {
          error = { "#EF4444" }, -- vermelho
          warning = { "#F59E0B" }, -- laranja
          info = { "#3B82F6" }, -- azul
          info2 = { "#0EA5E9" }, -- azul mais claro
          hint = { "#22C55E" }, -- verde
          perf = { "#A855F7" }, -- roxo
          test = { "#14B8A6" }, -- ciano
          default = { "#6B7280" }, -- cinza
        },
      }
    end,
  },
  {
    "folke/trouble.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
    end,
  },
  { "MunifTanjim/nui.nvim" },
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup {
        timeout = 2000,
        fps = 60,
      }
      vim.notify = require "notify"
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
      require("noice").setup {
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
        },
      }
    end,
  },
  {
    "echasnovski/mini.nvim",
    version = false,
    lazy = false,
    config = function()
      require("mini.indentscope").setup()
      require("mini.animate").setup()
    end,
  },
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- config = function()
    --   require("lazy").setup()
    -- end
  },
  {
    "booperlv/nvim-gomove",
    lazy = false,
    config = function()
      require("gomove").setup {
        -- whether or not to map default key bindings, (true/false)
        map_defaults = true,
        -- whether or not to reindent lines moved vertically (true/false)
        reindent = true,
        -- whether or not to undojoin same direction moves (true/false)
        undojoin = true,
        -- whether to not to move past end column when moving blocks horizontally, (true/false)
        move_past_end_col = false,
      }
    end,
  },
  {
    "okuuva/auto-save.nvim",
    version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave" }, -- optional for lazy loading on trigger events
    opts = {
      -- your config goes here
      -- or just leave it empty :)
      enabled = true, -- Ativa o autosave por padrão
      execution_message = nil, --{
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
      require("neogen").setup {}
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    cmd = "Neogen",
  },
  {
    "Diogo-ss/42-header.nvim",
    cmd = { "Stdheader" },
    config = function()
      require("42header").setup {
        default_map = true,
        auto_update = true,
        user = "fabialme",
        mail = "fabialme@student.42sp.org.br",
      }
    end,
  },
  {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    lazy = false,
    dependencies = {
      {
        -- `snacks.nvim` integration is recommended, but optional
        ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {}, -- Enhances `ask()`
          picker = { -- Enhances `select()`
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Your configuration, if any; goto definition on the type or field for details
      }

      vim.o.autoread = true -- Required for `opts.events.reload`

      -- Recommended/example keymaps
      vim.keymap.set({ "n", "x" }, "<C-a>", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Ask opencode…" })
      vim.keymap.set({ "n", "x" }, "<C-x>", function()
        require("opencode").select()
      end, { desc = "Execute opencode action…" })
      vim.keymap.set({ "n", "t" }, "<C-.>", function()
        require("opencode").toggle()
      end, { desc = "Toggle opencode" })

      vim.keymap.set({ "n", "x" }, "go", function()
        return require("opencode").operator "@this "
      end, { desc = "Add range to opencode", expr = true })
      vim.keymap.set("n", "goo", function()
        return require("opencode").operator "@this " .. "_"
      end, { desc = "Add line to opencode", expr = true })

      vim.keymap.set("n", "<S-C-u>", function()
        require("opencode").command "session.half.page.up"
      end, { desc = "Scroll opencode up" })
      vim.keymap.set("n", "<S-C-d>", function()
        require("opencode").command "session.half.page.down"
      end, { desc = "Scroll opencode down" })

      -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
      vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
      vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
    end,
  },
}
--   {
--     "williamboman/mason.nvim",
--     opts = {
--       ensure_installed = {
--         -- "rust-analyzer",
--         -- "pyright",
--         -- "black",
--         -- "debugpy",
--         -- "eslint-lsp",
--         -- "mypy",
--         -- "python-lsp-server",
--         -- "prettierd",
--         -- "tailwindcss-language-server",
--         -- "typescript-language-server",
--         "clang-format",
--         "codelldb",
--         "clangd",
--       },
--     },
--   },
--   {
--   "williamboman/mason.nvim",
--   opts = {
--     ensure_installed = {
--       "clang-format",
--       "codelldb",
--       "clangd",
--     },
--     automatic_installation = true,
--     PATH = "prepend",
--   },
-- },
--   {
--     'stevearc/conform.nvim',
--     event = {"BufReadPre", "BufNewFile"},
--     opts = {},
--     config = function ()
--       require("conform").setup({
--         formatters_by_ft = {
--           lua = { "stylua" },
--           -- Conform will run multiple formatters sequentially
--           python = {"black" },
--           -- Use a sub-list to run only the first available formatter
--           javascript = { { "prettierd", "prettier" } },
--           -- c = {"clang-format"}
--           c = { "clang_format_custom"},

--         },
--         formatters = {
--           clang_format_custom = {
--             command = "clang-format",
--             args = { "--style=file", "--assume-filename", vim.fn.expand("$HOME") .. "/.config/nvim/.clang-format" },
--             stdin = true,
--           },
--         },
--         format_on_save = false
--         -- {
--         --   -- These options will be passed to conform.format()
--         --   timeout_ms = 500,
--         --   lsp_format = "fallback",
--         -- },
--       })
--     end
--   },
--   {
--     "nvimtools/none-ls.nvim",
--     -- event = "VeryLazy",
--     opts = function()
--       return require "custom.configs.null-ls"
--     end,
--   },
--   {
--     "windwp/nvim-ts-autotag",
--     ft = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
--     config = function()
--       require("nvim-ts-autotag").setup()
--     end,
--   },
-- {
--   "rust-lang/rust.vim",
--   ft= "rust",
--   init = function ()
--     vim.g.rustfmt_autosave = 1
--   end
-- },
-- {
--   "mfussenegger/nvim-dap",
--   config = function()
--     require("custom.configs.dap").setup()
--   end,
-- },
-- {
--   "rcarriga/nvim-dap-ui",
--   dependencies = { "mfussenegger/nvim-dap" },
--   config = function()
--     require("dapui").setup()
--   end,
-- },
-- {
--   "mfussenegger/nvim-dap-python",
--   ft = "python",
--   dependencies = {
--     "mfussenegger/nvim-dap",
--     "rcarriga/nvim-dap-ui",
--     "nvim-neotest/nvim-nio",
--   },
--   config = function(_, opts)
--     local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
--     require("dap-python").setup(path)
--     -- require("core.utils").load_mappings("dap_python")
--   end,
-- },
