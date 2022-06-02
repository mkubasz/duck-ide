local lspconfig = require "lspconfig"
local lsp = require("vim.lsp")

M = {}
local map = vim.api.nvim_buf_set_keymap

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local opts = {  buffer = bufnr }

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
  vim.keymap.set('n', '<leader>wl', function()
    vim.inspect(vim.lsp.buf.list_workspace_folders())
  end, opts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)

  vim.keymap.set('n', '[d', vim.lsp.diagnostic.goto_prev, opts)
  vim.keymap.set('n', ']d', vim.lsp.diagnostic.goto_next, opts)
  vim.keymap.set('n', '<leader>e', vim.lsp.diagnostic.show_line_diagnostics, opts)
  vim.keymap.set('n', '<leader>q', vim.lsp.diagnostic.set_loclist, opts)

  vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})
end

M.setup = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  lspconfig.pyright.setup { 
    capabilities = capabilities,
    on_attach = on_attach,
  }
  lspconfig.tsserver.setup { 
    capabilities = capabilities,
    on_attach = on_attach,
  }
  lspconfig.sumneko_lua.setup {
    capabilities = capabilities,
    on_attach = on_attach
  }
end

return M
