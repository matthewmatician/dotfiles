#!/bin/bash

DOTFILES=$HOME/dotfiles

echo "creating symlinks"
linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*.symlink' )
for file in $linkables ; do
    target=".$( basename $file ".symlink" )"
    echo "creating symlink for $file"
    ln -s $file $HOME/$target
done
