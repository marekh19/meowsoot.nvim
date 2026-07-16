-- Palette resolution + semantic alias layer.
--
-- ENFORCEMENT NOTE: The raw palette green is INTENTIONALLY not exposed as a
-- top-level key on the returned `c` table. Highlight group files reach green
-- only through namespaced semantic aliases:
--   c.git.add, c.diff.add, c.ok, c.terminal.green
-- This makes "no green in code syntax" a structural property: writing
-- `c.green` in any group file resolves to `nil` and fails loudly.

local Util = require("meowsoot.util")
local Palette = require("meowsoot.palette")

local M = {}

---@param opts meowsoot.Config
function M.setup(opts)
  opts = opts or require("meowsoot.config").options
  local p = Palette.resolve(opts.style)

  Util.bg = p.bg_0
  Util.fg = p.fg

  local c = {
    none = "NONE",

    -- Background tiers
    bg = p.bg_0,
    bg_deep = p.bg_deep,
    bg_0 = p.bg_0,
    bg_1 = p.bg_1,
    bg_2 = p.bg_2,
    bg_3 = p.bg_3,
    bg_4 = p.bg_4,
    bg_dark = p.bg_deep,

    -- Foreground tiers
    fg = p.fg,
    fg_mute = p.fg_mute,
    fg_faint = p.fg_faint,
    fg_dark = p.fg_mute,
    fg_gutter = p.fg_faint,
    indent = p.indent,
    comment = p.comment,

    -- Accents (direct pass-through — NOTE: no `green` key)
    pink = p.pink,
    pink_br = p.pink_br,
    lavender = p.lavender,
    lavender_br = p.lavender_br,
    cyan = p.cyan,
    cyan_br = p.cyan_br,
    peach = p.peach,
    peach_br = p.peach_br,
    peach_dim = p.peach_dim,
    yellow = p.yellow,
    yellow_br = p.yellow_br,
    blue = p.blue,
    red = p.red,

    -- Semantic aliases (UI states; green leaks only through these)
    error = p.red,
    warning = p.yellow,
    info = p.blue,
    hint = p.cyan, -- explicitly NOT green
    ok = p.green, -- success / DiagnosticOk
    todo = p.peach,
  }

  -- Style-dependent bg layers
  local sidebars = opts.styles and opts.styles.sidebars or "dark"
  local floats = opts.styles and opts.styles.floats or "dark"

  c.bg_sidebar = sidebars == "transparent" and c.none or sidebars == "dark" and c.bg_deep or c.bg_0
  c.bg_float = floats == "transparent" and c.none or floats == "dark" and c.bg_deep or c.bg_1
  c.bg_popup = c.bg_1
  c.bg_statusline = c.bg_1
  c.bg_statusline_nc = c.bg_1
  c.bg_tab_line = c.bg_deep
  c.bg_visual = c.bg_3
  c.bg_highlight = c.bg_2
  c.bg_search = Util.blend(p.yellow, 0.35, c.bg_0)
  c.bg_search_current = Util.blend(p.peach, 0.45, c.bg_0)
  c.bg_match = Util.blend(p.cyan, 0.3, c.bg_0)
  c.border = c.bg_4
  c.border_highlight = Util.blend(p.pink, 0.6, c.bg_0)

  -- Transparency
  if opts.transparent then
    c.bg = c.none
    c.bg_sidebar = c.none
    c.bg_float = c.none
    c.bg_statusline = c.none
    c.bg_tab_line = c.none
  end

  -- Diff bg blends (subtle washes, distinct from line bg)
  c.diff = {
    add = Util.blend(p.green, 0.18, p.bg_0),
    change = Util.blend(p.blue, 0.18, p.bg_0),
    delete = Util.blend(p.red, 0.18, p.bg_0),
    text = Util.blend(p.blue, 0.35, p.bg_0),
  }

  -- Git sign foregrounds
  c.git = {
    add = p.green,
    change = p.blue,
    delete = p.red,
  }

  -- Rainbow palette (markdown headings 1-6, rainbow-delimiters, indent guides)
  c.rainbow = { c.pink, c.peach, c.yellow, c.cyan, c.blue, c.lavender }

  -- Terminal ANSI 16-slot mapping
  c.terminal = {
    black = p.bg_0,
    black_bright = p.bg_4,
    red = p.red,
    red_bright = Util.brighten(p.red, 8),
    green = p.green,
    green_bright = Util.brighten(p.green, 10),
    yellow = p.yellow,
    yellow_bright = p.yellow_br,
    blue = p.blue,
    blue_bright = Util.brighten(p.blue, 8),
    magenta = p.pink,
    magenta_bright = p.pink_br,
    cyan = p.cyan,
    cyan_bright = p.cyan_br,
    white = p.fg_mute,
    white_bright = p.fg,
  }

  if opts.on_colors then
    opts.on_colors(c)
  end

  return c
end

return M
