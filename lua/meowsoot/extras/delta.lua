local Util = require("meowsoot.util")

local M = {}

local template = [[
# meowsoot - delta theme.
# https://github.com/marekh19/meowsoot.nvim
# Auto-generated from lua/meowsoot/palette.lua. Do not edit by hand.
# Requires extras/bat/${scheme_name}.tmTheme in bat's theme directory and:
#   bat cache --build
# Include from ~/.gitconfig:  [include] path = /path/to/${scheme_name}.gitconfig

[delta]
  syntax-theme                  = ${scheme_name}
  ${color_mode}
  zero-style                    = syntax
  minus-style                   = syntax "${diff.delete}"
  minus-non-emph-style          = syntax "${diff.delete}"
  minus-emph-style              = bold syntax "${delta.delete_emph}"
  minus-empty-line-marker-style = syntax "${diff.delete}"
  plus-style                    = syntax "${diff.add}"
  plus-non-emph-style           = syntax "${diff.add}"
  plus-emph-style               = bold syntax "${delta.add_emph}"
  plus-empty-line-marker-style  = syntax "${diff.add}"
  line-numbers-left-style       = "${fg_faint}"
  line-numbers-minus-style      = "${git.delete}"
  line-numbers-plus-style       = "${git.add}"
  line-numbers-right-style      = "${fg_faint}"
  line-numbers-zero-style       = "${fg_faint}"
  file-style                    = "${fg}"
  file-decoration-style         = "${bg_4}" ul
  hunk-header-style             = file line-number syntax
  hunk-header-decoration-style  = "${bg_4}" box ul
  hunk-header-file-style        = bold "${fg}"
  hunk-header-line-number-style = "${fg_mute}"
  commit-decoration-style       = "${border_highlight}" box ul
  blame-palette                 = "${bg_deep}" "${bg_1}" "${bg_2}" "${bg_3}"
]]

function M.generate(colors)
  colors.color_mode = colors.is_light and "light = true" or "dark = true"
  colors.delta = {
    add_emph = Util.blend(colors.git.add, 0.35, colors.bg_0),
    delete_emph = Util.blend(colors.git.delete, 0.35, colors.bg_0),
  }
  return Util.template(template, colors)
end

return M
