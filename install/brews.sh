#!/bin/bash
# Install Homebrew formulae, apps and fonts. Shows a checklist of everything
# not yet installed so you can choose; pass --yes to install it all unprompted.
# Safe to re-run: anything already installed is skipped, and one failing
# package doesn't stop the rest.

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

load_brew || { echo "Homebrew not found; run install/brew.sh first"; exit 1; }

# --yes (or -y) installs everything without showing the checklist.
assume_yes=0
for arg in "$@"; do
    case "$arg" in
        -y | --yes) assume_yes=1 ;;
    esac
done

# cli tools
formulae=(
    fnm
    python
    neovim
    bat
    fzf
    ack
    tree
    wget
    ripgrep
    go
    rename
    git-lfs
    gh
    # git
    # hub
    # git-flow
    # heroku/brew/heroku
    # reattach-to-user-namespace
    # tmux
    # zsh
    # highlight
    # z
    # markdown
)

# /Applications
casks=(
    dropbox
    bettertouchtool
    firefox
    google-chrome
    handbrake
    iterm2
    # microsoft-office
    # omnifocus
    slack
    spotify
    steam
    visual-studio-code
    jordanbaird-ice             # Ice, menu bar manager
    # dozer                     # no longer in Homebrew
    # microsoft-teams
    figma
    # atom
    # evernote
    # java
    # kindle
    # postman
    # sketch
    # skype
    # skype-for-business

    # Fonts (homebrew/cask-fonts was merged into the main cask repo; no tap needed)
    font-hack
    font-open-sans
    # font-open-sans-condensed  # no longer in Homebrew
    font-roboto
    font-roboto-condensed
    font-zilla-slab
    font-consolas-for-powerline
    # font-consolas             # no longer in Homebrew
    font-fira-code
)

# existing_app CASK
# Succeeds, printing the path, when an app this cask would install is already
# in /Applications (e.g. installed by hand). Casks with no .app, like fonts,
# never match. App names come from the cask's own metadata.
existing_app() {
    local app
    while IFS= read -r app; do
        if [ -n "$app" ] && [ -e "/Applications/$app" ]; then
            echo "/Applications/$app"
            return 0
        fi
    done < <(brew info --cask --json=v2 "$1" 2>/dev/null | grep -o '"[^"/]*\.app"' | tr -d '"' | sort -u)
    return 1
}

installed_formulae="$(brew list --formula -1 2>/dev/null)"
installed_casks="$(brew list --cask -1 2>/dev/null)"

# Work out what still needs installing. Each pending package is recorded in
# three parallel arrays: its name, its kind, and whether it is selected.
pending_names=()
pending_kinds=()
menu_labels=()
menu_checked=()

add_pending() {
    pending_names+=("$1")
    pending_kinds+=("$2")
    menu_labels+=("$(printf '%-30s %s' "$1" "$2")")
    menu_checked+=(1)
}

echo "Checking what is already installed..."
for name in "${formulae[@]}"; do
    if grep -qx "$name" <<<"$installed_formulae"; then
        echo "  ok       $name"
    else
        add_pending "$name" "cli tool"
    fi
done

for name in "${casks[@]}"; do
    if grep -qx "$name" <<<"$installed_casks"; then
        echo "  ok       $name"
    elif app="$(existing_app "$name")"; then
        echo "  skip     $name ($app already exists, not managed by Homebrew)"
    elif [[ "$name" == font-* ]]; then
        add_pending "$name" "font"
    else
        add_pending "$name" "app"
    fi
done

if [ ${#pending_names[@]} -eq 0 ]; then
    echo "Nothing left to install."
    exit 0
fi

# Ask which of the pending packages to install. Without a terminal, or with
# --yes, everything pending is installed.
if [ "$assume_yes" -eq 0 ] && [ -t 0 ] && [ -t 1 ]; then
    echo
    if ! checkbox_menu "Choose what to install"; then
        echo "Cancelled; nothing installed."
        exit 0
    fi
fi

failures=()
echo
for ((i = 0; i < ${#pending_names[@]}; i++)); do
    name="${pending_names[$i]}"
    if [ "${menu_checked[$i]}" != 1 ]; then
        echo "  not selected  $name"
        continue
    fi
    echo "Installing $name..."
    if [ "${pending_kinds[$i]}" = "cli tool" ]; then
        brew install "$name" || failures+=("$name")
    else
        brew install --cask "$name" || failures+=("$name (cask)")
    fi
done

if [ ${#failures[@]} -gt 0 ]; then
    echo
    echo "These packages failed to install:"
    printf '  %s\n' "${failures[@]}"
    exit 1
fi
