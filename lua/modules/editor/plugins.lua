local editor = {}
local conf = require("modules.editor.config")

editor["windwp/nvim-autopairs"] = {
  after = { "nvim-cmp" },
  config = conf.autopairs,
  opt = true,
}

editor["mhartington/formatter.nvim"] = {
  config = conf.formatter,
  opt = true
}

editor["numToStr/Comment.nvim"] = {
  keys = { "g", "<ESC>" },
  event = { "CursorMoved" },
  config = conf.comment,
}

return editor
