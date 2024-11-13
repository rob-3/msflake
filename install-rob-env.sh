#!/bin/bash

# install determinate nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --diagnostic-endpoint="" --no-confirm
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# clone dotfiles
nix run nixpkgs#git -- clone https://github.com/rob-3/dotfiles

# Set up nix profile
cd ~/msflake || exit
nix profile install .

# Set up git config
cp ~/dotfiles/.gitconfig ~/.gitconfig
