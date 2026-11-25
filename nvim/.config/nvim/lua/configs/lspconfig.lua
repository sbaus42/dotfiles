-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- Configure solargraph (Ruby LSP)
lspconfig.solargraph.setup({
  -- This is done you don't need to bother with different versions on ruby
  -- in projects. What happens is that projects forced rbenv into a different
  -- ruby version which didn't have solargraph. This broke the lookup
  cmd = { os.getenv("HOME") .. "/.rbenv/versions/3.3.8/bin/solargraph", "stdio" },
  settings = {
    solargraph = {
      diagnostics = true,  -- Enable diagnostics (linting)
      completion = true,   -- Enable autocompletion
      formatting = true,   -- Enable formatting
    }
  }
})
