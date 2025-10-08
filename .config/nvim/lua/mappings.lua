require "nvchad.mappings"

-- add yours here
-- ~/.config/nvim/lua/configs/mappings.lua

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Geral
map("n", "<C-q>", "<cmd>qall<CR>", { desc = "Quit nvim" })
map("n", "<A-j>", "<cmd>m +1<CR>", { desc = "Move cursor one line down" })
map("n", "<A-k>", "<cmd>m -2<CR>", { desc = "Move cursor one line up" })
map("n", "<leader>\\", "<cmd>vsplit<CR>", { desc = "Split vertical" })
map("n", "<leader>q", "<cmd>close<CR>", { desc = "Close window" })

-- Telescope & Trouble
map("n", "<leader>ft", "<cmd>TodoTelescope<CR>", { desc = "Search for todo" })
map("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<CR>", { desc = "Trouble toggle" })
map("n", "<leader>td", "<cmd>Trouble todo toggle<CR>", { desc = "Trouble TODO toggle" })

-- LazyGit
map("n", "<leader>gl", "<cmd>LazyGit<CR>", { desc = "Lazy git" })

-- Resize
map("n", "<leader>rh", "<cmd>vertical resize -10<CR>", { desc = "Vertical resize -" })
map("n", "<leader>rl", "<cmd>vertical resize +10<CR>", { desc = "Vertical resize +" })
map("n", "<leader>rj", "<cmd>horizontal resize -10<CR>", { desc = "Horizontal resize -" })
map("n", "<leader>rk", "<cmd>horizontal resize +10<CR>", { desc = "Horizontal resize +" })

-- Noice
map("n", "<leader>dd", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss notifications" })

-- Visual Multi
map("n", "<C-d>", "<Plug>(VM-Find-Under)", { desc = "Selecionar próxima ocorrência" })
map("n", "<leader>sa", "<Plug>(VM-Select-All)", { desc = "Select all occurrences" })

-- Auto Save
map("n", "<leader>ta", "<cmd>ASToggle<CR>", { desc = "Toggle Auto Save" })

-- LSP
map("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Goto Definition" })
map("n", "<leader>lh", vim.lsp.buf.hover, { desc = "Hover" })
map("n", "<leader>qf", function()
  vim.lsp.buf.code_action({ apply = true })
end, { desc = "Apply Auto-Fix" })
map("n", "<leader>qp", function()
  vim.lsp.buf.code_action({ 
    filter = function(a) return a.isPreferred end, 
    apply = true 
  })
end, { desc = "Apply Preferred Fix" })

-- NvimTree
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

-- Neogen, Conform, Header
map("n", "<leader>md", function()
  require('neogen').generate()
end, { desc = "Gerar docs (Neogen)" })

map("n", "<leader>mf", function()
  require('conform').format({ async = true, lsp_fallback = true })
end, { desc = "Formatar código" })

map("n", "<leader>mh", "<cmd>Stdheader<CR>", { desc = "Header 42" })

map("n", "<leader>rs", function()
  local old_name = vim.fn.expand("%:p")
  local new_name = vim.fn.input("Salvar como: ", old_name ~= "" and old_name or "", "file")

  if new_name == "" then
    print("Cancelado.")
    return
  end

  -- Salva o buffer atual como novo arquivo
  vim.cmd("saveas " .. vim.fn.fnameescape(new_name))

  -- Fecha o buffer antigo (só se ele era [No Name])
  if old_name == "" then
    vim.cmd("bdelete #")  -- fecha o buffer anterior
  end

  print("Buffer salvo como: " .. new_name)
end, { desc = "Salvar e fechar buffer [No Name]" })

-- Buffer operations
-- map("n", "<leader>rs", function()
--   local current_name = vim.fn.expand("%")
--   local new_name = vim.fn.input("Save as: ", current_name, "file")
  
--   if new_name ~= "" and new_name ~= current_name then
--     vim.cmd("saveas " .. new_name)
--     vim.notify("Buffer saved as: " .. new_name, vim.log.levels.INFO)
--   elseif new_name == current_name then
--     vim.cmd("write")
--     vim.notify("Buffer saved!", vim.log.levels.INFO)
--   end
-- end, { desc = "Save and rename buffer" })

-- -- Compiler
-- map("n", "<leader>mcc", "<cmd>CompilerOpen<CR>", { desc = "Abrir compilador" })
-- map("n", "<leader>mct", "<cmd>CompilerToggleResults<CR>", { desc = "Toggle compilador" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
