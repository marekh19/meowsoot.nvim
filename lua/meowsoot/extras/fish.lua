local Util = require("meowsoot.util")

local M = {}

-- No [dark]/[light] sections: Fish rejects a sectioned theme that lacks the
-- terminal's reported mode, and each file is already one fixed variant.
local template = [[
# name: '${scheme_name}'
# url: 'https://github.com/marekh19/meowsoot.nvim'
# meowsoot - Fish shell theme.
# Auto-generated from lua/meowsoot/palette.lua. Do not edit by hand.
# Install:  cp extras/fish/${scheme_name}.theme ~/.config/fish/themes/
# Select:   fish_config theme choose ${scheme_name}

# Syntax Highlighting Colors
fish_color_normal ${fg}
fish_color_command ${cyan}
fish_color_keyword ${lavender}
fish_color_quote ${yellow}
fish_color_redirection ${cyan}
fish_color_end ${fg}
fish_color_error ${red}
fish_color_param ${fg}
fish_color_option ${peach}
fish_color_comment ${fg_mute}
fish_color_selection --background=${bg_visual}
fish_color_operator ${cyan}
fish_color_escape ${peach}
fish_color_autosuggestion ${fg_mute}
fish_color_cwd ${cyan}
fish_color_cwd_root ${red}
fish_color_valid_path --underline
fish_color_history_current --bold
fish_color_search_match --background=${bg_visual}
fish_color_match ${cyan_br}
fish_color_cancel ${red}

# Completion Pager Colors
fish_pager_color_progress ${fg_mute}
fish_pager_color_prefix ${cyan}
fish_pager_color_completion ${fg}
fish_pager_color_description ${fg_mute}
fish_pager_color_selected_background --background=${bg_visual}
fish_pager_color_selected_completion ${fg}
fish_pager_color_selected_description ${fg_mute}
fish_pager_color_selected_prefix ${cyan}
]]

---@param colors table
function M.generate(colors)
  -- Fish needs hex without '#'
  local fc = {}
  for k, v in pairs(colors) do
    if type(v) == "string" then
      fc[k] = v:gsub("^#", "")
    elseif type(v) == "table" then
      fc[k] = {}
      for kk, vv in pairs(v) do
        if type(vv) == "string" then
          fc[k][kk] = vv:gsub("^#", "")
        end
      end
    end
  end
  return Util.template(template, fc)
end

return M
