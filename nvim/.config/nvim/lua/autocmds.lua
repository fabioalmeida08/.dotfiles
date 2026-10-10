require "nvchad.autocmds"

-- Indentação inteligente (Treesitter) para TODOS os filetypes,
-- mas só onde é seguro: precisa de parser + query `indents.scm`,
-- e não pode pisar no `indent/<ft>.vim` do runtime.
-- (Sem indents.scm o treesitter retorna 0 e ZERA a indentação da linha.)
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    -- garante o registro de mapeamentos de lang (ex.: eelixir -> eex)
    pcall(require, "nvim-treesitter")

    local lang = vim.treesitter.language.get_lang(args.match) or args.match

    -- 1) precisa existir parser pra esse lang
    if not vim.treesitter.language.add(lang) then
      return
    end

    -- 2) precisa existir a query de indent
    local queries = vim.api.nvim_get_runtime_file("queries/" .. lang .. "/indents.scm", true)
    if #queries == 0 then
      return
    end

    -- 3) não sobrescrever o indentexpr de indent/<ft>.vim (python, lua, json...)
    if vim.bo[args.buf].indentexpr ~= "" then
      return
    end

    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
