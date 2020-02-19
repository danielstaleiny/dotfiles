#!/usr/bin/env bash

sudo mv /etc/nixos/hardware-configuration.nix /home/anon/.config/nixos/hardware-configuration.nix
sudo chown anon /home/anon/.config/nixos/hardware-configuration.nix
sudo mv /etc/nixos/configuration.nix /etc/nixos/configuration.backup.nix

echo 'Creating symlinks:'
echo ' - symlink to /etc/nixos/hardware-configuration.nix'
echo ' - symlink to /etc/nixos/configuration.nix'
# ln -s source target
sudo ln -s /home/anon/.config/nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
sudo ln -s /home/anon/.config/nixos/configuration.nix /etc/nixos/configuration.nix

