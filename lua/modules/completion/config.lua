local global = require("core.global")
local config = {}

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

function config.nvim_lsp()
  local lspclient = require("modules.completion.lsp")
  lspclient.setup()
end

function config.nvim_cmp()
  local cmp = require("cmp")

  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local luasnip = require("luasnip")
  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    completion = {
      autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
      completeopt = "menu,menuone,noselect",
    },
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<Right>"] = cmp.mapping(function(fallback)
        fallback()
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),

    },
    sources = cmp.config.sources({
      { name = 'cmp_tabnine' },
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'luasnip' },
      { name = "treesitter", keyword_length = 2 },
      { name = "look", keyword_length = 4 },
    }),
    experimental = { ghost_text = true },
  })

end

function config.luasnip()
  local ls = require("luasnip")
  ls.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI"
  })
  require("luasnip.loaders.from_vscode").load({})
end

function config.tabnine()
  local tabnine = require("cmp_tabnine.config")
  tabnine:setup({
    max_line = 1000,
    max_num_results = 20,
    sort = true,
    run_on_every_keystroke = true,
  })
end

return config
