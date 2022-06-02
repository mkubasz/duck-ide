local config = {}
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
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], "%s+", ""), -- "[%w%.+-"']",
    enable_check_bracket_line = false,
    html_break_line_filetype = {'html', 'vue', 'typescriptreact', 'svelte', 'javascriptreact'},
    check_ts = true,
    ts_config = {
      lua = {'string'}, -- it will not add pair on that treesitter node
      -- go = {'string'},
      javascript = {'template_string'},
      java = false -- don't check treesitter on java
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

function config.formatter()
  require('formatter').setup({
    filetype = {
     json = {
      function()
        return {
          exe = "jq",
          args = { "."},
          stdin = true
        }
      end
     }
    }
  })
end

function config.comment()
  require('Comment').setup({
    extended = true,
    post_hook = function(ctx)
      if ctx.range.scol == -1 then
        -- do something with the current line
      else
        if ctx.range.ecol > 400 then
          ctx.range.ecol = 1
        end
        if ctx.cmotion > 1 then
          vim.fn.setpos("'<", {0, ctx.range.srow, ctx.range.scol})
          vim.fn.setpos("'>", {0, ctx.range.erow, ctx.range.ecol})
          vim.cmd([[exe "norm! gv"]])
        end
      end
    end
  })
end

return config
