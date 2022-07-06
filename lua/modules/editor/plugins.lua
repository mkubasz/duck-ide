local editor = {}
local conf = require("modules.editor.config")


editor["mhartington/formatter.nvim"] = {
  config = conf.formatter,
  opt = true
}

editor["numToStr/Comment.nvim"] = {
  keys = { "g", "<ESC>" },
  event = { "CursorMoved" },
  config = conf.comment,
}

editor["kevinhwang91/nvim-ufo"] = {
  opt = true,
  ft = { "c" },
  requires = { "kevinhwang91/promise-async" },
  config = conf.ufo,
}

return editor
