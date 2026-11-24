#!/bin/bash
# Symlink dotfiles into $HOME. Safe to re-run.

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

failed=0

echo "Linking *.symlink files into $HOME"
# The oh-my-zsh submodule and .git are pruned so nothing inside them is linked.
while IFS= read -r -d '' file; do
    target="$HOME/.$(basename "$file" .symlink)"
    link_file "$file" "$target" || failed=1
done < <(find -H "$DOTFILES" -maxdepth 3 \
    \( -path "$DOTFILES/zsh" -o -path "$DOTFILES/.git" \) -prune \
    -o -name '*.symlink' -print0)

echo "Linking ~/.config entries"
link_file "$DOTFILES/.config/nvim" "$HOME/.config/nvim" || failed=1

exit $failed
