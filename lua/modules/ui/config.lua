local config = {}
packer_plugins = packer_plugins or {} -- supress warning

function config.lualine()
  if not packer_plugins["nvim-web-devicons"].loaded then
    packer_plugins["nvim-web-devicons"].loaded = true
    vim.cmd([[packadd nvim-web-devicons]])
  end

  require("lualine").setup({

  })
end

function config.nvim_gps()
	require("nvim-gps").setup({

  })
end

function config.nvim_bufferline()
  if not packer_plugins["nvim-web-devicons"].loaded then
    packer_plugins["nvim-web-devicons"].loaded = true
    vim.cmd([[packadd nvim-web-devicons]])
  end

  require("bufferline").setup({
    options = {
      view = "multiwindow",
      numbers = "none",
      close_command = "bdelete! %d",
      right_mouse_command = "bdelete! %d",
      left_mouse_command = "buffer %d",
      max_name_length = 14,
      max_prefix_length = 10,
      tab_size = 16,
      diagnostics = "nvim_lsp",
      buffer_close_icon = "",
      show_buffer_icons = true,
      show_buffer_close_icons = true,
      show_tab_indicators = true,
      diagnostics_update_in_insert = false,
      diagnostics_indicator = function(count, level)
        return "" .. (icon or "") .. count
      end,
      separator_style = "thin",
      enforce_regular_tabs = false,
      always_show_bufferline = false,
      sort_by = "directory",
          offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left"
      }
    }
    },
  })
  vim.api.nvim_set_keymap('n', '[b', ':BufferLineCycleNext<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', ']b', ':BufferLineCyclePrev<CR>', { noremap = true, silent = true })
end


function config.neo_tree()
  require("neo-tree").setup({
    enable_git_status = true,
    enable_diagnostics = true,
    use_libuv_file_watcher = true,
    follow_current_file = true,
  })
 vim.cmd([[nnoremap <leader>ff :Neotree reveal<cr>]])
end

function config.tokyonight()
  local opt = { "storm", "night" }
  local v = math.random(1, #opt)
  vim.g.tokyonight_style = opt[v]
  vim.g.tokyonight_italic_functions = true
  vim.g.tokyonight_sidebars = { 
    "qf", 
    "vista_kind", 
    "terminal", 
    "packer" 
  }

  vim.g.tokyonight_colors = { 
    hint = "orange", 
    error = "#ae1960" 
  }
end

function config.nightfox()
  require('nightfox').setup({
  })
end

function config.scrollview()
  if vim.wo.diff then
    return
  end
  local w = vim.api.nvim_call_function("winwidth", { 0 })
  if w < 70 then
    return
  end

  vim.g.scrollview_column = 1
end

function config.indent_blankline()
	vim.opt.termguicolors = true
	vim.opt.list = true
	require("indent_blankline").setup({
		char = "│",
		show_first_indent_level = true,
		filetype_exclude = {
			"startify",
			"dashboard",
			"dotooagenda",
			"log",
			"fugitive",
			"gitcommit",
			"packer",
			"vimwiki",
			"markdown",
			"txt",
			"vista",
			"help",
			"todoist",
			"Neotree",
			"peekaboo",
			"git",
			"TelescopePrompt",
			"undotree",
			"", -- for all buffers without a file type
		},
		buftype_exclude = { "terminal", "nofile" },
		show_trailing_blankline_indent = false,
		show_current_context = true,
		context_patterns = {
			"class",
			"function",
			"method",
			"block",
			"list_literal",
			"selector",
			"^if",
			"^table",
			"if_statement",
			"while",
			"for",
			"type",
			"var",
			"import",
		},
		space_char_blankline = " ",
	})
	-- because lazy load indent-blankline so need readd this autocmd
	vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")
end

return config

