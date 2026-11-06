# Meowsoot for Obsidian

These CSS snippets recolor the [Minimal](https://github.com/kepano/obsidian-minimal)
theme for Obsidian. They set Minimal's color variables, so they do not work
with Obsidian's default theme or with other themes.

| Variant | File | Mode |
|---|---|---|
| Night | `meowsoot.css` | Dark |
| Moon | `meowsoot-moon.css` | Dark |
| Dawn | `meowsoot-dawn.css` | Light |

## Requirements

- **Minimal theme.** Install it in **Settings > Appearance > Themes > Manage**,
  then select it.
- **Minimal Theme Settings plugin (optional).** Install it from
  **Settings > Community plugins > Browse**. You need it only to choose
  Minimal's color schemes or to turn on colorful headings.

## Setup

1. Copy the snippets you want into your vault's snippet folder:

   ```sh
   mkdir -p "/path/to/vault/.obsidian/snippets"
   cp extras/obsidian/meowsoot.css extras/obsidian/meowsoot-dawn.css \
     "/path/to/vault/.obsidian/snippets/"
   ```

2. In Obsidian, open **Settings > Appearance > CSS snippets**. Select the
   reload icon, then turn on the snippets.
3. Turn on one dark snippet only: Night or Moon. Both replace the same dark
   scheme, so the one Obsidian loads last wins. Dawn changes only light mode,
   so you can turn it on together with Night or Moon.
4. If you use Minimal Theme Settings, set **Light mode color scheme** and
   **Dark mode color scheme** to **Default**.

To switch between Dawn and a dark variant with your operating system, set
**Settings > Appearance > Base color scheme** to **Adapt to system**.

## How it works

Each snippet replaces Minimal's **Default** color scheme for one mode. If you
select another scheme in Minimal Theme Settings, that scheme takes precedence
for most colors, but the snippet still sets code block, link, list marker, and
heading colors. Turn the snippet off when you use another scheme.

The snippets also set Obsidian's code block colors. Obsidian's defaults color
strings green; these snippets keep green out of code, as in Neovim. When you
turn on **Colorful headings** in Minimal Theme Settings, headings use the
Meowsoot rainbow instead of Minimal's colors, which include green.

The snippets were written for Minimal 9.1 and Minimal Theme Settings 9.0. See
Minimal's [color scheme documentation](https://github.com/kepano/obsidian-minimal/blob/HEAD/docs/Features/Color%20schemes.md)
for the variables it supports.

## Updating

The snippets are generated from `lua/meowsoot/palette.lua`. After you pull a
new version, copy the files into your vault again. Changes made by hand are
overwritten on regeneration.
