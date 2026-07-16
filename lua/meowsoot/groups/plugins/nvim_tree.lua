local M = {}

M.url = "https://github.com/nvim-tree/nvim-tree.lua"

---@type fun(c: table, opts: table): table
function M.get(c, opts)
  local styles = opts.styles or {}
  -- stylua: ignore
  return {
    NvimTreeNormal       = { fg = c.fg, bg = c.bg_sidebar },
    NvimTreeNormalNC     = { fg = c.fg, bg = c.bg_sidebar },
    NvimTreeRootFolder   = { fg = c.pink, bold = true },
    NvimTreeFolderIcon   = { fg = c.cyan },
    NvimTreeFolderName   = { fg = c.fg },
    NvimTreeOpenedFolderName = { fg = c.fg, bold = true },
    NvimTreeEmptyFolderName  = { fg = c.fg_faint },
    NvimTreeFileIcon     = { fg = c.fg_mute },
    NvimTreeImageFile    = { fg = c.fg },
    NvimTreeSpecialFile  = { fg = c.lavender, underline = true },
    NvimTreeSymlink      = { fg = c.cyan, italic = true },
    NvimTreeExecFile     = { fg = c.peach },
    NvimTreeIndentMarker = { fg = c.indent },
    NvimTreeOpenedFile   = { bg = c.bg_highlight },
    NvimTreeCursorLine   = { bg = c.bg_3 },
    NvimTreeGitNew       = { fg = c.git.add },
    NvimTreeGitDirty     = { fg = c.git.change },
    NvimTreeGitStaged    = { fg = c.git.change },
    NvimTreeGitDeleted   = { fg = c.git.delete },
    NvimTreeGitRenamed   = { fg = c.warning },
    NvimTreeGitMerge     = { fg = c.warning },
    NvimTreeGitIgnored   = { fg = c.fg_faint },
    NvimTreeWinSeparator = {
      fg = styles.sidebars == "transparent" and c.border or c.bg_sidebar,
      bg = c.bg_sidebar,
    },
  }
end

return M
