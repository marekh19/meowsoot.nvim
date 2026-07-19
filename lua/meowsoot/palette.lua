-- meowsoot palette.
-- Authored in HSL for ergonomic tuning on the color wheel:
--   { hue 0-360, saturation 0-100, lightness 0-100 }
-- Resolved to hex once at theme load via lua/meowsoot/hsl.lua.
--
-- Three variants:
--   night — original dark mood. Charcoal bg, soot-sprite blacks, nyan-pop accents.
--   moon  — cool dark counterpart. Blue-tinted neutrals, night's accents verbatim.
--   dawn  — light counterpart. Warm cream bg, sunrise-deep accents.
--
-- Accent tiering (8-point lightness spread on night; inverted-direction on dawn):
--   ANCHOR   structural anchors (functions, types, headings)
--   STANDARD frequent but communicative (keywords, constants)
--   QUIET    highest-frequency tokens (strings, numbers)
--   BRIGHT   rare emphasis only

local hsl = require("meowsoot.hsl")

local M = {}

-- stylua: ignore
local palettes = {
  -- ─────────────────────────────────────────────────────────────────────────
  -- night — the original dark theme. L runs 6→26 on bg, 88→50 on fg,
  -- accents at L=78 ANCHOR / 74 STANDARD / 70 QUIET / 85 BRIGHT.
  -- ─────────────────────────────────────────────────────────────────────────
  night = {
    -- Neutrals
    bg_deep  = {   0,  3,  6 }, -- darkest panel
    bg_0     = {   0,  2,  9 }, -- editor background
    bg_1     = {  40,  5, 12 }, -- panel
    bg_2     = {  20,  4, 15 }, -- active line
    bg_3     = {  30,  4, 20 }, -- selection
    bg_4     = {  24,  4, 26 }, -- border

    fg       = {  20,  5, 88 },
    fg_mute  = {  30,  5, 68 }, -- docs, folds, diagnostics, statusline, icons
    comment  = {  30,  5, 49 }, -- comments (~4.4:1 on bg_0)
    fg_faint = {  33,  4, 50 }, -- gutter, punctuation, operators
    indent   = {  33,  4, 27 }, -- passive indent guides (~1.9:1 on bg_0)

    -- Accents · ANCHOR (L=78)
    pink     = { 328, 62, 78 }, -- functions, methods, headings
    lavender = { 275, 58, 78 }, -- types, classes, modules

    -- Accents · STANDARD (L=74)
    cyan     = { 189, 58, 74 }, -- keywords, imports, tags, builtins
    peach    = {  20, 58, 74 }, -- constants, booleans
    blue     = { 208, 53, 73 }, -- ANSI slot 4/12, diff-change, info

    -- Accents · QUIET (L=70)
    yellow    = {  51, 58, 70 }, -- strings, regex
    peach_dim = {  20, 58, 70 }, -- numbers, floats

    -- Accents · BRIGHT (L=85) — rare emphasis
    cyan_br     = { 190, 55, 85 },
    lavender_br = { 274, 55, 85 },
    pink_br     = { 329, 55, 85 },
    peach_br    = {  20, 55, 85 },
    yellow_br   = {  50, 55, 85 },

    -- Reserved — UI/diff/git/success only. NEVER referenced from syntax groups
    -- (see lua/meowsoot/colors.lua semantic-alias chokepoint).
    green = { 140, 35, 70 },
    red   = {   0, 65, 75 },
  },

  -- ─────────────────────────────────────────────────────────────────────────
  -- dawn — the light counterpart. L runs 96→62 on bg, 20→58 on fg,
  -- accents inverted-tier: ANCHOR=32, STANDARD=36, QUIET=40, BRIGHT=26.
  -- Same hues as night for color identity. Same "no green in code" invariant.
  -- ─────────────────────────────────────────────────────────────────────────
  dawn = {
    -- Neutrals
    bg_deep  = {  30, 18, 89 }, -- sidebar frame
    bg_0     = {  38, 38, 96 }, -- editor — warm cream
    bg_1     = {  28, 18, 88 }, -- popup, statusline
    bg_2     = {  35, 25, 93 }, -- active line (subtle warm band)
    bg_3     = {  25, 22, 80 }, -- selection
    bg_4     = {  22, 18, 62 }, -- border

    fg       = {  25, 18, 20 }, -- dark warm charcoal
    fg_mute  = {  30, 12, 44 }, -- docs, folds, diagnostics, statusline, icons
    comment  = {  30, 12, 48 }, -- comments (~3.9:1 on bg_0)
    fg_faint = {  30,  8, 58 }, -- gutter, punctuation, operators
    indent   = {  30,  8, 79 }, -- passive indent guides (~1.5:1 on bg_0)

    -- Accents · ANCHOR (L=32; darker = more prominent on light bg)
    pink     = { 328, 78, 32 }, -- functions, methods, headings
    lavender = { 275, 55, 38 }, -- types, classes, modules

    -- Accents · STANDARD (L=36)
    cyan     = { 189, 70, 32 }, -- keywords, imports, tags, builtins
    peach    = {  20, 78, 36 }, -- constants, booleans
    blue     = { 208, 62, 38 }, -- ANSI slot 4/12, diff-change, info

    -- Accents · QUIET (L=40)
    yellow    = {  45, 78, 32 }, -- strings — mustard ochre on cream
    peach_dim = {  20, 60, 45 }, -- numbers, floats

    -- Accents · BRIGHT (L=26) — rare emphasis
    cyan_br     = { 190, 75, 26 },
    lavender_br = { 275, 65, 30 },
    pink_br     = { 329, 82, 28 },
    peach_br    = {  20, 88, 30 },
    yellow_br   = {  45, 88, 28 },

    -- Reserved — UI/diff/git/success only.
    green = { 140, 60, 30 },
    red   = {   0, 75, 36 },
  },

  -- ─────────────────────────────────────────────────────────────────────────
  -- moon — cool dark counterpart. Blue-tinted neutrals (H≈230°, calm Rosé-Pine
  -- saturation), lifted a few L-points above night for a softer "moonlit" bg.
  -- Accents reuse night verbatim: same six-hue identity, warm pink/peach/yellow
  -- popping against the cool canvas, all still AAA on the lifted bg. Same
  -- "no green in code" invariant.
  -- ─────────────────────────────────────────────────────────────────────────
  moon = {
    -- Neutrals — cool tilt (H=230), calm saturation (S 12→25, bg→fg), lifted
    -- ~+2L vs night. comment/indent/fg_faint re-tuned to night's contrast bands.
    bg_deep  = { 230, 20,  8 }, -- darkest panel
    bg_0     = { 230, 18, 11 }, -- editor background
    bg_1     = { 230, 16, 15 }, -- panel
    bg_2     = { 230, 15, 18 }, -- active line
    bg_3     = { 230, 14, 24 }, -- selection
    bg_4     = { 230, 13, 29 }, -- border

    fg       = { 230, 25, 88 }, -- cool pale blue
    fg_mute  = { 230, 16, 68 }, -- docs, folds, diagnostics, statusline, icons
    comment  = { 232, 14, 54 }, -- comments (~4.4:1 on bg_0)
    fg_faint = { 230, 12, 53 }, -- gutter, punctuation, operators (~4.4:1)
    indent   = { 230, 12, 30 }, -- passive indent guides (~1.9:1 on bg_0)

    -- Accents · reused verbatim from night (same hues + tiers). On the lifted
    -- cool canvas each still clears AAA (8.3–11.2:1 on bg_0).
    -- ANCHOR (L=78)
    pink     = { 328, 62, 78 }, -- functions, methods, headings
    lavender = { 275, 58, 78 }, -- types, classes, modules

    -- STANDARD (L=74)
    cyan     = { 189, 58, 74 }, -- keywords, imports, tags, builtins
    peach    = {  20, 58, 74 }, -- constants, booleans
    blue     = { 208, 53, 73 }, -- ANSI slot 4/12, diff-change, info

    -- QUIET (L=70)
    yellow    = {  51, 58, 70 }, -- strings, regex
    peach_dim = {  20, 58, 70 }, -- numbers, floats

    -- BRIGHT (L=85) — rare emphasis
    cyan_br     = { 190, 55, 85 },
    lavender_br = { 274, 55, 85 },
    pink_br     = { 329, 55, 85 },
    peach_br    = {  20, 55, 85 },
    yellow_br   = {  50, 55, 85 },

    -- Reserved — UI/diff/git/success only.
    green = { 140, 35, 70 },
    red   = {   0, 65, 75 },
  },
}

---@alias meowsoot.Style "night"|"dawn"|"moon"

---Resolve all HSL entries to hex strings for the requested style.
---@param style? meowsoot.Style defaults to "night"
---@return table<string,string>
function M.resolve(style)
  local p = palettes[style or "night"] or palettes.night
  local out = {}
  for name, triplet in pairs(p) do
    out[name] = hsl.to_hex(triplet)
  end
  out.none = "NONE"
  return out
end

---Raw HSL palette for the requested style. Used by extras generator.
---@param style? meowsoot.Style defaults to "night"
function M.hsl_for(style)
  return palettes[style or "night"] or palettes.night
end

-- Back-compat: `M.hsl` continues to expose the night palette so any caller
-- that read it pre-variant keeps working.
M.hsl = palettes.night

return M
