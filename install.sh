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

    echo "Updating OSX settings"
    source installosx.sh

    echo "Installing node (from nvm)"
    source install/nvm.sh
fi

echo "Installing Vim setup"
ln -s ~/dotfiles/vim ~/.vim
vim -S vim/plugins.vim +PlugInstall +qa
vim/plugged/YouCompleteMe/install.py --js-completer
ln -s ~/dotfiles/.vimrc ~/.vimrc

echo "Installing NPM modules"
sudo npm install -g eslint

echo "Configuring zsh"
ln -s ~/dotfiles/ordealz.zsh-theme ~/dotfiles/zsh/custom/
mkdir ~/dotfiles/zsh/custom/plugins/man-colors
ln -s ~/dotfiles/man-colors.plugin.zsh ~/dotfiles/zsh/custom/plugins/man-colors/
chsh -s $(which zsh)
#sudo dscl ~ -create /Users/$USER UserShell /usr/local/bin/zsh

echo "Done. Don't forge to run install/prefs.sh after dropbox is finished."
