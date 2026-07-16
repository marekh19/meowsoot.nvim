local Util = require("meowsoot.util")

local M = {}

M.url = "https://github.com/folke/snacks.nvim"

---@type fun(c: table, opts: table): table
function M.get(c, opts)
  local bg = opts.transparent and c.none or c.bg
  -- stylua: ignore
  local ret = {
    -- Notifier
    SnacksNotifierDebug       = { fg = c.fg, bg = bg },
    SnacksNotifierBorderDebug = { fg = Util.blend(c.fg_mute, 0.4, c.bg_0), bg = bg },
    SnacksNotifierIconDebug   = { fg = c.fg_mute },
    SnacksNotifierTitleDebug  = { fg = c.fg_mute },
    SnacksNotifierError       = { fg = c.fg, bg = bg },
    SnacksNotifierBorderError = { fg = Util.blend(c.error, 0.4, c.bg_0), bg = bg },
    SnacksNotifierIconError   = { fg = c.error },
    SnacksNotifierTitleError  = { fg = c.error },
    SnacksNotifierInfo        = { fg = c.fg, bg = bg },
    SnacksNotifierBorderInfo  = { fg = Util.blend(c.info, 0.4, c.bg_0), bg = bg },
    SnacksNotifierIconInfo    = { fg = c.info },
    SnacksNotifierTitleInfo   = { fg = c.info },
    SnacksNotifierTrace       = { fg = c.fg, bg = bg },
    SnacksNotifierBorderTrace = { fg = Util.blend(c.lavender, 0.4, c.bg_0), bg = bg },
    SnacksNotifierIconTrace   = { fg = c.lavender },
    SnacksNotifierTitleTrace  = { fg = c.lavender },
    SnacksNotifierWarn        = { fg = c.fg, bg = bg },
    SnacksNotifierBorderWarn  = { fg = Util.blend(c.warning, 0.4, c.bg_0), bg = bg },
    SnacksNotifierIconWarn    = { fg = c.warning },
    SnacksNotifierTitleWarn   = { fg = c.warning },

    -- Dashboard
    SnacksDashboardDesc    = { fg = c.cyan },
    SnacksDashboardFooter  = { fg = c.fg_mute, italic = true },
    SnacksDashboardHeader  = { fg = c.pink, bold = true },
    SnacksDashboardIcon    = { fg = c.lavender },
    SnacksDashboardKey     = { fg = c.peach },
    SnacksDashboardSpecial = { fg = c.lavender },
    SnacksDashboardDir     = { fg = c.fg_faint },

    -- Indent
    SnacksIndent      = { fg = c.indent, nocombine = true },
    SnacksIndentScope = { fg = c.lavender, nocombine = true },

    -- Input
    SnacksInputIcon   = { fg = c.cyan },
    SnacksInputBorder = { fg = c.peach },
    SnacksInputTitle  = { fg = c.peach },

    -- Picker
    SnacksPickerInputBorder    = { fg = c.peach, bg = c.bg_float },
    SnacksPickerInputTitle     = { fg = c.peach, bg = c.bg_float },
    SnacksPickerBoxTitle       = { fg = c.peach, bg = c.bg_float },
    SnacksPickerSelected       = { fg = c.pink, bold = true },
    SnacksPickerPickWinCurrent = { fg = c.fg, bg = c.pink, bold = true },
    SnacksPickerPickWin        = { fg = c.fg, bg = c.bg_search, bold = true },

    -- GitHub / diff
    SnacksGhLabel       = { fg = c.cyan, bold = true },
    SnacksDiffLabel     = { fg = c.cyan, bold = true },
    SnacksGhDiffHeader  = { bg = Util.blend(c.cyan, 0.1, c.bg_0), fg = c.cyan },

    -- Profiler
    SnacksProfilerIconInfo  = { bg = Util.blend(c.info, 0.3, c.bg_0), fg = c.info },
    SnacksProfilerBadgeInfo = { bg = Util.blend(c.info, 0.1, c.bg_0), fg = c.info },

    -- Zen
    SnacksZenIcon = { fg = c.lavender },
  }

  for i, color in ipairs(c.rainbow) do
    ret["SnacksIndent" .. i] = { fg = color, nocombine = true }
  end
  return ret
end

return M
