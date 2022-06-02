local telescope = require("telescope")
local loader = require("packer").loader

M = {}

M.setup = function()
  loader("telescope-fzf-native.nvim telescope-live-grep-raw.nvim telescope-file-browser.nvim")

  telescope.setup({
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    }
  })

  telescope.load_extension("fzf")
  telescope.load_extension("live_grep_raw")
  telescope.load_extension("file_browser")
end

return M
