# Meowsoot for Delta

Delta uses the Meowsoot Bat theme for syntax highlighting. Install the matching
file from `extras/bat/` and run `bat cache --build` before using these configs.

Include one variant from your Git configuration:

```gitconfig
[include]
    path = /path/to/meowsoot.nvim/extras/delta/meowsoot.gitconfig
```

Available configs:

| Variant | Config | Required Bat theme |
|---|---|---|
| Night | `meowsoot.gitconfig` | `meowsoot` |
| Moon | `meowsoot-moon.gitconfig` | `meowsoot-moon` |
| Dawn | `meowsoot-dawn.gitconfig` | `meowsoot-dawn` |

Each config selects the required syntax theme and adds matching diff
backgrounds, line-number colors, and decorations. Dawn explicitly enables
Delta's light mode. Night and Moon enable dark mode.
