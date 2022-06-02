local vim = vim
local lspconfig = require "lspconfig"
local lsp = require("vim.lsp")
local set = vim.keymap.set
local buf = vim.lsp.buf

M = {}
local map = vim.api.nvim_buf_set_keymap

local on_attach = function(_, bufnr)
  local opts = {  buffer = bufnr }

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  set('n', 'gD', buf.declaration, opts)
  set('n', 'gd', buf.definition, opts)
  set('n', 'K', buf.hover, opts)
  set('n', 'gi', buf.implementation, opts)
  set('n', '<C-k>', buf.signature_help, opts)
  set('n', '<leader>wa', buf.add_workspace_folder, opts)
  set('n', '<leader>wr', buf.remove_workspace_folder, opts)
  set('n', '<leader>wl', function()
    vim.inspect(buf.list_workspace_folders())
  end, opts)
  set('n', '<leader>D', buf.type_definition, opts)
  set('n', '<leader>rn', buf.rename, opts)
  set('n', 'gr', buf.references, opts)
  set('n', '<leader>ca', buf.code_action, opts)
  set('n', '<leader>so', require('telescope.builtin').lsp_document_symbols, opts)

  set('n', '[d', vim.lsp.diagnostic.goto_prev, opts)
  set('n', ']d', vim.lsp.diagnostic.goto_next, opts)
  set('n', '<leader>e', vim.lsp.diagnostic.show_line_diagnostics, opts)
  set('n', '<leader>q', vim.lsp.diagnostic.set_loclist, opts)

  vim.api.nvim_create_user_command("Format", buf.formatting, {})
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
