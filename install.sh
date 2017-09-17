#!/bin/bash

echo "Installing dotfiles"

echo "Initializing submodule(s)"
git submodule update --init --recursive

echo "Linking dotfiles"
source install/link.sh

if [ "$(uname)" == "Darwin" ]; then
    echo "Running on OSX"

    echo "Brewing all the things"
    source install/brew.sh

    echo "blurp.."

    echo "Updating OSX settings"
    source installosx.sh

    echo "Installing node (from nvm)"
    source install/nvm.sh
fi

echo "Installing Vim setup"
ln -s ~/dotfiles/vim ~/.vim
vim -S vim/plugins.vim +PlugInstall +qa
ln -s ~/dotfiles/.vimrc ~/.vimrc

echo "Installing NPM modules"
sudo npm install -g gulp
sudo npm install -g eslint
sudo npm install -g babel-eslint
sudo npm install -g eslint-plugin-react

echo "Configuring zsh as default shell"
chsh -s $(which zsh)
sudo dscl ~ -create /Users/$USER UserShell /usr/local/bin/zsh

echo "Done."
