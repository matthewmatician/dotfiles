#!/bin/sh
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.4/install.sh | bash

nvm install stable
nvm alias default stable
