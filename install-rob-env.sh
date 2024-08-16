#!/bin/bash

# install determinate nix
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --diagnostic-endpoint="" --no-confirm
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

# clone dotfiles
nix run nixpkgs#git -- clone https://github.com/rob-3/dotfiles

# clone flake
nix run nixpkgs#git -- clone https://github.com/rob-3/msflake

# Configure neovim
mkdir -p ~/.config/nvim
echo 'require("rob-3")' > ~/.config/nvim/init.lua
cp -r ~/dotfiles/lua ~/.config/nvim/
touch ~/.config/nvim/lua/rob-3/secrets.lua

# Set up nix profile
cd ~/msflake || exit
nix profile install .

# Set up git config
cp ~/dotfiles/.gitconfig ~/.gitconfig
