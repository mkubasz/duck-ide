local loader = require("packer").loader

local fsize = vim.fn.getfsize(vim.fn.expand("%:p:f"))
if fsize == nil or fsize < 0 then
  fsize = 1
end

local load_ts_plugins = true
local load_lsp = true

if fsize > 1024 * 1024 then
  load_ts_plugins = false
  load_lsp = false
end

local function loadscheme()
  --require("packer").loader("tokyonight.nvim")
  require("packer").loader("nightfox.nvim")
end

loadscheme()

_G.PLoader = loader

if vim.wo.diff then
  if load_ts_plugins then
    vim.cmd([[packadd nvim-treesitter]])
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
        use_languagetree = false
      }
    })
  end
  vim.cmd([[syntax on]])
  return
else
  loader("nvim-treesitter")
end

function Lazyload()
  local disable_ft = {
    "TelescopePrompt",
    "packer",
    "csv",
    "txt",
  }

  local syn_on = not vim.tbl_contains(disable_ft, vim.bo.filetype)
  if not syn_on then
    vim.cmd([[syntax manual]])
  end

  if fsize > 6 * 1024 * 1024 then
    vim.cmd([[syntax off]])
    return
  end

  local plugins = "plenary.nvim"
  loader("plenary.nvim")

  vim.g.vimsyn_embed = "lPr"

  local gitrepo = vim.fn.isdirectory(".git/index")
  if gitrepo then
  end

  if load_lsp then
    loader("nvim-lspconfig")
    loader("lsp_signature.nvim")
  end

  loader("guihua.lua")
  if load_lsp or load_ts_plugins then
    loader("navigator.lua")
  end

  if load_ts_plugins then
    plugins = "nvim-treesitter-textobjects"
    loader(plugins)
    loader("refactoring.nvim")
  end

  if load_lsp and use_nulls() then
     loader("null-ls.nvim")
  end
end

local lazy_timer = 30
if _G.packer_plugins == nil or _G.packer_plugins["packer.nvim"] == nil then
  vim.cmd([[PackerCompile]])
  vim.defer_fn(function()
    print("Packer recompiled, please run `:PackerCompile` and restart nvim")
  end, 400)
  return
end

vim.defer_fn(function()
  vim.cmd([[doautocmd User LoadLazyPlugin]])
end, lazy_timer)

vim.cmd([[autocmd User LoadLazyPlugin lua Lazyload()]])

vim.defer_fn(function()
  loader("lualine.nvim")
end, lazy_timer + 60)

vim.defer_fn(function()
  loader("neo-tree.nvim")
  loader("telescope.nvim")
  loader("formatter.nvim")
  loader("harpoon")
end, lazy_timer + 80)
