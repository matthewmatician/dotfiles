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

# BetterTouchTool: the app itself is offered in the install/brews.sh checklist
# (downloaded from folivora.ai), the licence comes from Dropbox (it must not
# live in this public repo), and the shortcuts come from BetterTouchTool's own
# iCloud sync.
echo "Setting up BetterTouchTool"
btt_support="$HOME/Library/Application Support/BetterTouchTool"
if [ ! -d "/Applications/BetterTouchTool.app" ]; then
    echo "  skip     BetterTouchTool is not installed"
elif [ -e "$btt_support/bettertouchtool.bttlicense" ]; then
    echo "  ok       BetterTouchTool is already registered"
else
    btt_license=""
    for candidate in "$HOME/Dropbox/"*.bettertouchtool; do
        if [ -e "$candidate" ]; then
            btt_license="$candidate"
            break
        fi
    done
    if [ -z "$btt_license" ]; then
        echo "  note     no *.bettertouchtool licence in ~/Dropbox yet; once Dropbox"
        echo "           has synced, re-run this script or double-click the licence"
    elif open -a BetterTouchTool "$btt_license"; then
        echo "  opened   $btt_license in BetterTouchTool to register it"
    else
        echo "  failed   could not open $btt_license in BetterTouchTool"
        failed=1
    fi
fi
if [ -d "/Applications/BetterTouchTool.app" ] &&
    [ "$(defaults read com.hegenberg.BetterTouchTool BTTDropboxSyncActive 2>/dev/null)" != "1" ]; then
    echo "  note     to bring your shortcuts over, turn on sync in BetterTouchTool's"
    echo "           settings and choose iCloud (needs iCloud Drive on the same Apple ID)"
fi

exit $failed
