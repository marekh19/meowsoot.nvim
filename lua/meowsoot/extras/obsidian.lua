local Util = require("meowsoot.util")
local hsl = require("meowsoot.hsl")

local M = {}

-- The selector list mirrors Minimal's own default scheme selector. The bare
-- mode class covers vaults without Minimal Theme Settings; the second selector
-- matches its "Default" scheme class at equal specificity, and snippets load
-- after the theme, so the snippet wins in both cases.
local template = [[
/*
${scheme_name} - Obsidian CSS snippet for the Minimal theme.
https://github.com/marekh19/meowsoot.nvim
Auto-generated from lua/meowsoot/palette.lua. Do not edit by hand.
Replaces Minimal's Default ${obsidian.mode} color scheme. Setup: extras/obsidian/README.md
*/

.theme-${obsidian.mode},
.theme-${obsidian.mode}.minimal-default-${obsidian.mode} {
  --color-red-rgb: ${obsidian.rgb.red};
  --color-orange-rgb: ${obsidian.rgb.peach};
  --color-yellow-rgb: ${obsidian.rgb.yellow};
  --color-green-rgb: ${obsidian.rgb.ok};
  --color-cyan-rgb: ${obsidian.rgb.cyan};
  --color-blue-rgb: ${obsidian.rgb.blue};
  --color-purple-rgb: ${obsidian.rgb.lavender};
  --color-pink-rgb: ${obsidian.rgb.pink};

  --color-red: ${red};
  --color-orange: ${peach};
  --color-yellow: ${yellow};
  --color-green: ${ok};
  --color-cyan: ${cyan};
  --color-blue: ${blue};
  --color-purple: ${lavender};
  --color-pink: ${pink};

  --base-h: ${obsidian.base.h};
  --base-s: ${obsidian.base.s}%;
  --base-l: ${obsidian.base.l}%;

  --accent-h: ${obsidian.accent.h};
  --accent-s: ${obsidian.accent.s}%;
  --accent-l: ${obsidian.accent.l}%;

  --bg1: ${bg_0};
  --bg2: ${bg_deep};
  --bg3: ${obsidian.hover};

  --ui1: ${bg_3};
  --ui2: ${border};
  --ui3: ${fg_faint};

  --tx1: ${fg};
  --tx2: ${fg_mute};
  --tx3: ${fg_faint};
  --tx4: ${fg_mute};

  --hl1: ${obsidian.selection};
  --hl2: rgba(${obsidian.rgb.yellow},0.35);
  --sp1: ${bg_0};

  --caret-color: ${pink};
  --link-color: ${cyan};
  --link-color-hover: ${cyan_br};
  --link-external-color: ${cyan};
  --link-external-color-hover: ${cyan_br};
  --list-marker-color: ${cyan};

  /* Obsidian's defaults make strings green; meowsoot keeps green out of code. */
  --code-comment: ${comment};
  --code-function: ${pink};
  --code-important: ${peach};
  --code-keyword: ${cyan};
  --code-operator: ${fg_faint};
  --code-property: ${fg};
  --code-punctuation: ${fg_faint};
  --code-string: ${yellow};
  --code-tag: ${cyan};
  --code-value: ${peach};
}

/* Minimal's colorful headings use green for h4; this uses the meowsoot rainbow. */
.theme-${obsidian.mode}.colorful-headings {
  --h1-color: ${pink};
  --h2-color: ${peach};
  --h3-color: ${yellow};
  --h4-color: ${cyan};
  --h5-color: ${blue};
  --h6-color: ${lavender};
}
]]

local function channels(hex)
  return { tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16) }
end

local function rgb(hex)
  return table.concat(channels(hex), ",")
end

-- Minimal draws hover and selection as translucent layers so they also work on
-- panels. Pick the fg alpha that reproduces `target` over the editor background.
local function overlay(target, fg, bg)
  local t, f, b = channels(target), channels(fg), channels(bg)
  local num, den = 0, 0
  for i = 1, 3 do
    num = num + t[i] - b[i]
    den = den + f[i] - b[i]
  end
  return string.format("rgba(%s,%.2f)", rgb(fg), num / den)
end

local function hsl_parts(hex)
  local h = hsl.from_hex(hex)
  return { h = h[1], s = h[2], l = h[3] }
end

function M.generate(colors)
  local rgbs = {}
  for _, name in ipairs({ "red", "peach", "yellow", "ok", "cyan", "blue", "lavender", "pink" }) do
    rgbs[name] = rgb(colors[name])
  end

  local vars = vim.tbl_extend("force", colors, {
    obsidian = {
      mode = colors.is_light and "light" or "dark",
      rgb = rgbs,
      base = hsl_parts(colors.bg_0),
      accent = hsl_parts(colors.pink),
      hover = overlay(colors.bg_highlight, colors.fg, colors.bg_0),
      selection = overlay(colors.bg_visual, colors.fg, colors.bg_0),
    },
  })
  return Util.template(template, vars)
end

return M
