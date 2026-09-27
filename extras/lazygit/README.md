# Meowsoot for Lazygit

Choose a theme that matches your terminal's Meowsoot variant. Lazygit uses the
terminal background; these files set its UI colors.

| Variant | File |
|---|---|
| Night | `meowsoot.yml` |
| Moon | `meowsoot-moon.yml` |
| Dawn | `meowsoot-dawn.yml` |

Find your Lazygit configuration directory:

```sh
lazygit --print-config-dir
```

Load your existing `config.yml` and the chosen theme, with the theme last:

```sh
lazygit --use-config-file="/path/to/config.yml,/path/to/meowsoot.nvim/extras/lazygit/meowsoot.yml"
```

Use absolute paths in your launcher or shell alias. Lazygit also accepts the
same comma-separated list through `LG_CONFIG_FILE`. Include your existing
`config.yml` in the list to keep your other settings.

Alternatively, copy the generated `theme` mapping into the `gui` section of
your configuration. Merge with any existing `gui` section to avoid duplicate
YAML keys. Restart Lazygit after changing the configuration.

The themes were checked with Lazygit 0.65.1. See Lazygit's
[configuration documentation](https://github.com/jesseduffield/lazygit/blob/v0.65.1/docs/Config.md)
for configuration merging and color attributes.

## Snacks

Snacks generates its own Lazygit theme from Neovim highlights by default. To
use these files when launching through Snacks, set this in your Snacks options:

```lua
lazygit = { configure = false },
```

Then load the theme through `LG_CONFIG_FILE` in Neovim's environment, or merge
it into Lazygit's `config.yml`. A shell alias does not configure the Snacks
launcher. Disabling `configure` also disables Snacks' automatic editor setup;
configure your editor in Lazygit separately if needed. See the
[Snacks Lazygit documentation](https://github.com/folke/snacks.nvim/blob/main/docs/lazygit.md).

## Delta

For matching diff syntax and backgrounds, install the same variant from the
[Bat](../bat/README.md) and [Delta](../delta/README.md) extras. Then add this
optional renderer to your own Lazygit configuration:

```yaml
git:
  diffRenderers:
    - command: delta --paging=never
```

The included Meowsoot Delta config selects the syntax theme and light or dark
mode. Merge this entry with any existing renderers. This example uses Lazygit
0.65.1's `git.diffRenderers`; older releases use different pager settings. See
the [diff renderer documentation](https://github.com/jesseduffield/lazygit/blob/v0.65.1/docs/Custom_DiffRenderers.md#delta).
