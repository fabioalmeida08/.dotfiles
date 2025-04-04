-- ~/.config/nvim/lua/custom/configs/dap.lua
local M = {}

M.setup = function()
  local dap = require("dap")

  -- Configuração do emoji para breakpoints
  vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint", linehl = "", numhl = "" })

  -- Configuração do adaptador codelldb
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = vim.fn.stdpath("data") .. "/mason/bin/codelldb", -- Caminho do codelldb instalado pelo Mason
      args = { "--port", "${port}" },
    },
  }

  -- Configuração de depuração para C
  dap.configurations.c = {
    {
      name = "Launch",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input("Caminho do executável: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
    },
  }


  dap.configurations.python = {
    {
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}", -- Depura o arquivo atual
      pythonPath = function()
        return vim.fn.exepath("python3") -- Usa o Python do sistema ou virtualenv
      end,
    },
  }

  -- Integração com nvim-dap-ui (opcional)
  local dapui = require("dapui")
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
  -- dapui.setup({
  --   layouts = {
  --     -- Layout 1: Janelas à esquerda
  --     {
  --       elements = {
  --         { id = "scopes", size = 0.50 },      -- 25% da altura
  --         { id = "breakpoints", size = 0.25 }, -- 25% da altura
  --         { id = "stacks", size = 0.15 },      -- 25% da altura
  --         { id = "watches", size = 0.15 },     -- 25% da altura
  --       },
  --       size = 50,          -- Largura fixa de 40 colunas
  --       position = "left",  -- Posição à esquerda (pode ser "right")
  --     },
  --     -- Layout 2: Janelas na parte inferior
  --     -- {
  --     --   elements = {
  --     --     { id = "console", size = 0.5 }, -- 50% da altura
  --     --     { id = "repl", size = 0.5 },    -- 50% da altura
  --     --   },
  --     --   size = 10,          -- Altura fixa de 10 linhas
  --     --   position = "bottom" -- Posição na parte inferior (pode ser "top")
  --     -- },
  --   },
  -- })
end

return M