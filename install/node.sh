#!/bin/bash
# Install the current LTS Node with fnm (fnm itself comes from brews.sh).

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

load_brew
if ! command -v fnm >/dev/null 2>&1; then
    echo "fnm is not installed (it comes from install/brews.sh); skipping Node"
    exit 0
fi

eval "$(fnm env)"
fnm install --lts || exit 1
fnm default lts-latest || exit 1
echo "Node: $(fnm exec --using=default node --version)"
