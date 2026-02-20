local opt = vim.opt

-- Configurações de listchars
opt.list = true
opt.listchars = {
  tab = "▸ ",
  trail = "·",
}

-- Autocmd para C/C++
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Remove linhas vazias no final ao salvar
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.c", "*.h", "*.cpp" },
  callback = function()
    local last = vim.fn.line('$')
    while last > 1 and vim.fn.getline(last):match("^%s*$") do
      last = last - 1
    end
    vim.api.nvim_buf_set_lines(0, last, -1, false, {})
  end,
})