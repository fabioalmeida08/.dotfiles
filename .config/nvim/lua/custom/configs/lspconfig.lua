local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require "lspconfig/util"
lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"rust"},
  root_dir = util.root_pattern("Cargo.toml"),
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
      }
    }
  }

})
lspconfig.pyright.setup({
    on_attach=on_attach,
    capabilities=capabilities,
    filetype={"python"}
  })

local servers = {"ts_ls", "tailwindcss", "eslint"}

-- Configuração do clangd
lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
      -- Função chamada quando o LSP se conecta ao buffer
      print("LSP clangd conectado!")
  end,
  cmd = { "clangd" }, -- Comando para iniciar o clangd
  filetypes = { "c", "cpp", "objc", "objcpp" }, -- Tipos de arquivo suportados
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"), -- Diretório raiz do projeto
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end 
