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

lang["p00f/nvim-ts-rainbow"] = {
  opt = true,
  event = {"CursorHold", "CursorHoldI"},
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

lang["simrat39/symbols-outline.nvim"] = {
  opt = true,
  cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
  config = conf.outline,
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

lang["glepnir/lspsaga.nvim"] = {
  opt = true,
  cmd = {
    "LspSaga",
  },
  config = function()
    local saga = require("lspsaga")

    saga.init_lsp_saga({
      border_style = "rounded",
      code_action_lightbulb = {
        enable = false,
      },
    })
  end,
}

lang["m-demare/hlargs.nvim"] = {
  opt = true,
  after = "nvim-treesitter",
  config = function()
    require("hlargs").setup()
  end,
}

return lang
