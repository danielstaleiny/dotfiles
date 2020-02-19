# cp configuration.example.nix configuration.nix
# uncomment one of the devices:
# - work
# - xps

# hardware-configuration.nix is not tracked and it is auto-generated,
# do not use it to configure, instead add stuff to specific device
{}:
{
  imports =
    [
      ./hardware-configuration.nix
      # ./work
      # ./xps
    ];
}
