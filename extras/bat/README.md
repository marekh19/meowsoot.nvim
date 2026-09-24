# Meowsoot for Bat

Choose one theme and copy it into Bat's theme directory:

```sh
mkdir -p "$(bat --config-dir)/themes"
cp meowsoot.tmTheme "$(bat --config-dir)/themes/"
bat cache --build
```

Available themes:

| Variant | File | Theme name |
|---|---|---|
| Night | `meowsoot.tmTheme` | `meowsoot` |
| Moon | `meowsoot-moon.tmTheme` | `meowsoot-moon` |
| Dawn | `meowsoot-dawn.tmTheme` | `meowsoot-dawn` |

Confirm the installation with `bat --list-themes`. Select a theme with
`--theme="meowsoot"` in `$(bat --config-file)` or set `BAT_THEME=meowsoot`.

Delta reads custom syntax themes from Bat's compiled cache. The same installed
theme is therefore available as `delta --syntax-theme=meowsoot`.
