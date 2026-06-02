-- Extras orchestrator. Builds a non-transparent palette, runs each generator,
-- writes the result. Invoked from the justfile via:
--   nvim --headless -l ... -c 'lua require("meowsoot.extras").setup()'

local Util = require("meowsoot.util")

local M = {}

M.targets = {
  { name = "ghostty", path = "extras/ghostty/meowsoot" },
  { name = "kitty", path = "extras/kitty/meowsoot.conf" },
  { name = "alacritty", path = "extras/alacritty/meowsoot.toml" },
  { name = "wezterm", path = "extras/wezterm/meowsoot.toml" },
  { name = "tmux", path = "extras/tmux/meowsoot.tmux" },
  { name = "fish", path = "extras/fish/meowsoot.fish" },
  { name = "fzf", path = "extras/fzf/meowsoot.conf" },
  -- README palette tables + per-color swatches. Emits copyable Markdown (hex as
  -- selectable text) covering both variants from a single source of truth.
  -- Returns a list of writes instead of one file. Stays in sync via `just extras`.
  { name = "palette_md" },
}

function M.setup()
  -- Force non-transparent night palette for the snapshot — extras are terminal
  -- configs that ship to match the canonical dark theme. A dawn-extras pass can
  -- be added later if/when there's demand.
  local colors = require("meowsoot.colors").setup({
    style = "night",
    transparent = false,
    styles = { sidebars = "dark", floats = "dark" },
  })

  for _, target in ipairs(M.targets) do
    local mod = require("meowsoot.extras." .. target.name)
    local content = mod.generate(colors)
    -- A generator returns either a single string (→ target.path) or a list of
    -- { path, content } writes (multi-file generators like palette_md).
    local writes = type(content) == "string" and { { path = target.path, content = content } }
      or content
    for _, w in ipairs(writes) do
      Util.write(w.path, w.content)
      io.write("[meowsoot] wrote " .. w.path .. "\n")
    end
  end
end

return M
