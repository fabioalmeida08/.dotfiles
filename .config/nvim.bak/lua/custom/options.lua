local opt = vim.opt

opt.list = true
opt.listchars = {
  tab = "▸ ",
  trail = "·",
}

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "c", "cpp", "h" },
--   callback = function()
--     vim.opt_local.expandtab = false
--     vim.opt_local.tabstop = 2
--     vim.opt_local.shiftwidth = 2
--     vim.opt_local.softtabstop = 2
--   end,
-- })

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "h" },
  callback = function()
    vim.opt_local.expandtab = false  -- Usar TABS REAIS (obrigatório na 42)
    vim.opt_local.tabstop = 4        -- Tab visual = 4 espaços
    vim.opt_local.shiftwidth = 4     -- Indentação = 4 espaços
    vim.opt_local.softtabstop = 4    -- Backspace = 4 espaços
  end,
})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = { "*.c", "*.h", "*.cpp" },
--   callback = function()
--     local last_line_num = vim.fn.line('$')
--     local last_line = vim.fn.getline(last_line_num)
--     if last_line == '' then
--       vim.api.nvim_buf_set_lines(0, last_line_num - 1, last_line_num, false, {})
--     end
--   end,
-- })

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.h", "*.cpp" },
  callback = function()
    local last = vim.fn.line('$')
    while last > 1 and vim.fn.getline(last):match("^%s*$") do
      last = last - 1
    end
    -- Apaga todas as linhas a partir de 'last + 1' até o fim do buffer
    vim.api.nvim_buf_set_lines(0, last, -1, false, {})
  end,
})