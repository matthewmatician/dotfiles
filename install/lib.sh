#!/bin/bash
# Shared helpers for the install scripts. Source this file; don't execute it.

# Repo root, derived from this file's location so the scripts work from any
# directory and wherever the repo is cloned.
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# link_file SRC DST
# Symlink DST -> SRC. Safe to re-run: an existing correct link is left alone,
# and anything else already at DST is moved aside to DST.backup.<timestamp>.
link_file() {
    local src="$1" dst="$2"

    if [ ! -e "$src" ]; then
        echo "  missing source, skipping: $src"
        return 1
    fi

    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        echo "  ok       $dst"
        return 0
    fi

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        local backup
        backup="$dst.backup.$(date +%Y%m%d%H%M%S)"
        echo "  backup   $dst -> $backup"
        mv "$dst" "$backup" || return 1
    fi

    mkdir -p "$(dirname "$dst")" || return 1
    ln -s "$src" "$dst" || return 1
    echo "  linked   $dst -> $src"
}

# Put Homebrew on PATH for this process. Needed right after a fresh install,
# when brew exists on disk but the shell doesn't know about it yet.
load_brew() {
    local candidate
    if ! command -v brew >/dev/null 2>&1; then
        for candidate in /opt/homebrew/bin/brew /usr/local/bin/brew; do
            if [ -x "$candidate" ]; then
                eval "$("$candidate" shellenv)"
                break
            fi
        done
    fi
    command -v brew >/dev/null 2>&1
}

# copy_app APP DEST_DIR
# Copy an app bundle into DEST_DIR. On Macs where this account can't write to
# /Applications (a non-admin account on a managed machine), the copy is done
# with sudo, which asks for a password just as Homebrew does for its casks, and
# the app is then handed to this user so it can still update itself.
copy_app() {
    local app="$1" dest="$2" target
    target="$dest/$(basename "$app")"
    if [ -w "$dest" ]; then
        ditto "$app" "$target" && return 0
        rm -rf "$target"
        return 1
    fi
    echo "  sudo     $dest is not writable by $(id -un); your password is needed to copy into it"
    if sudo ditto "$app" "$target" && sudo chown -R "$(id -un):$(id -gn)" "$target"; then
        return 0
    fi
    sudo rm -rf "$target"
    return 1
}

# install_bettertouchtool [DEST_DIR]
# Download BetterTouchTool from its developer and put it in DEST_DIR (default
# /Applications). Installing it through Homebrew isn't supported, so
# install/brews.sh offers it as a direct download instead of a cask. The
# download is only kept if it is validly signed.
BTT_URL="https://folivora.ai/releases/BetterTouchTool.zip"
install_bettertouchtool() {
    local dest="${1:-/Applications}" tmp status=0
    tmp="$(mktemp -d)" || return 1
    if ! curl -fL --progress-bar -o "$tmp/btt.zip" "$BTT_URL"; then
        echo "  failed   could not download $BTT_URL"
        status=1
    elif ! ditto -x -k "$tmp/btt.zip" "$tmp/unpacked" || [ ! -d "$tmp/unpacked/BetterTouchTool.app" ]; then
        echo "  failed   the download did not contain BetterTouchTool.app"
        status=1
    elif ! codesign --verify --deep --strict "$tmp/unpacked/BetterTouchTool.app" 2>/dev/null ||
        ! spctl --assess --type execute "$tmp/unpacked/BetterTouchTool.app" 2>/dev/null; then
        echo "  failed   the downloaded BetterTouchTool.app is not validly signed"
        status=1
    elif ! copy_app "$tmp/unpacked/BetterTouchTool.app" "$dest"; then
        echo "  failed   could not copy BetterTouchTool.app to $dest"
        status=1
    else
        echo "  installed $dest/BetterTouchTool.app"
    fi
    rm -rf "$tmp"
    return $status
}

# checkbox_menu TITLE
# Interactive checkbox list. Reads the global array menu_labels and reads and
# updates the global array menu_checked (1 or 0 per item). Returns 0 when the
# selection is confirmed with enter, 1 when cancelled with q.
checkbox_menu() {
    local title="$1" count=${#menu_labels[@]}
    local cursor=0 top=0 drawn=0 result=0
    local rows key rest i mark pointer selected

    # Show as many rows as fit, leaving room for the title and help lines;
    # longer lists scroll.
    # (stty reads the size from stdin, which is the terminal here; tput inside
    # $(...) can't see the terminal and would always report the default.)
    rows=$(stty size 2>/dev/null | cut -d' ' -f1)
    rows=$(( ${rows:-24} - 4 ))
    if [ "$rows" -gt "$count" ]; then rows=$count; fi
    if [ "$rows" -lt 1 ]; then rows=1; fi

    tput civis 2>/dev/null
    trap 'tput cnorm 2>/dev/null; echo; exit 130' INT

    while true; do
        if [ "$cursor" -lt "$top" ]; then top=$cursor; fi
        if [ "$cursor" -ge $((top + rows)) ]; then top=$((cursor - rows + 1)); fi

        selected=0
        for i in "${menu_checked[@]}"; do
            if [ "$i" = 1 ]; then selected=$((selected + 1)); fi
        done

        # Redraw in place: move back up over the previous frame.
        if [ "$drawn" -eq 1 ]; then printf '\033[%dA' $((rows + 2)); fi
        drawn=1
        printf '\033[2K%s (%d of %d selected)\n' "$title" "$selected" "$count"
        for ((i = top; i < top + rows; i++)); do
            mark=' '
            pointer=' '
            if [ "${menu_checked[$i]}" = 1 ]; then mark='x'; fi
            if [ "$i" -eq "$cursor" ]; then pointer='>'; fi
            printf '\033[2K%s [%s] %s\n' "$pointer" "$mark" "${menu_labels[$i]}"
        done
        printf '\033[2K  up/down: move  space: toggle  a: all  n: none  enter: install  q: cancel\n'

        if ! IFS= read -rsn1 key; then
            result=1
            break
        fi
        if [ "$key" = $'\033' ]; then
            # Arrow keys arrive as ESC [ A / ESC [ B (or ESC O A / ESC O B).
            IFS= read -rsn2 -t 1 rest
            case "$rest" in
                '[A' | 'OA') key=k ;;
                '[B' | 'OB') key=j ;;
                *) key=ignore ;;
            esac
        fi
        case "$key" in
            k) if [ "$cursor" -gt 0 ]; then cursor=$((cursor - 1)); fi ;;
            j) if [ "$cursor" -lt $((count - 1)) ]; then cursor=$((cursor + 1)); fi ;;
            ' ')
                if [ "${menu_checked[$cursor]}" = 1 ]; then
                    menu_checked[$cursor]=0
                else
                    menu_checked[$cursor]=1
                fi
                ;;
            a) for ((i = 0; i < count; i++)); do menu_checked[$i]=1; done ;;
            n) for ((i = 0; i < count; i++)); do menu_checked[$i]=0; done ;;
            '') break ;;
            q)
                result=1
                break
                ;;
        esac
    done

    trap - INT
    tput cnorm 2>/dev/null
    return $result
}
