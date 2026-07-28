# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/).

## [Unreleased]

### Added

- Terminal extras for Zellij (`extras/zellij/meowsoot.kdl`) regenerated from the same palette via
  `just extras`.

## [0.4.0] — 2026-07-19

### Added

- Terminal/shell extras now cover **every palette variant**, not just night.
  Each generator (ghostty, kitty, alacritty, wezterm, tmux, fish, fzf) runs once
  per style; `moon` and `dawn` get a `-<variant>` filename suffix
  (`meowsoot-moon.conf`, …). Night stays the canonical default and keeps its
  unsuffixed filename. WezTerm's internal scheme name tracks the variant so the
  three files don't collide. (#6)

## [0.3.0] — 2026-07-19

### Added

- New **moon** variant — a cool, blue-tinted dark counterpart to `night` (#2).
  Neutrals rotate to H≈230° at calm Rosé-Pine saturation, lifted slightly above
  night's ladder for a softer moonlit bg; accents are reused verbatim, so the
  six-hue identity and every AAA contrast carry over. Warm `night` stays
  default. Use via `style = "moon"` or `:colorscheme meowsoot-moon`.

### Changed

- README refreshed: showcase screenshots now lead, added per-variant shots
  (night/moon/dawn of the same buffer), and the palette swatch tables are
  collapsed into a `<details>` block. (#8)

## [0.2.0] — 2026-07-17

### Changed

- Passive **indent guides** toned down via a dedicated `indent` palette token,
  separate from `fg_faint` (so gutter/punctuation/operators keep their weight).
  Contrast on the editor bg: night 4.61→1.90:1, dawn 2.77→1.52:1. (#4)
- **Comments** toned down via a dedicated `comment` palette token, split from
  `fg_mute` (so docs, folds, diagnostics, and statusline are unaffected).
  Contrast: night 8.10→4.44:1, dawn 4.44→3.85:1. Doc comments follow the new
  token. (#4)

## [0.1.2] — 2026-06-02

### Changed

- README palette is now copyable Markdown tables — one row per color with the
  hex as selectable text — instead of a flattened SVG image where nothing was
  selectable. Each color gets a small swatch under `static/swatches/`. Covers
  both variants' accents and neutrals. Regenerated via `just extras`.

### Removed

- `static/palette.svg` and its generator (`palette_svg.lua`), replaced by the
  Markdown-table generator (`palette_md.lua`).

## [0.1.1] — 2026-05-31

### Added

- Terminal extras for Kitty (`extras/kitty/meowsoot.conf`), Alacritty
  (`extras/alacritty/meowsoot.toml`), and WezTerm
  (`extras/wezterm/meowsoot.toml`), regenerated from the same palette via
  `just extras`.

### Changed

- All terminal extras (Ghostty, Tmux, Fish, fzf) now carry a project-URL
  header comment for consistency with the new generators.

## [0.1.0] — 2026-05-31

Initial public release.

### Added

- HSL-authored palette resolved from a single source of truth
  (`lua/meowsoot/palette.lua`), with **night** (dark) and **dawn** (light)
  variants.
- "No green in code" structural invariant — `green` is intentionally absent
  from the color table syntax-shaped group files can see; green leaks only
  through git/diff add lines, success states, the ANSI terminal slot, and
  `mini.icons` UI.
- Six-hue chromatic system anchored at 190° · 208° · 275° · 328° · 20° · 50°
  (cyan, blue, lavender, pink, peach, yellow), each with three lightness
  tiers (ANCHOR / STANDARD / QUIET).
- 22 plugin integrations auto-detected via `lazy.nvim`: telescope, fzf-lua,
  snacks, gitsigns, nvim-cmp, blink.cmp, mini.icons / mini.files /
  mini.statusline / mini.indentscope / mini.diff / mini.notify / mini.pick,
  noice, which-key, trouble, render-markdown, treesitter-context, flash,
  lazy.nvim, nvim-tree, indent-blankline.
- Bundled lualine theme that re-resolves on `:colorscheme` switches.
- Terminal extras regenerated from the same palette: Ghostty, Tmux, Fish,
  fzf.
- Compiled-highlights cache persisted to `stdpath("cache")`.
- README palette swatch (`static/palette.svg`) generated from the live
  palette so it stays in sync.

[Unreleased]: https://github.com/marekh19/meowsoot.nvim/compare/v0.4.0...HEAD
[0.4.0]: https://github.com/marekh19/meowsoot.nvim/releases/tag/v0.4.0
[0.3.0]: https://github.com/marekh19/meowsoot.nvim/releases/tag/v0.3.0
[0.2.0]: https://github.com/marekh19/meowsoot.nvim/releases/tag/v0.2.0
[0.1.2]: https://github.com/marekh19/meowsoot.nvim/releases/tag/v0.1.2
[0.1.1]: https://github.com/marekh19/meowsoot.nvim/releases/tag/v0.1.1
[0.1.0]: https://github.com/marekh19/meowsoot.nvim/releases/tag/v0.1.0
