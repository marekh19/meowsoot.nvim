# Contributing to meowsoot.nvim

Thanks for considering a contribution. This guide covers the dev loop, the
shape of the most common change (adding a plugin integration), and the one
invariant that's non-negotiable.

## Dev loop

The repo has no external build tooling beyond [`just`](https://github.com/casey/just)
and [`stylua`](https://github.com/JohnnyMorganz/StyLua). Everything runs through
the justfile:

```sh
just check        # Headless smoke-test: load the colorscheme, fail on errors
just check-fmt    # Verify all Lua is stylua-clean (CI enforces this)
just fmt          # Re-format lua/ and colors/ in place
just extras       # Regenerate extras/ and static/palette.svg from the palette
just cache-clean  # Drop the compiled-highlights cache (rarely needed)
```

CI runs `just check`, `just check-fmt`, and `just extras` on every push and PR.
The "regenerate extras" step auto-commits any diff on PRs, so palette changes
that you forgot to regenerate locally still land on the branch — but committing
the regenerated artifacts locally is cleaner.

## Adding a plugin integration

This is the most common contribution. Each plugin gets one file in
`lua/meowsoot/groups/plugins/` plus a one-line entry in the registry.

### 1. Drop a new file in `lua/meowsoot/groups/plugins/`

```lua
local M = {}

M.url = "https://github.com/owner/repo"

---@type fun(c: table, opts: table): table
function M.get(c)
  -- stylua: ignore
  return {
    SomeGroupName    = { fg = c.pink, bold = true },
    AnotherGroup     = { fg = c.cyan, bg = c.bg_float },
    LinkedGroup      = "Visual",  -- string-shorthand creates a `:hi link`
  }
end

return M
```

The `c` table is the resolved color table from `lua/meowsoot/colors.lua` — read
that file to see every available token. Useful semantic aliases include
`c.bg_sidebar`, `c.bg_float`, `c.fg_dark`, `c.fg_faint`, `c.fg_gutter`,
`c.border_highlight`, and the six chromatic accents
(`pink` / `lavender` / `cyan` / `peach` / `blue` / `yellow`).

For blending an accent into the background:

```lua
local Util = require("meowsoot.util")
local hl = { bg = Util.blend(c.pink, 0.1, c.bg_0) }
```

### 2. Register the plugin in `lua/meowsoot/groups/init.lua`

Add one line to `M.plugins`. The **key** is the plugin name as `lazy.nvim`
reports it (the GitHub repo name); the **value** is the module name under
`groups/plugins/`:

```lua
["some-plugin.nvim"] = "some_plugin",
```

Use underscores in the module name even when the plugin repo uses hyphens —
that's the existing convention (e.g. `nvim_tree`, `which_key`, `render_markdown`).

The auto-detect path picks the file up the moment `lazy.nvim` reports the
plugin loaded; users don't need to opt in.

### 3. Verify

```sh
just check && just check-fmt
```

`just check` walks every group value, so a typo like `c.nonexistent` errors
loudly. If you want to eyeball the result without installing the plugin
locally, `:highlight SomeGroupName` should resolve to a hex (not `cleared`).

## The "no green in code" invariant

Most colorschemes use green for strings or comments. meowsoot deliberately does
not — strings are yellow, types are lavender, functions are pink, keywords are
cyan. This invariant is **structural**, not stylistic.

The enforcement: `green` is intentionally not a top-level key on the `c` table
that group files can see. Open `lua/meowsoot/colors.lua` and confirm — there's
no `c.green` line. Code-shaped group files (`groups/base.lua` syntax section,
`groups/treesitter.lua`, `groups/semantic_tokens.lua`, `groups/kinds.lua`, all
plugin files) **cannot reach green**.

The only legitimate green leaks live behind semantic aliases:

- `c.git.add` — VCS add lines (lualine, gitsigns)
- `c.diff.add` — diff hunk add lines
- `c.ok` — success diagnostics
- `c.terminal.green`, `c.terminal.green_br` — ANSI green slots
- `mini.icons` UI category (terminal-emulator-style file-type icons)

If a plugin integration genuinely needs a "success" color (a check mark, a
healthy status), use `c.ok` — never reintroduce raw `green`. New plugin files
that reach for green will fail review.

## Tuning the palette

The palette is authored in HSL (`{h, s, l}`) for ergonomic tuning on the color
wheel and resolved to hex at load time. Edit `lua/meowsoot/palette.lua`.

After any palette change, regenerate the downstream artifacts:

```sh
just extras
```

This rewrites the files under `extras` (e.g. `extras/ghostty/meowsoot`, `extras/tmux/meowsoot.tmux`,
`extras/fish/meowsoot.fish`, `extras/fzf/meowsoot.conf`, and
`static/palette.svg`) from the live palette. Commit those alongside the palette
edit so a downstream consumer pulling main never sees a partial update.

## PR expectations

- `just check` and `just check-fmt` exit 0
- If you touched `palette.lua`, the regenerated `extras/` and
  `static/palette.svg` are committed
- New plugin integrations don't introduce raw `green` into syntax-shaped groups
- One logical change per PR — palette tuning, a new plugin integration, and a
  README rewrite are three separate PRs
