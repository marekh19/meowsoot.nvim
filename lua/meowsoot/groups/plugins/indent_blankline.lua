local M = {}

M.url = "https://github.com/lukas-reineke/indent-blankline.nvim"

---@type fun(c: table, opts: table): table
function M.get(c)
  -- stylua: ignore
  return {
    -- v2 names (older)
    IndentBlanklineChar        = { fg = c.indent, nocombine = true },
    IndentBlanklineContextChar = { fg = c.lavender, nocombine = true },
    -- v3 names
    IblIndent  = { fg = c.indent, nocombine = true },
    IblScope   = { fg = c.lavender, nocombine = true },
    IblWhitespace = { fg = c.indent, nocombine = true },
  }
end

return M
