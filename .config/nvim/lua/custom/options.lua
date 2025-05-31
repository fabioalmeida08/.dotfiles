local opt = vim.opt

opt.list = true
opt.listchars = {
  tab = "▸ ",
  trail = "·",
}

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.h", "*.cpp" },
  callback = function()
    local last_line_num = vim.fn.line('$')
    local last_line = vim.fn.getline(last_line_num)
    if last_line == '' then
      vim.api.nvim_buf_set_lines(0, last_line_num - 1, last_line_num, false, {})
    end
  end,
})