local M = {}

-- In order to disable a default keymap, use
M.disabled = {
  n = {
      ["<leader>q"] = "",
      ["<C-n>"] = ""
  }
}
-- Your custom mappings
M.personal = {
  n = {
    ["<C-q>"] = {"<cmd> qall <CR>", "Quit nvim"},
    ["<A-j>"] = {"<cmd> m +1 <CR>", "Move cursor one line down"},
    ["<A-k>"] = {"<cmd> m -2 <CR>", "Move crusor one line up"},
    ["<leader>\\"] = {"<cmd> vsplit <CR>", "Split terminal horizontal"},
    ["<leader>q"] = {"<cmd> close <CR>", "close"},
    ["<leader>ft"] = {"<cmd> TodoTelescope <CR>", "Search for todo"},
    ["<leader>tt"] = {"<cmd> Trouble diagnostics toggle <CR>", "Trouble toggle"},
    ["<leader>td"] = {"<cmd> Trouble todo toggle <CR>", "Trouble TODO toggle"},
    ["<leader>gl"] = {"<cmd> LazyGit <CR>", "Lazy git"},
    ["<leader>rh"] = {"<cmd> vertical resize -10 <CR>", "vertical resize -"},
    ["<leader>rl"] = {"<cmd> vertical resize +10 <CR>", "vertical resize +"},
    ["<leader>rj"] = {"<cmd> horizontal resize -10 <CR>", "horizontal resize -"},
    ["<leader>rk"] = {"<cmd> horizontal resize +10 <CR>", "horizontal resize +"},
    ["<leader>dd"] = {"<cmd> NoiceDismiss <CR>", "dismiss notifications"},
    ["<C-d>"] = { "<Plug>(VM-Find-Under)", "Selecionar próxima ocorrência" },
    ["<leader>sa"] = { "<Plug>(VM-Select-All)", "Selecionar todas as ocorrências" },
    ["<leader>ta"] = { "<cmd>ASToggle<CR>" , "Toggle Auto Save"},
    ["<leader>ld"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
    ["<leader>lh"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
    ["<leader>e"] = { "<cmd>NvimTreeToggle<CR>", "Toggle NvimTree" }
  },
}
  
M.dap = {
  n = {
    ["<F5>"] = { "<cmd>lua require'dap'.continue()<CR>", "Continuar/Executar" },
    ["<F10>"] = { "<cmd>lua require'dap'.step_over()<CR>", "Step Over" },
    ["<F11>"] = { "<cmd>lua require'dap'.step_into()<CR>", "Step Into" },
    ["<F12>"] = { "<cmd>lua require'dap'.step_out()<CR>", "Step Out" },
    ["<leader>db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
    ["<leader>dr"] = { "<cmd>lua require'dap'.repl.toggle()<CR>", "Toggle REPL" },
    ["<leader>du"] = { "<cmd>lua require'dapui'.toggle()<CR>", "Toggle DAP UI" },
  },
}

M.telescope = {
  n = { -- Modo normal
    ["<leader>fr"] = { "<cmd>Telescope live_grep<CR>", "Find Using Rip Grep" },
  },
}

M.dap_python = {
  plugin = true,
  n = {
    ["<leader>dpr"] = {
      function()
        require('dap-python').test_method()
      end
    }
  }
}

M.lspconfig = {
  n = {
      ["ld"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Goto Definition" },
      ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
  },
}
return M

