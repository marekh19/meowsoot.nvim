local Util = require("meowsoot.util")

local M = {}

local template = [[
# meowsoot - Lazygit theme.
# https://github.com/marekh19/meowsoot.nvim
# Auto-generated from lua/meowsoot/palette.lua. Do not edit by hand.
# Load after your config:
#   lazygit --use-config-file="/path/to/config.yml,/path/to/${scheme_name}.yml"
# Use the matching terminal theme for the background.

gui:
  theme:
    activeBorderColor:
      - "${pink}"
      - bold
    inactiveBorderColor:
      - "${border}"
    searchingActiveBorderColor:
      - "${peach}"
      - bold
    optionsTextColor:
      - "${cyan}"
    selectedLineBgColor:
      - "${bg_visual}"
    inactiveViewSelectedLineBgColor:
      - "${bg_highlight}"
    cherryPickedCommitBgColor:
      - "${bg_match}"
    cherryPickedCommitFgColor:
      - "${fg}"
    markedBaseCommitBgColor:
      - "${bg_search}"
    markedBaseCommitFgColor:
      - "${fg}"
    unstagedChangesColor:
      - "${error}"
    defaultFgColor:
      - "${fg}"
]]

function M.generate(colors)
  return Util.template(template, colors)
end

return M
