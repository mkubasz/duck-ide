local lang = {}
local conf = require("modules.lang.config")

lang["nathom/filetype.nvim"] = {
  setup = function()
    vim.g.did_load_filetypes = 1
  end,
}

lang["nvim-treesitter/nvim-treesitter"] = { 
  opt = true, 
  config = conf.nvim_treesitter 
}

lang["nvim-treesitter/nvim-treesitter-textobjects"] = {
  opt = true,	
  after = "nvim-treesitter",
}

lang["RRethy/nvim-treesitter-textsubjects"] = {
  opt = true,
}

lang["nvim-treesitter/nvim-treesitter-refactor"] = {
  after = "nvim-treesitter-textobjects", 
  config = conf.treesitter_ref, 
  opt = true,
}

lang["ThePrimeagen/refactoring.nvim"] = {
  opt = true,
  config = conf.refactor,
}

lang["stevearc/aerial.nvim"] = {
  opt = true,
  cmd = { "AerialToggle" },
  config = conf.aerial,
}

lang["jose-elias-alvarez/null-ls.nvim"] = {
  opt = true, 
  config = require("modules.lang.null-ls").config 
}

lang["ray-x/navigator.lua"] = {
  requires = { "ray-x/guihua.lua", run = "cd lua/fzy && make" },
  opt = true,
  config = conf.navigator
}

return lang
