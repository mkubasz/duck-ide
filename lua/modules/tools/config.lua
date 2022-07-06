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

function config.gitsigns()
  if not packer_plugins["plenary.nvim"].loaded then
    require("packer").loader("plenary.nvim")
  end
  require("gitsigns").setup({
    signs = {
      add = { hl = "GitGutterAdd", text = "│", numhl = "GitSignsAddNr" },
      change = { hl = "GitGutterChange", text = "│", numhl = "GitSignsChangeNr" },
      delete = { hl = "GitGutterDelete", text = "ﬠ", numhl = "GitSignsDeleteNr" },
      topdelete = { hl = "GitGutterDelete", text = "ﬢ", numhl = "GitSignsDeleteNr" },
      changedelete = { hl = "GitGutterChangeDelete", text = "┊", numhl = "GitSignsChangeNr" },
    },
    numhl = false,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      -- Actions
      map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
      map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
      -- map("n", "<leader>hS", gs.stage_buffer) -- hydra
      -- map("n", "<leader>hu", gs.undo_stage_hunk)
      -- map("n", "<leader>hR", gs.reset_buffer)
      -- map("n", "<leader>hp", gs.preview_hunk)
      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end)
      map("n", "<leader>tb", gs.toggle_current_line_blame)
      map("n", "<leader>hd", gs.diffthis)
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end)
      -- map("n", "<leader>td", gs.toggle_deleted)

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,

    watch_gitdir = { interval = 1000, follow_files = true },
    sign_priority = 6,
    status_formatter = nil, -- Use default
    debug_mode = false,
    current_line_blame = true,
    current_line_blame_opts = { delay = 1500 },
    update_debounce = 300,
    word_diff = true,
    diff_opts = { internal = true },
  })
  vim.api.nvim_create_user_command("Stage", "'<,'>Gitsigns stage_hunk", { range = true })
end
function config.vgit()
  -- use this as a diff tool (faster than Diffview)
  -- there are overlaps with gitgutter. following are nice features
  require("vgit").setup({
    keymaps = {
      -- ["n <leader>ga"] = "actions", -- show all commands in telescope
      -- ["n <leader>ba"] = "buffer_gutter_blame_preview", -- show all blames
      -- ["n <leader>bp"] = "buffer_blame_preview", -- buffer diff
      -- ["n <leader>bh"] = "buffer_history_preview", -- buffer commit history DiffviewFileHistory
      -- ["n <leader>gp"] = "buffer_staged_diff_preview", -- diff for staged changes
      -- ["n <leader>pd"] = "project_diff_preview", -- diffview is slow
    },
    settings = {
      live_gutter = {
        enabled = false,
        edge_navigation = false, -- This allows users to navigate within a hunk
      },
      scene = {
        diff_preference = "unified",
      },
      diff_preview = {
        keymaps = {
          buffer_stage = "S",
          buffer_unstage = "U",
          buffer_hunk_stage = "s",
          buffer_hunk_unstage = "u",
          toggle_view = "t",
        },
      },
    },
  })
  require("packer").loader("telescope.nvim")
  -- require("vgit")._buf_attach()
end

function config.neogit()
  local loader = require("packer").loader
  loader("diffview.nvim")
  require("neogit").setup({
    signs = {
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    integrations = {
      diffview = true,
    },
  })
end

return config
