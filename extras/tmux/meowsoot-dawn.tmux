# meowsoot — Tmux theme.
# https://github.com/marekh19/meowsoot.nvim
# Auto-generated from lua/meowsoot/palette.lua. Do not edit by hand.
# Source from your tmux.conf:  source-file ~/path/to/meowsoot.tmux

set -g status-style "fg=#3c312a,bg=#e6e0db"

set -g status-left ' #[fg=#911256,bold]#S #[fg=#187a8b]'
set -g status-right '#[fg=#187a8b]%d/%m #[fg=#911256,bold]%H:%M '

set -g window-status-current-style "fg=#f9f6f1,bg=#911256,bold"
set -g window-status-style "fg=#7e7063"

set -g pane-border-style "fg=#b0998d"
set -g pane-active-border-style "fg=#911256"

set -g message-style "fg=#f9f6f1,bg=#917112"
set -g message-command-style "fg=#f9f6f1,bg=#187a8b"

set -g mode-style "fg=#f9f6f1,bg=#d7cac1"

set -g display-panes-colour "#b0998d"
set -g display-panes-active-colour "#911256"

set -g clock-mode-colour "#187a8b"

set -g copy-mode-match-style "fg=#f9f6f1,bg=#917112"
set -g copy-mode-current-match-style "fg=#f9f6f1,bg=#a34414"
