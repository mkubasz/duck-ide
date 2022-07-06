local global = require("core.global")
local config = {}

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
    formatting = {
      format = function(entry, vim_item)
        if cmp_kind == nil then
          cmp_kind = require("navigator.lspclient.lspkind").cmp_kind
        end
        vim_item.kind = cmp_kind(vim_item.kind)
        vim_item.menu = ({
          buffer = " ﬘",
          nvim_lsp = " ",
          luasnip = " 🐍",
          treesitter = " ",
          nvim_lua = " ",
          spell = " 暈",
          emoji = "ﲃ",
          cmp_tabnine = " ",
          look = "﬜",
        })[entry.source.name]
        return vim_item
      end,
    },
    completion = {
      autocomplete = {
        require("cmp.types").cmp.TriggerEvent.TextChanged
      },
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
      { name = "path" },
    }),
    experimental = { ghost_text = true },
  })

  require("packer").loader("nvim-autopairs")
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")
  cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({ map_char = { tex = "" } })
  )
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
    snippet_placeholder = "..",
    show_prediction_strength = false,
  })
end

function config.autopairs()
  local has_autopairs, autopairs = pcall(require, "nvim-autopairs")
  if not has_autopairs then
    print("autopairs not loaded")

    local loader = require"packer".loader
    loader('nvim-autopairs')
    has_autopairs, autopairs = pcall(require, "nvim-autopairs")
    if not has_autopairs then
      print("autopairs not installed")
      return
    end
  end

  local npairs = require("nvim-autopairs")
  local Rule = require("nvim-autopairs.rule")
  npairs.setup({
    disable_filetype = {"TelescopePrompt", "guihua", "guihua_rust", "clap_input"},
    autopairs = {enable = true},
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""), 
    enable_check_bracket_line = false,
    html_break_line_filetype = {'html', 'vue', 'typescriptreact', 'svelte', 'javascriptreact'},
    check_ts = true,
    ts_config = {
      lua = {'string'},
      javascript = {'template_string'},
      java = false    
    },
    fast_wrap = {
      map = '<M-e>',
      chars = {'{', '[', '(', '"', "'", "`"},
      pattern = string.gsub([[ [%'%"%`%+%)%>%]%)%}%,%s] ]], '%s+', ''),
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      hightlight = 'Search'
    }
  })
  local ts_conds = require('nvim-autopairs.ts-conds')
  -- you need setup cmp first put this after cmp.setup()

  npairs.add_rules {
    Rule(" ", " "):with_pair(function(opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({"()", "[]", "{}"}, pair)
    end), Rule("(", ")"):with_pair(function(opts)
      return opts.prev_char:match ".%)" ~= nil
    end):use_key ")", Rule("{", "}"):with_pair(function(opts)
      return opts.prev_char:match ".%}" ~= nil
    end):use_key "}", Rule("[", "]"):with_pair(function(opts)
      return opts.prev_char:match ".%]" ~= nil
    end):use_key "]", Rule("%", "%", "lua") -- press % => %% is only inside comment or string
    :with_pair(ts_conds.is_ts_node({'string', 'comment'})),
    Rule("$", "$", "lua"):with_pair(ts_conds.is_not_ts_node({'function'}))
  }

  -- If you want insert `(` after select function or method item
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))
end

return config
