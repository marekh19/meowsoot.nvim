-- Generates the README palette section as copyable Markdown.
--
-- Why not an SVG: an `![](palette.svg)` renders as a flattened image on GitHub,
-- so none of the hex codes are selectable or copyable. This generator trades
-- that single pretty picture for function: one Markdown table per variant, with
-- the hex as real text you can select, plus a per-color swatch SVG so the color
-- is still visible. GitHub strips inline `style`/`bgcolor`, so the only way to
-- show a color block is a committed image referenced as `<img>` — hence the
-- tiny per-color files under static/swatches/.
--
-- Returns a list of { path, content } writes (swatch files + the rewritten
-- README), spliced between the `<!-- palette:start -->` / `<!-- palette:end -->`
-- markers. The orchestrator writes each entry.

local Palette = require("meowsoot.palette")
local Util = require("meowsoot.util")

local M = {}

local SWATCH_DIR = "static/swatches"
local README = "README.md"
local START = "<!-- palette:start -->"
local STOP = "<!-- palette:end -->"

-- Curated overview — the six chromatic accents + the neutral ramp. The full
-- set (bright tiers, reserved green/red) lives in lua/meowsoot/palette.lua.
local ACCENTS = {
  { key = "pink", role = "functions, methods, headings" },
  { key = "lavender", role = "types, classes, modules" },
  { key = "cyan", role = "keywords, imports, tags, builtins" },
  { key = "peach", role = "constants, booleans" },
  { key = "blue", role = "ANSI 4/12, diff-change, info" },
  { key = "yellow", role = "strings, regex" },
}

local NEUTRALS = {
  { key = "bg_deep", role = "darkest panel" },
  { key = "bg_0", role = "editor background" },
  { key = "bg_1", role = "panel" },
  { key = "bg_2", role = "active line" },
  { key = "bg_3", role = "selection" },
  { key = "bg_4", role = "border" },
  { key = "indent", role = "indent guides" },
  { key = "fg_faint", role = "gutter, punctuation, operators" },
  { key = "comment", role = "comments" },
  { key = "fg_mute", role = "docs, folds, diagnostics, statusline" },
  { key = "fg", role = "foreground" },
}

-- A single rounded swatch. The grey stroke keeps near-black and near-white
-- entries visible on both GitHub light and dark themes.
local function swatch_svg(hex)
  return string.format(
    '<svg xmlns="http://www.w3.org/2000/svg" width="64" height="24" viewBox="0 0 64 24">'
      .. '<rect x="0.5" y="0.5" width="63" height="23" rx="5" fill="%s" stroke="rgba(128,128,128,0.4)"/>'
      .. "</svg>\n",
    hex
  )
end

-- Emit one swatch file per row, push to `writes`, return the table Markdown.
local function table_for(style, rows, colors, writes)
  local out = { "| Swatch | Name | Hex | Role |", "|---|---|---|---|" }
  for _, r in ipairs(rows) do
    local hex = colors[r.key]
    local path = string.format("%s/%s-%s.svg", SWATCH_DIR, style, r.key)
    writes[#writes + 1] = { path = path, content = swatch_svg(hex) }
    out[#out + 1] = string.format("| ![](%s) | %s | `%s` | %s |", path, r.key, hex, r.role)
  end
  return table.concat(out, "\n")
end

-- The orchestrator passes the night `colors` table; we ignore it and pull each
-- variant directly, since this documents both.
function M.generate(_)
  local writes = {}
  local sections = {}

  for _, v in ipairs({
    { label = "Night", style = "night" },
    { label = "Moon", style = "moon" },
    { label = "Dawn", style = "dawn" },
  }) do
    local colors = Palette.resolve(v.style)
    sections[#sections + 1] = table.concat({
      "#### " .. v.label,
      "",
      "**Accents**",
      "",
      table_for(v.style, ACCENTS, colors, writes),
      "",
      "**Neutrals**",
      "",
      table_for(v.style, NEUTRALS, colors, writes),
    }, "\n")
  end

  local block = START .. "\n\n" .. table.concat(sections, "\n\n") .. "\n\n" .. STOP

  local readme = Util.read(README) or error("meowsoot: cannot read " .. README)
  local s = readme:find(START, 1, true)
  local e = readme:find(STOP, 1, true)
  if not s or not e then
    error(
      "meowsoot: palette markers not found in "
        .. README
        .. " (expected "
        .. START
        .. " .. "
        .. STOP
        .. ")"
    )
  end
  local rewritten = readme:sub(1, s - 1) .. block .. readme:sub(e + #STOP)
  writes[#writes + 1] = { path = README, content = rewritten }

  return writes
end

return M
