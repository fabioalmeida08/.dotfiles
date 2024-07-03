local M = {}

-- In order to disable a default keymap, use
M.disabled = {
  n = {
      ["<leader>q"] = "",
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
    ["<leader>d"] = {"<cmd> NoiceDismiss <CR>", "dismiss notifications"},
  },
}
  
M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {"<cmd> DapToggleBreakpoint <CR>"}
  }
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
return M

