#!/bin/bash
# Make sure Homebrew is installed and usable. Packages live in brews.sh.

source "$(dirname "${BASH_SOURCE[0]}")/lib.sh"

if ! load_brew; then
    echo "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || exit 1
    load_brew || { echo "Homebrew installed but brew is not on PATH"; exit 1; }
fi
echo "Homebrew: $(command -v brew)"

# Accept the Xcode license, but only when full Xcode is the active developer
# directory (the Command Line Tools alone have no license step) and only when
# it hasn't been accepted yet, so re-runs don't ask for sudo.
if [[ "$(xcode-select -p 2>/dev/null)" == *Xcode*.app* ]]; then
    if ! xcodebuild -license check >/dev/null 2>&1; then
        echo "Accepting Xcode license (needs sudo)"
        sudo xcodebuild -license accept || echo "Could not accept the Xcode license; continuing"
    fi
fi
