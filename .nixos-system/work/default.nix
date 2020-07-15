# .config/nixos/work/default.nix
# work pc related stuff

{ config, lib, pkgs, ... }:
let
  # maybe pin this
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  waylandOverlay = (import (builtins.fetchTarball url));

  # gsettings
  schema = pkgs.gsettings-desktop-schemas;
  datadir = "${schema}/share/gsettings-schemas/${schema.name}";
in
{

  imports =
    [
      ../common.nix
    ];

  nixpkgs.overlays = [ waylandOverlay];

  console.font = "latarcyrheb-sun32x24";

  # SSD stuff
  boot.kernel.sysctl = {
    "vm.swappiness" = 1;
  };
  services.fstrim.enable = true;

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;


  services.syncthing.enable = true;
  services.syncthing.openDefaultPorts = true;
  services.syncthing.systemService = true;
  services.syncthing.user = "anon";
  services.syncthing.group = "wheel";
  services.syncthing.dataDir = "/home/anon";

  services.syncthing.declarative.devices = { server = { addresses = [ "tcp://ipv4TODO"]; id = "ID of device";}; };
  services.syncthing.declarative.folders = { "~/share" = { devices = [ "server" ]; id = "secrets"; }; };
  programs.sway.enable = true;
  programs.sway.extraSessionCommands = ''
   ## Tell toolkits to use wayland
   export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
   export CLUTTER_BACKEND=wayland
   #export QT_QPA_PLATFORM=wayland-egl
   export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
   export SQL_VIDEODRIVER=wayland
   # Fix kirta and other egl using apps
   export LD_LIBRARY_PATH=/run/opengl-driver/lib
   # makes redshift works
   WLR_DRM_NO_ATOMIC=1 sway
   # for gameees
   SDL_VIDEODRIVER=wayland

  # Disable HiDPI scaling for X apps
   export GDK_SCALE=1
   export QT_AUTO_SCREEN_SCALE_FACTOR=0
  '';

  programs.sway.extraPackages = with pkgs; [
	  xwayland
	  swaybg
	  # swayidle
	  # swaylock
	  waybar
    #	i3status-rust
	  gebaar-libinput
	  grim
	  kanshi
	  # mako # notification deamon
	  oguri
	  redshift-wayland
	  slurp
	  #wf-config
	  # wf-recorder
	  wl-clipboard
	  # wtype
    wofi
  ];



  environment.systemPackages = with pkgs; [
	  wget
    zsh
    fzf
    #autojump
    pmount
    ripgrep
    ripgrep-all
    bat # like cat but with syntax
    lf # like ranger
    tldr # man examples

    #FONTS
	  source-code-pro
    noto-fonts-extra
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols

	  waybox
	  # cage
	  wayfire

	  neovim
	  emacs
    robo3t
    # phantomjs
    phantomjs2


    nix-prefetch-git
    pinentry-curses
    pinentry-gnome
    pass
	  firefox
    chromium
    htop
    lollypop
    steam
    alacritty #Terminal
    rofi #X11 Launcher

    #PROGRAMMING
    git
    nodejs
    python
    docker-compose
    pandoc
    tectonic
    texlive.combined.scheme-full
    ispell

    filezilla
    youtube-dl # youtube downloader
    vlc
    evince # pdfviewer
    inkscape
    libreoffice
    gimp
    krita
    blender
    tdesktop # Telegram desktop client
    gnumake
    #GTK SETTINGS
    lxappearance
    gtk_engines
    glib
    pango  # fonts stuff
    arc-theme
    arc-icon-theme
    adementary-theme
    gnome3.adwaita-icon-theme
    adwaita-qt
    # remove if they are not doing anything
    atk
    at-spi2-atk
    xdg_utils

    gnome3.nautilus #file manager
    gnome3.eog
    gotop
  ];

  fonts.fonts = with pkgs; [
	  source-code-pro
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = false;

}

