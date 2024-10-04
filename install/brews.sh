#!/bin/sh

# accept xcode license agreement
sudo xcodebuild -license accept

echo "Installing homebrew packages..."

# cli tools
brew install fnm
brew install python
brew install neovim
brew install bat
brew install fzf
brew install ack
brew install tree
brew install wget
brew install fnm
brew install ripgrep
brew install golang
brew install rename

# brew install git
# brew install hub
# brew install git-flow
# brew install heroku/brew/heroku
# brew install reattach-to-user-namespace
# brew install tmux
# brew install zsh
# brew install highlight
#brew install z
#brew install markdown

#/Applications
brew tap homebrew/cask
brew install dropbox --cask
#brew install bettertouchtool --cask
brew install firefox --cask
brew install google-chrome --cask
brew install handbrake --cask
brew install iterm2 --cask
#brew install microsoft-office --cask
#brew install omnifocus --cask
brew install slack --cask
brew install spotify --cask
brew install steam --cask
brew install visual-studio-code --cask
brew install dozer --cask
#brew install microsoft-teams --cask
brew install figma --cask

# brew install atom --cask
# brew install evernote --cask
# brew install java --cask
# brew install kindle --cask
# brew install postman --cask
# brew install sketch --cask
# brew install skype --cask
# brew install skype-for-business --cask

# Fonts
brew tap homebrew/cask-fonts
brew install font-hack --cask
brew install font-open-sans --cask
brew install font-open-sans-condensed --cask
brew install font-roboto --cask
brew install font-roboto-condensed --cask
brew install font-zilla-slab --cask
brew install font-consolas-for-powerline --cask
brew install font-consolas --cask
brew install font-fira-code --cask


