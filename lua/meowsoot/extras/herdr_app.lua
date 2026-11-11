local Util = require("meowsoot.util")

local M = {}

-- JSON has no comments, so the "generated file" note lives in the README.
-- Herdr derives every panel color it is not given from the terminal colors;
-- the `colors` block only replaces its derived accent with meowsoot pink,
-- paired with the same text color as the Ghostty cursor.
local template = [[
{
  "background": "${bg_0}",
  "foreground": "${fg}",
  "selection": "${bg_visual}",
  "cursor": "${pink}",
  "ansi": [
    "${terminal.black}",
    "${terminal.red}",
    "${terminal.green}",
    "${terminal.yellow}",
    "${terminal.blue}",
    "${terminal.magenta}",
    "${terminal.cyan}",
    "${terminal.white}",
    "${terminal.black_bright}",
    "${terminal.red_bright}",
    "${terminal.green_bright}",
    "${terminal.yellow_bright}",
    "${terminal.blue_bright}",
    "${terminal.magenta_bright}",
    "${terminal.cyan_bright}",
    "${terminal.white_bright}"
  ],
  "colors": {
    "accent": "${pink}",
    "accent_foreground": "${bg_0}"
  }
}
]]

function M.generate(colors)
  return Util.template(template, colors)
end

return M
