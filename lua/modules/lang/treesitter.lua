local enable = true
local langtree = true

local treesitter = function()
  require("nvim-treesitter.configs").setup({
    highlight = {
      enable = true,
    },
        textobjects = {
      lsp_interop = {
        enable = enable,
        peek_definition_code = { ["DF"] = "@function.outer", ["CF"] = "@class.outer" },
      },
      move = {
        enable = enable,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = { ["]m"] = "@function.outer", ["]]"] = "@class.outer" },
        goto_next_end = { ["]M"] = "@function.outer", ["]["] = "@class.outer" },
        goto_previous_start = { ["[m"] = "@function.outer", ["[["] = "@class.outer" },
        goto_previous_end = { ["[M"] = "@function.outer", ["[]"] = "@class.outer" },
      },
      select = {
        enable = enable,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      swap = {
        enable = enable,
        swap_next = { ["<leader>a"] = "@parameter.inner" },
        swap_previous = { ["<leader>A"] = "@parameter.inner" },
      },
    },
  })
end

local treesitter_ref = function()
  require("nvim-treesitter.configs").setup({
    refactor = {
      highlight_definitions = { enable = enable },
      highlight_current_scope = { enable = enable },
      smart_rename = {
        enable = false,
        keymaps = {
          smart_rename = "<Leader>gr", -- mapping to rename reference under cursor
        },
      },
      navigation = {
        enable = true, -- use navigator
        keymaps = {
          goto_definition = "gnd",
          list_definitions = "gnD",
          list_definitions_toc = "gO", -- gT navigator
          -- goto_next_usage = "<c->>",
          -- goto_previous_usage = "<c-<>",
        },
      },
    },
    autopairs = { enable = true },
    autotag = { enable = true },
  })
end

local treesitter_context = function(width)
  if not packer_plugins["nvim-treesitter"] or packer_plugins["nvim-treesitter"].loaded == false then
    return " "
  end
  local type_patterns = {
    "class",
    "function",
    "method",
    "interface",
    "type_spec",
    "table",
    "if_statement",
    "for_statement",
    "for_in_statement",
    "call_expression",
    "comment",
  }

  if vim.o.ft == "json" then
    type_patterns = { "object", "pair" }
  end

  local f = require("nvim-treesitter").statusline({
    indicator_size = width,
    type_patterns = type_patterns,
  })
  local context = string.format("%s", f) -- convert to string, it may be a empty ts node

  -- lprint(context)
  if context == "vim.NIL" then
    return " "
  end

  return " " .. context
end


return {
 treesitter = treesitter,
 treesitter_ref = treesitter_ref,
 context = treesitter_context,
}
