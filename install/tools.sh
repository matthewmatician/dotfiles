#!/bin/bash
# Set up command-line tools that aren't plain Homebrew packages. Safe to
# re-run. Each tool is skipped, without failing, when the thing it builds on
# wasn't installed (for example because it was unticked in the checklist).

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

load_brew
failed=0

# fzf key bindings (Ctrl-R, Ctrl-T) and completion. fzf's own installer writes
# ~/.fzf.zsh, which zshrc sources.
if [ -f "$HOME/.fzf.zsh" ]; then
    echo "  ok       fzf shell integration"
elif command -v brew >/dev/null 2>&1 && [ -x "$(brew --prefix)/opt/fzf/install" ]; then
    echo "Setting up fzf shell integration"
    "$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish || failed=1
else
    echo "  skip     fzf shell integration (fzf is not installed)"
fi

# yarn, installed into the default Node from fnm.
if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env)"
fi
if ! command -v npm >/dev/null 2>&1; then
    echo "  skip     yarn (Node is not installed)"
elif command -v yarn >/dev/null 2>&1; then
    echo "  ok       yarn"
else
    echo "Installing yarn"
    npm install -g yarn || failed=1
fi

exit $failed
