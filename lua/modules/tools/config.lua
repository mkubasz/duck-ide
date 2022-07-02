local global = require("core.global")
local config = {}

function config.telescope_preload()
  if not packer_plugins["plenary.nvim"].loaded then
    require("packer").loader("plenary.nvim")
  end
end

function config.telescope()
  require("modules.tools.telescope").setup()
end

function config.floaterm()
  require("toggleterm").setup({
    open_mapping = [[<c-\>]],
     })
  local Terminal = require("toggleterm.terminal").Terminal
  local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

  function _lazygit_toggle()
    lazygit:toggle()
  end
  vim.cmd("command! LG lua _lazygit_toggle()")

  local fzf = Terminal:new({ cmd = "fzf", hidden = true })

  function _fzf_toggle()
    fzf:toggle()
  end
  vim.cmd("command! FZF lua _fzf_toggle()")
end

return config
