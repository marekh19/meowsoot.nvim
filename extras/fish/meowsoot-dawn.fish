# meowsoot — Fish shell theme.
# https://github.com/marekh19/meowsoot.nvim
# Auto-generated from lua/meowsoot/palette.lua. Do not edit by hand.
# Install:  cp extras/fish/meowsoot.fish ~/.config/fish/conf.d/

# Palette
set -l foreground 3c312a
set -l selection  d7cac1
set -l comment    7e7063
set -l red        a11717
set -l green      1f7a3d
set -l yellow     917112
set -l peach      a34414
set -l cyan       187a8b
set -l cyan_br    116374
set -l pink       911256
set -l lavender   6a2c96

# Syntax Highlighting Colors
set -g fish_color_normal         $foreground
set -g fish_color_command        $cyan
set -g fish_color_keyword        $lavender
set -g fish_color_quote          $yellow
set -g fish_color_redirection    $cyan
set -g fish_color_end            $foreground
set -g fish_color_error          $red
set -g fish_color_param          $foreground
set -g fish_color_option         $peach
set -g fish_color_comment        $comment
set -g fish_color_selection      --background=$selection
set -g fish_color_operator       $cyan
set -g fish_color_escape         $peach
set -g fish_color_autosuggestion $comment
set -g fish_color_cwd            $cyan
set -g fish_color_cwd_root       $red
set -g fish_color_valid_path     --underline
set -g fish_color_history_current --bold
set -g fish_color_search_match   --background=$selection
set -g fish_color_match          $cyan_br
set -g fish_color_cancel         $red

# Completion Pager Colors
set -g fish_pager_color_progress             $comment
set -g fish_pager_color_prefix               $cyan
set -g fish_pager_color_completion           $foreground
set -g fish_pager_color_description          $comment
set -g fish_pager_color_selected_background  --background=$selection
set -g fish_pager_color_selected_completion  $foreground
set -g fish_pager_color_selected_description $comment
set -g fish_pager_color_selected_prefix      $cyan
