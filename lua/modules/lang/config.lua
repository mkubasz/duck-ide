local config = {}

function config.nvim_treesitter()
  require("modules.lang.treesitter").treesitter()
end

function config.nvim_treesitter_ref()
  require("modules.lang.treesitter").treesitter_ref()
end

function config.refactor()
  local refactor = require("refactoring")
  refactor.setup({})

    _G.ts_refactors = function()
    -- telescope refactoring helper
    local function _refactor(prompt_bufnr)
      local content = require("telescope.actions.state").get_selected_entry(prompt_bufnr)
      require("telescope.actions").close(prompt_bufnr)
      require("refactoring").refactor(content.value)
    end

    local opts = require("telescope.themes").get_cursor() -- set personal telescope options
    require("telescope.pickers").new(opts, {
      prompt_title = "refactors",
      finder = require("telescope.finders").new_table({
        results = require("refactoring").get_refactors(),
      }),
      sorter = require("telescope.config").values.generic_sorter(opts),
      attach_mappings = function(_, map)
        map("i", "<CR>", _refactor)
        map("n", "<CR>", _refactor)
        return true
      end,
    }):find()
  end
end

function config.aerial()
  require("aerial").setup({
    backends = { "lsp", "treesitter", "markdown" },
    close_behavior = "auto",
    default_bindings = true,
    default_direction = "prefer_right",
    disable_max_lines = 10000,
    filter_kind = {
      "Class",
      "Constructor",
      "Enum",
      "Function",
      "Interface",
      "Module",
      "Method",
      "Struct",
    },
    highlight_mode = "split_width",
    highlight_on_jump = 300,
    icons = {},
    link_folds_to_tree = false,
    link_tree_to_folds = true,
    manage_folds = false,
    max_width = 40,
    min_width = 10,
    nerd_font = "auto",
    on_attach = nil,
    open_automatic = false,
    placement_editor_edge = false,
    post_jump_cmd = "normal! zz",
    close_on_select = false,
    show_guides = false,
    float = {
      border = "rounded",
      row = 1,
      col = 0,
      max_height = 100,
      min_height = 4,
    },
    lsp = {
      diagnostics_trigger_update = true,
      update_when_errors = true,
    },
    treesitter = {
      update_delay = 300,
    },
    markdown = {
      update_delay = 300,
    },
  })
end

function config.navigator()
  local nav_cfg = {
    lsp_installer = false,

    lsp = {
      disable_lsp = {
        'tsserver', 'jedi_language_server', 'sumneko_lua' 
      }, 
    },
  }
  require("navigator").setup(nav_cfg)
end

return config
