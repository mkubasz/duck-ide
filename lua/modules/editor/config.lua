local config = {}

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

function config.ufo()
  --- not all LSP support this
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ("  %d "):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
  end
  local whitelist = {
    ["gotmpl"] = "indent",
    ["python"] = "lsp",
    ["html"] = "indent",
  }
  require("ufo").setup({
    -- fold_virt_text_handler = handler,
    provider_selector = function(bufnr, filetype)
      if whitelist[filetype] then
        return whitelist[filetype]
      end
      return ""
    end,
  })
  local bufnr = vim.api.nvim_get_current_buf()
  local ft = vim.o.ft
  if whitelist[ft] then
    require("ufo").setVirtTextHandler(bufnr, handler)
  end
end

return config
