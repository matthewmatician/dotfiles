#!/bin/bash

DROPBOX=$HOME/Dropbox/prefs
PREFS=$HOME/library/Preferences

echo "creating symlinks"
linkables=$( find -H "$DROPBOX" -maxdepth 1 -name '*.plist' )
for file in $linkables ; do
    name="$( basename $file)"
    echo "creating symlink for $file"
    mv $PREFS/$name $PREFS/$name.old
    ln -s $file $PREFS/$name
done
