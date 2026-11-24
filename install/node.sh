#!/bin/bash
# Install the current LTS Node with fnm (fnm itself comes from brews.sh). Once
# a default Node exists this does nothing; to move to a newer LTS, run
# `fnm install --lts && fnm default lts-latest`.

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

load_brew
if ! command -v fnm >/dev/null 2>&1; then
    echo "fnm is not installed (it comes from install/brews.sh); skipping Node"
    exit 0
fi

eval "$(fnm env)"
if version="$(fnm exec --using=default node --version 2>/dev/null)"; then
    echo "  ok       Node $version"
    exit 0
fi
fnm install --lts || exit 1
fnm default lts-latest || exit 1
echo "Node: $(fnm exec --using=default node --version)"
