-- Configuration defaults + user-merge.

local M = {}

M.version = "0.1.1"

---@class meowsoot.Config
M.defaults = {
  ---Variant. `"night"` (default) warm dark; `"moon"` cool blue-tinted dark; `"dawn"` warm light.
  ---When unset, `vim.o.background == "light"` auto-selects `"dawn"`.
  ---@type meowsoot.Style
  style = "night",
  transparent = false,
  terminal_colors = true,
  cache = true,
  styles = {
    comments = { italic = true },
    keywords = {},
    functions = {},
    variables = {},
    sidebars = "dark", -- "dark" | "transparent" | "normal"
    floats = "dark",
  },
  ---Per-plugin overrides. `nil` honors auto-detection.
  plugins = {
    all = package.loaded.lazy == nil,
    auto = true,
  },
  on_colors = function(_) end,
  on_highlights = function(_, _) end,
}

M.options = vim.deepcopy(M.defaults)

---Merge user options into defaults.
function M.extend(opts)
  M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M
