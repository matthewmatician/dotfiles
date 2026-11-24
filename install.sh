#!/bin/bash
# Set up a machine from this repo. Safe to re-run: each step skips work that is
# already done, and a failing step is reported at the end instead of stopping
# the steps after it.
#
# Usage: ./install.sh [--yes]
#   --yes  install every Homebrew package without showing the checklist

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES" || exit 1

failed_steps=()

# step "Description" command [args...]
step() {
    local name="$1"
    shift
    echo
    echo "==> $name"
    if ! "$@"; then
        echo "!!  FAILED: $name"
        failed_steps+=("$name")
    fi
}

echo "Installing dotfiles from $DOTFILES"

step "Initializing submodule(s)" git submodule update --init --recursive
step "Linking dotfiles" bash install/link.sh

if [ "$(uname)" == "Darwin" ]; then
    step "Installing Homebrew" bash install/brew.sh
    step "Brewing all the things" bash install/brews.sh "$@"
    step "Installing node (from fnm)" bash install/node.sh
    step "Setting up command-line tools" bash install/tools.sh
    step "Configuring apps" bash install/apps.sh
    step "Updating macOS settings" sh installosx.sh
fi

step "Configuring zsh" bash install/zsh.sh

echo
if [ ${#failed_steps[@]} -gt 0 ]; then
    echo "Finished with failures in:"
    printf '  - %s\n' "${failed_steps[@]}"
    echo "Fix the cause and re-run ./install.sh; completed work is skipped."
    exit 1
fi

echo "Done. Don't forget to run install/prefs.sh after dropbox is finished."
