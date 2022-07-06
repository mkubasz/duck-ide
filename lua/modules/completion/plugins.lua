local completion = {}
local conf = require("modules.completion.config")

completion["neovim/nvim-lspconfig"] = {
  config = conf.nvim_lsp,
  opt = true
}

completion["onsails/lspkind.nvim"] = {}

completion["hrsh7th/nvim-cmp"] = {
  after = { "LuaSnip" },
  requires = {
    { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-buffer", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-copilot", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp", opt = true },
    { "hrsh7th/cmp-path", after = "nvim-cmp", opt = true },
    { "ray-x/cmp-treesitter", after = "nvim-cmp", opt = true },
    { "f3fora/cmp-spell", after = "nvim-cmp", opt = true },
    { "octaltree/cmp-look", after = "nvim-cmp", opt = true },
    { "tzachar/cmp-tabnine",
      after = "nvim-cmp",
      config = conf.tabnine,
      run = "./install.sh", opt = true },
    { "saadparwaiz1/cmp_luasnip", after = { "nvim-cmp", "LuaSnip" } },
  },
  config = conf.nvim_cmp,
}

completion["L3MON4D3/LuaSnip"] = {
  event = "InsertEnter",
  requires = {
    "rafamadriz/friendly-snippets",
    event = "InsertEnter"
  },
  config = conf.luasnip,
}
completion["ray-x/lsp_signature.nvim"] = {
  opt = true,
  config = function()
    require("lsp_signature").setup({
      bind = true,
      toggle_key = "<C-x>",
      floating_window = true,
      floating_window_above_cur_line = true,
      hint_enable = true,
      fix_pos = false,
      zindex = 1002,
      timer_interval = 100,
      extra_trigger_chars = {},
      handler_opts = {
        rorder = "rounded",
      },
      max_height = 4,
    })
  end,
}

completion["windwp/nvim-autopairs"] = {
  after = { "nvim-cmp" },
  config = conf.autopairs,
  opt = true,
}

return completion
