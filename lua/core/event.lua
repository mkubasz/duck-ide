local vim = vim
local api = vim.api
local cmd_group = api.nvim_create_augroup("LocalAuGroup", {})

local autocmd = {}

api.nvim_create_autocmd({ "BufWritePre" }, {
  group = cmd_group,
  pattern = {
    "/tmp/*",
    "COMMIT_EDITMSG",
    "MERGE_MSG",
    "*.tmp",
    "*.bak",
  },
  callback = function()
    vim.opt_local.undofile = false
  end,
})

api.nvim_create_autocmd("TextYankPost", {
  group = cmd_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 400
    })
  end,
})

function autocmd.nvim_create_augroups(definitions)
  for group_name, defs in pairs(definitions) do
    local gn = api.nvim_create_augroup("LocalAuGroup" .. group_name, {})
    for _, def in ipairs(defs) do
      api.nvim_create_autocmd(vim.split(def[1], ','), {
        group = gn,
        pattern = def[2],
        -- callback = def.callback,
        command = def[3],
      })
    end
  end
end

function autocmd.load_autocmds()
  local definitions = {
    packer = {
      {
        "BufWritePost",
        "*.lua",
        "lua require('core.pack').auto_compile()"
      },
    },
    bufs = {
      {
        "BufWritePost,FileWritePost",
        "*.vim",
        [[ if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif]],
      },
    },

    wins = {
      {
        "BufEnter",
        "Neotree",
        [[setlocal cursorline]]
      },
      {
        "VimResized",
        "*",
        [[tabdo wincmd =]]
      },
      {
        "VimLeave",
        "*",
        [[if has('nvim') | wshada! | else | wviminfo! | endif]]
      },
      {
        "FocusGained",
        "*",
        "checktime"
      },
    },
  }

  autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
return autocmd
