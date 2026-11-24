#!/bin/bash
# Point macOS apps at the settings kept in this repo. Safe to re-run.

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

failed=0

echo "Linking VS Code settings"
vscode_user="$HOME/Library/Application Support/Code/User"
link_file "$DOTFILES/vscode/settings.json" "$vscode_user/settings.json" || failed=1
link_file "$DOTFILES/vscode/keybindings.json" "$vscode_user/keybindings.json" || failed=1

# iTerm2 reads com.googlecode.iterm2.plist from a custom folder when told to.
echo "Pointing iTerm2 at the settings in $DOTFILES"
if [ "$(defaults read com.googlecode.iterm2 PrefsCustomFolder 2>/dev/null)" = "$DOTFILES" ] &&
    [ "$(defaults read com.googlecode.iterm2 LoadPrefsFromCustomFolder 2>/dev/null)" = "1" ]; then
    echo "  ok       iTerm2 already loads settings from $DOTFILES"
else
    defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$DOTFILES" || failed=1
    defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true || failed=1
    echo "  set      iTerm2 will load settings from $DOTFILES"
    if pgrep -x iTerm2 >/dev/null 2>&1; then
        echo "  note     iTerm2 is running; quit and reopen it to load them"
    fi
fi

exit $failed
