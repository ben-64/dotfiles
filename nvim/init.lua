require("core")
require("config.lazy")

vim.lsp.handlers["textDocument/hover"] = function(_, result, ctx, config)
  config = config or {}
  config.border = "rounded"
  return vim.lsp.handlers.hover(_, result, ctx, config)
end

-- Pour l'aide à la signature (Signature Help)
vim.lsp.handlers["textDocument/signatureHelp"] = function(_, result, ctx, config)
  config = config or {}
  config.border = "rounded"
  return vim.lsp.handlers.signature_help(_, result, ctx, config)
end
