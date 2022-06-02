local ui = {}
local conf = require("modules.ui.config")

ui["kyazdani42/nvim-web-devicons"] = {}

ui["nvim-lualine/lualine.nvim"] = {
  config = conf.lualine,
  opt = true
}

ui["SmiteshP/nvim-gps"] = {
	opt = true,
	after = "nvim-treesitter",
	config = conf.nvim_gps,
}

ui["lukas-reineke/indent-blankline.nvim"] = {
	opt = true,
	event = "BufRead",
	config = conf.indent_blankline,
}

ui["akinsho/bufferline.nvim"] = {
  config = conf.nvim_bufferline,
  event = "UIEnter",
  diagnostics_update_in_insert = false,
  opt = true,
}

ui["nvim-neo-tree/neo-tree.nvim"] = {
  branch = "v2.x",
  requires = { "MunifTanjim/nui.nvim" },
  config = conf.nvim_tree,
}

ui["folke/tokyonight.nvim"] = {
  opt = true,
  setup = conf.tokyonight,
  config = function()
    vim.cmd([[colorscheme tokyonight]])
    vim.cmd([[hi TSCurrentScope guibg=#282338]])
  end,
}

ui["EdenEast/nightfox.nvim"] = {
  opt = true,
  setup = conf.nightfox,
  config = function()
    vim.cmd([[colorscheme nightfox]])
  end,
}
 
ui["stevearc/dressing.nvim"] = {
  opt = true,
  config = function()
    require('dressing').setup()
  end,
}

return ui
