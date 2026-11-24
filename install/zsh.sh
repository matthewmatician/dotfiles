#!/bin/bash
# Wire the custom theme and plugin into oh-my-zsh and make zsh the login shell.

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

custom="$DOTFILES/zsh/custom"
if [ ! -d "$custom" ]; then
    echo "$custom is missing; the oh-my-zsh submodule isn't checked out"
    exit 1
fi

failed=0
link_file "$DOTFILES/ordealz.zsh-theme" "$custom/ordealz.zsh-theme" || failed=1
link_file "$DOTFILES/man-colors.plugin.zsh" "$custom/plugins/man-colors/man-colors.plugin.zsh" || failed=1

# Only change the login shell when it isn't zsh already (chsh asks for a password).
if [ "$(uname)" = "Darwin" ]; then
    current_shell="$(dscl . -read "/Users/$USER" UserShell 2>/dev/null | awk '{print $2}')"
else
    current_shell="$(getent passwd "$USER" 2>/dev/null | cut -d: -f7)"
fi
current_shell="${current_shell:-$SHELL}"

if [ "$(basename "$current_shell")" = "zsh" ]; then
    echo "  ok       login shell is $current_shell"
else
    zsh_path="$(command -v zsh)"
    if [ -z "$zsh_path" ]; then
        echo "zsh is not installed"
        failed=1
    elif ! grep -qx "$zsh_path" /etc/shells; then
        echo "$zsh_path is not in /etc/shells; add it, then run: chsh -s $zsh_path"
        failed=1
    else
        chsh -s "$zsh_path" || failed=1
    fi
fi

exit $failed
