local vim = vim
local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup '.. group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

function autocmd.load_autocmds()
  local definitions = {
    packer = {
      {
        "BufWritePost",
        "*.lua",
        "lua require('core.pack').auto_compile()"
      },
    },
    bufs = {
      { 
        "BufEnter", 
        "*", 
        "silent! lcd %:p:h" 
      },
      {
				"BufReadPost",
				"*",
				[[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
			},
      {
				"BufEnter",
				"*",
				[[++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]],
			},
    },

    wins = {
    },

    ft = {
    },

    yank = {
    },
  }

  autocmd.nvim_create_augroups(definitions)
end

autocmd.load_autocmds()
return autocmd
