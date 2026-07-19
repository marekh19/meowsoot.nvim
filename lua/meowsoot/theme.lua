-- Core orchestrator: build colors + groups, apply highlights, set terminal slots.

local M = {}

---@param opts? meowsoot.Config
function M.setup(opts)
  opts = vim.tbl_deep_extend("force", require("meowsoot.config").options, opts or {})

  local colors = require("meowsoot.colors").setup(opts)
  local groups, names = require("meowsoot.groups").setup(colors, opts)

  if vim.g.colors_name then
    vim.cmd.highlight("clear")
  end
  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd.syntax("reset")
  end

  vim.o.termguicolors = true
  vim.o.background = opts.style == "dawn" and "light" or "dark"
  vim.g.colors_name = "meowsoot"
  -- Expose the active variant so palette-driven consumers (e.g. the lualine
  -- theme) can disambiguate the two dark variants, which share `background`.
  vim.g.meowsoot_style = opts.style

  for group, hl in pairs(groups) do
    if type(hl) == "string" then
      hl = { link = hl }
    end
    vim.api.nvim_set_hl(0, group, hl)
  end

  if opts.terminal_colors then
    M.terminal(colors)
  end

  return { colors = colors, groups = groups, plugins = names, opts = opts }
end

---Map `c.terminal` table into `vim.g.terminal_color_0..15`.
function M.terminal(c)
  local t = c.terminal
  vim.g.terminal_color_0 = t.black
  vim.g.terminal_color_8 = t.black_bright
  vim.g.terminal_color_1 = t.red
  vim.g.terminal_color_9 = t.red_bright
  vim.g.terminal_color_2 = t.green
  vim.g.terminal_color_10 = t.green_bright
  vim.g.terminal_color_3 = t.yellow
  vim.g.terminal_color_11 = t.yellow_bright
  vim.g.terminal_color_4 = t.blue
  vim.g.terminal_color_12 = t.blue_bright
  vim.g.terminal_color_5 = t.magenta
  vim.g.terminal_color_13 = t.magenta_bright
  vim.g.terminal_color_6 = t.cyan
  vim.g.terminal_color_14 = t.cyan_bright
  vim.g.terminal_color_7 = t.white
  vim.g.terminal_color_15 = t.white_bright
end

return M
