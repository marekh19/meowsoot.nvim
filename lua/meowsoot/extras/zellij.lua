local Util = require("meowsoot.util")

local M = {}

local template = [[
# meowsoot — Zellij theme.
# https://github.com/marekh19/meowsoot.nvim
# Auto-generated from lua/meowsoot/palette.lua. Do not edit by hand.
# Install: cp extras/zellij/meowsoot.kdl ~/.config/zellij/themes/
# Load: Edit ~/.config/zellij/config.kdl to have "theme = meowsoot"
# Note: You may have to create the themes directory mkdir -p ~/.config/zellij/themes/

themes {
    meowsoot {
        ribbon_unselected {
            base ${cyan}
            background ${bg_1}
            emphasis_0 ${pink}
            emphasis_1 ${yellow}
            emphasis_2 ${peach}
            emphasis_3 ${fg_mute}
            }
        ribbon_selected {
            base ${pink}
            background ${bg_1}
            emphasis_0 ${pink}
            emphasis_1 ${yellow}
            emphasis_2 ${peach}
            emphasis_3 ${fg_mute}
        }
        text_unselected {
            base ${cyan}
            background ${bg_1}
            emphasis_0 ${pink}
            emphasis_1 ${yellow}
            emphasis_2 ${peach}
            emphasis_3 ${fg_mute}
            }
        text_selected {
            base ${pink}
            background ${bg_1}
            emphasis_0 ${pink}
            emphasis_1 ${yellow}
            emphasis_2 ${peach}
            emphasis_3 ${fg_mute}
        }
        table_title {
            base ${cyan}
            background ${bg_1}
            emphasis_0 ${pink}
            emphasis_1 ${yellow}
            emphasis_2 ${peach}
            emphasis_3 ${fg_mute}
        }
        table_cell_unselected {
            base ${cyan}
            background ${bg_1}
            emphasis_0 ${pink}
            emphasis_1 ${yellow}
            emphasis_2 ${peach}
            emphasis_3 ${fg_mute}
        }
        table_cell_selected {
            base ${pink}
            background ${bg_1}
            emphasis_0 ${cyan}
            emphasis_1 ${yellow}
            emphasis_2 ${peach}
            emphasis_3 ${fg_mute}
        }
        list_unselected {
            base ${cyan}
            background ${bg_1}
            emphasis_0 ${pink}
            emphasis_1 ${yellow}
            emphasis_2 ${peach}
            emphasis_3 ${fg_mute}
        }
        list_selected {
            base ${pink}
            background ${bg_1}
            emphasis_0 ${cyan}
            emphasis_1 ${yellow}
            emphasis_2 ${peach}
            emphasis_3 ${fg_mute}
        }
        frame_unselected {
            base ${cyan}
            background ${bg_1}
            emphasis_0 ${pink}
            emphasis_1 ${yellow}
            emphasis_2 ${peach}
            emphasis_3 ${fg_mute}
        }
        frame_selected {
            base ${pink}
            background ${bg_1}
            emphasis_0 ${pink}
            emphasis_1 ${yellow}
            emphasis_2 ${peach}
            emphasis_3 ${fg_mute}
        }
        frame_highlight {
            base ${yellow}
            background ${bg_1}
            emphasis_0 ${pink}
            emphasis_1 ${yellow}
            emphasis_2 ${peach}
            emphasis_3 ${fg_mute}
        }
        exit_code_success {
            base ${cyan}
            background ${bg_1}
            emphasis_0 ${pink}
            emphasis_1 ${yellow}
            emphasis_2 ${peach}
            emphasis_3 ${fg_mute}
        }
        exit_code_error {
            base ${pink}
            background ${bg_1}
            emphasis_0 ${pink}
            emphasis_1 ${yellow}
            emphasis_2 ${peach}
            emphasis_3 ${fg_mute}
        }
    }
}
]]

function M.hex_to_rgb(hex)
  local r = tonumber(string.sub(tostring(hex), 2, 3), 16)
  local g = tonumber(string.sub(tostring(hex), 4, 5), 16)
  local b = tonumber(string.sub(tostring(hex), 6, 7), 16)
  return string.format("%03d %03d %03d", r, g, b)
end

---Substitute `${var}` (and nested `${a.b}`) in a template against a table.
---@param str string
---@param tbl table
---@return string
function M.zellij_template(str, tbl)
  return (
    str:gsub("($%b{})", function(w)
      local hex = vim.tbl_get(tbl, unpack(vim.split(w:sub(3, -2), ".", { plain = true }))) or w
      return M.hex_to_rgb(hex)
    end)
  )
end

function M.generate(colors)
  return M.zellij_template(template, colors)
end

return M
