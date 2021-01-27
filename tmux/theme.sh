
icon="✪"
#### COLORs
color_accent=colour125
color_active=colour240
color_inactive=colour235
color_dark=colour233
color_light=colour243
color_white=colour255
color_music=colour75

tm_spotify="#[fg=$color_music]#(osascript ~/dotfiles/applescripts/spotify.scpt)"
tm_itunes="#[fg=$color_music]#(osascript ~/dotfiles/applescripts/itunes.scpt)"
tm_rdio="#[fg=$color_music]#(osascript ~/dotfiles/applescripts/rdio.scpt)"

# Status update interval
set -g status-interval 1

# Basic status bar colors
set -g status-style "fg=$color_white,bg=$color_inactive"

# Left side of status bar
set -g status-left-style "bg=$color_inactive,fg=$color_light"
set -g status-left "#[fg=$color_dark,bg=$color_accent,bold] $icon #S #[fg=$color_accent,bg=$color_active,nobold]#[fg=$color_dark,bg=$color_active] #{session_width}x#{session_height}  #[fg=$color_active,bg=$color_inactive]#[fg=$color_active,bg=$color_inactive] "
set -g status-left-length 40

# Right side of status bar
set -g status-right-style "bg=$color_dark,fg=$color_light"
set -g status-right "#[fg=$color_active,bg=$color_inactive] $tm_itunes$tm_spotify #[fg=$color_active,bg=$color_inactive]#[fg=$color_dark,bg=$color_active] #{pane_current_command} #[fg=$color_accent,bg=$color_active]#[fg=$color_dark,bg=$color_accent,bold] #{continuum_status} "
set -g status-right-length 150

# Window status
set -g window-status-format "  #[fg=$color_light]#W  "
set -g window-status-current-format "#[fg=$color_inactive,bg=black]#[fg=$color_accent,bold] #W #[fg=$color_inactive,bg=black,nobold]"

# Current window status
set -g window-status-current-style "bg=$color_accent,fg=$color_inactive"

# Window with activity status
set -g window-status-activity-style "bg=$color_music,fg=$color_dark" #Colors are flipped due to a bug in tmux

# Window separator
set -g window-status-separator ""

# Window status alignment
set -g status-justify left

# Pane border
set -g pane-border-style "bg=default,fg=$color_active"

# Active pane border
set -g pane-active-border-style "bg=default,fg=$color_accent"

# Pane number indicator
set -g display-panes-colour $color_dark
set -g display-panes-active-colour $color_light

# Clock mode
set -g clock-mode-colour $color_accent
set -g clock-mode-style 24

# Message
set -g message-style "bg=$color_accent,fg=black"

# Command message
set -g message-command-style "bg=$color_dark,fg=black"

# Mode
set -g mode-style "bg=$color_accent,fg=$color_white"

