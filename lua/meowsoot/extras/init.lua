-- Extras orchestrator. For every style, builds a non-transparent palette, runs
-- each terminal/shell generator, and writes a per-variant file. Night is the
-- canonical default and keeps the unsuffixed filename; moon/dawn get a
-- `-<style>` filename suffix. Invoked from the justfile via:
--   nvim --headless -l ... -c 'lua require("meowsoot.extras").setup()'

local Util = require("meowsoot.util")

local M = {}

-- Terminal/shell generators. Each takes a resolved `colors` table and returns a
-- single string, so a new variant is just another pass with a different palette
-- — no per-generator changes. `path` is the night (unsuffixed) filename.
M.targets = {
  { name = "ghostty", path = "extras/ghostty/meowsoot" },
  { name = "kitty", path = "extras/kitty/meowsoot.conf" },
  { name = "alacritty", path = "extras/alacritty/meowsoot.toml" },
  { name = "wezterm", path = "extras/wezterm/meowsoot.toml" },
  { name = "tmux", path = "extras/tmux/meowsoot.tmux" },
  { name = "fish", path = "extras/fish/meowsoot.fish" },
  { name = "fzf", path = "extras/fzf/meowsoot.conf" },
  { name = "zellij", path = "extras/zellij/meowsoot.kdl" },
}

-- Night stays the canonical default (unsuffixed); moon/dawn get a suffix.
M.styles = { "night", "moon", "dawn" }

-- Scheme name for a style: bare "meowsoot" for night, "meowsoot-<style>" else.
-- Doubles as the filename stem, so suffixing and naming stay in lockstep.
local function scheme_name(style)
  return style == "night" and "meowsoot" or "meowsoot-" .. style
end

-- Insert `-<style>` before the extension (or append when there is none, as with
-- the extensionless ghostty file). Night keeps the base path untouched.
local function suffixed(path, style)
  if style == "night" then
    return path
  end
  local dir, file = path:match("^(.*/)([^/]+)$")
  local stem, ext = file:match("^(.+)%.([^.]+)$")
  if stem then
    return dir .. stem .. "-" .. style .. "." .. ext
  end
  return dir .. file .. "-" .. style
end

function M.setup()
  for _, style in ipairs(M.styles) do
    -- Force a non-transparent palette for the snapshot — extras are terminal
    -- configs that ship a solid background matching each variant.
    local colors = require("meowsoot.colors").setup({
      style = style,
      transparent = false,
      styles = { sidebars = "dark", floats = "dark" },
    })
    -- WezTerm identifies a scheme by its internal name, not the filename, so it
    -- must track the variant or all three would collide on "meowsoot".
    colors.scheme_name = scheme_name(style)

    for _, target in ipairs(M.targets) do
      local mod = require("meowsoot.extras." .. target.name)
      local path = suffixed(target.path, style)
      Util.write(path, mod.generate(colors))
      io.write("[meowsoot] wrote " .. path .. "\n")
    end
  end

  -- README palette tables + per-color swatches. Documents every variant from a
  -- single source of truth, so it runs once (ignores the per-style colors).
  local palette_md = require("meowsoot.extras.palette_md")
  for _, w in ipairs(palette_md.generate()) do
    Util.write(w.path, w.content)
    io.write("[meowsoot] wrote " .. w.path .. "\n")
  end
end

return M
