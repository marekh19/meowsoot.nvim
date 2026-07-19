local Util = require("meowsoot.util")

local M = {}

local template = [[
# meowsoot — WezTerm theme.
# https://github.com/marekh19/meowsoot.nvim
# Auto-generated from lua/meowsoot/palette.lua. Do not edit by hand.
# Drop into ~/.config/wezterm/colors/ and set: config.color_scheme = '${scheme_name}'
# See https://wezterm.org/config/appearance.html

[colors]
foreground = "${fg}"
background = "${bg_0}"
cursor_bg = "${pink}"
cursor_border = "${pink}"
cursor_fg = "${bg_0}"
selection_bg = "${bg_visual}"
selection_fg = "${fg}"
split = "${bg_4}"
compose_cursor = "${peach}"
scrollbar_thumb = "${bg_highlight}"

ansi = ["${terminal.black}", "${terminal.red}", "${terminal.green}", "${terminal.yellow}", "${terminal.blue}", "${terminal.magenta}", "${terminal.cyan}", "${terminal.white}"]
brights = ["${terminal.black_bright}", "${terminal.red_bright}", "${terminal.green_bright}", "${terminal.yellow_bright}", "${terminal.blue_bright}", "${terminal.magenta_bright}", "${terminal.cyan_bright}", "${terminal.white_bright}"]

[colors.tab_bar]
inactive_tab_edge = "${bg_deep}"
background = "${bg_tab_line}"

[colors.tab_bar.active_tab]
fg_color = "${bg_0}"
bg_color = "${pink}"

[colors.tab_bar.inactive_tab]
fg_color = "${fg_mute}"
bg_color = "${bg_highlight}"

[colors.tab_bar.inactive_tab_hover]
fg_color = "${pink}"
bg_color = "${bg_highlight}"

[colors.tab_bar.new_tab_hover]
fg_color = "${pink}"
bg_color = "${bg_0}"
intensity = "Bold"

[colors.tab_bar.new_tab]
fg_color = "${pink}"
bg_color = "${bg_0}"

[metadata]
aliases = []
author = "meowsoot"
name = "${scheme_name}"
]]

function M.generate(colors)
  return Util.template(template, colors)
end

return M
