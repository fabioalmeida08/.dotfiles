require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "clangd", "pyright", "ts_ls", "terraformls", "elixirls"}
vim.lsp.enable(servers)


-- read :h vim.lsp.config for changing options of lsp servers 
