local tools = {}
local conf = require("modules.tools.config")

tools["nvim-telescope/telescope.nvim"] = {
  cmd = "Telescope",
  config = conf.telescope,
  setup = conf.telescope_preload,
  requires = {
    { "nvim-lua/plenary.nvim", opt = true },
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
    { "nvim-telescope/telescope-live-grep-args.nvim", opt = true },
    { "nvim-telescope/telescope-file-browser.nvim", opt = true },
  },
  opt = true,
}


tools["ThePrimeagen/harpoon"] = {
  opt = true,
  config = function()
    require("harpoon").setup({
      global_settings = {
        save_on_toggle = false,
        save_on_change = true,
        enter_on_sendcmd = false,
        tmux_autoclose_windows = false,
        excluded_filetypes = { "harpoon" },
      },
    })
    require("telescope").load_extension("harpoon")
  end,
}

tools["akinsho/toggleterm.nvim"] = {
  cmd = { "ToggleTerm", "TermExec" },
  event = { "CmdwinEnter", "CmdlineEnter" },
  config = conf.floaterm,
}

return tools
