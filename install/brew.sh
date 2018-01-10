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
brew install vim
brew link vim
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
brew cask install dropbox
brew cask install atom
brew cask install bettertouchtool
brew cask install evernote
brew cask install firefox
brew cask install google-chrome
brew cask install handbrake
brew cask install iterm2
brew cask install java
brew cask install kindle
brew cask install microsoft-office
brew cask install netbeans-java-se
brew cask install omnifocus
brew cask install postman
brew cask install sketch
brew cask install skype
brew cask install skype-for-business
brew cask install slack
brew cask install spotify
brew cask install steam
brew cask install visual-studio-code

brew cask cleanup

# Fonts
brew tap caskroom/fonts
brew cask install font-hack
brew cask install font-open-sans
brew cask install font-open-sans-condensed
brew cask install font-roboto
brew cask install font-roboto-condensed
brew cask install font-zilla-slab
brew cask install font-consolas-for-powerline
brew cask install font-consolas

brew cask cleanup

