#!/bin/sh

if test ! $(which brew); then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing homebrew packages..."

# cli tools
brew install ack
brew install tree
brew install wget

# development tools
brew install git
brew install hub
brew install macvim --override-system-vim
brew install reattach-to-user-namespace
brew install tmux
brew install zsh
brew install nvm

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
  dosbox\
  dropbox\
  evernote\
  firefox\
  google-chrome\
  handbrake\
  iterm2\
  kindle\
  microsoft-office\
  netbeans-java-se\
  omnifocus\
  postman\
  sketch\
  skype\
  slack\
  spotify\
  steam\
  visual-studio-code

brew cask cleanup

