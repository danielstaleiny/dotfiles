#!/usr/bin/env bash

# remove base channel
echo '/n'
echo 'User channels:'
nix-channel --remove nixos
# add unstable as default channel
nix-channel --add https://nixos.org/channels/nixos-unstable nixos
nix-channel --list

echo '/n'


# Same but for ROOT
# remove base channel
sudo nix-channel --remove nixos
# add unstable as default channel
sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos
echo 'ROOT channels:'
sudo nix-channel --list
echo '/n'

./scripts/symlink-root-nixos.sh


