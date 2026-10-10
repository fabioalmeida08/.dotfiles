local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },

    -- Elixir (roda `mix format`, exige mix.exs no projeto)
    elixir = { "mix" },
    eelixir = { "mix" },
    heex = { "mix" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

return options
