
{ config, lib, pkgs, ... }:
let

in
{
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  networking.hostName = "box"; # Define your pc name.
  networking.networkmanager.enable = true; # takes care of internet, wifi

  i18n.consoleKeyMap = "dvorak"; # default to dvorak for console
  i18n.defaultLocale = "en_US.UTF-8";

  time.timeZone = "Europe/Copenhagen"; # timezone





  # List packages installed in system profile. To search, run:
  # $ nix search wget



  # set up deamon docker so user can create docker images etc.
  # add "docker" to usergroup
  virtualisation.docker.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = lib.mkDefault false;


  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;


  # desktop layouts
  services.xserver.layout = "dvorak,us,sk";
  services.xserver.xkbVariant = ",,qwerty";
  services.xserver.xkbOptions = "eurosign:e, caps:escape";


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anon = {
    isNormalUser = true;
    extraGroups = [
	    "wheel"
	    "networkmanager"
	    "input"
	    "tty"
	    "audio"
	    "video"
	    "sway"
      "docker"
	  ]; # Enable ‘sudo’ for the user.
  };

  # have it if I have pmount present include this
  # needs pmount
  security.wrappers = {
    pmount.source = "${pkgs.pmount}/bin/pmount";
    pumount.source = "${pkgs.pmount}/bin/pumount";
  };
  security.sudo.configFile = ''
  Defaults rootpw
  '';

  system.stateVersion = "19.09"; # Did you read the comment?
}
