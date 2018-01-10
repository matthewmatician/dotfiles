#!/bin/sh

if test ! $(which brew); then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# accept xcode license agreement
sudo xcodebuild -license accept

echo "Installing homebrew packages..."

# cli tools
brew install ack
brew install tree
brew install wget

# development tools
brew install git
brew install hub
brew install git-flow
brew install heroku
brew install reattach-to-user-namespace
brew install tmux
brew install zsh

#brew install highlight
#brew install z
#brew install markdown

# install neovim
brew tap neovim/neovim
brew install --HEAD neovim

#/Applications
brew tap caskroom/cask
brew cask install\
  atom\
  bettertouchtool\
  dropbox\
  evernote\
  firefox\
  google-chrome\
  handbrake\
  iterm2\
  java\
  kindle\
  microsoft-office\
  netbeans-java-se\
  omnifocus\
  postman\
  sketch\
  skype\
  skype-for-business\
  slack\
  spotify\
  steam\
  visual-studio-code

brew cask cleanup

# Fonts
brew tap caskroom/fonts
brew cask install\
  font-hack\
  font-open-sans\
  font-open-sans-condensed\
  font-roboto\
  font-roboto-condensed

brew cask cleanup

