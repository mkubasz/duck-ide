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

function config.outline()
  require("symbols-outline").setup({})
end

function config.aerial()
  require("aerial").setup({})
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
