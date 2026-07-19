# meowsoot — Tmux theme.
# https://github.com/marekh19/meowsoot.nvim
# Auto-generated from lua/meowsoot/palette.lua. Do not edit by hand.
# Source from your tmux.conf:  source-file ~/path/to/meowsoot.tmux

set -g status-style "fg=#d9dbe8,bg=#20222c"

set -g status-left ' #[fg=#eaa4c9,bold]#S #[fg=#96d8e3]'
set -g status-right '#[fg=#96d8e3]%d/%m #[fg=#eaa4c9,bold]%H:%M '

set -g window-status-current-style "fg=#171921,bg=#eaa4c9,bold"
set -g window-status-style "fg=#a0a5ba"

set -g pane-border-style "fg=#404454"
set -g pane-active-border-style "fg=#eaa4c9"

set -g message-style "fg=#171921,bg=#dfd286"
set -g message-command-style "fg=#171921,bg=#96d8e3"

set -g mode-style "fg=#171921,bg=#353746"

set -g display-panes-colour "#404454"
set -g display-panes-active-colour "#eaa4c9"

set -g clock-mode-colour "#96d8e3"

set -g copy-mode-match-style "fg=#171921,bg=#dfd286"
set -g copy-mode-current-match-style "fg=#171921,bg=#e3b096"
