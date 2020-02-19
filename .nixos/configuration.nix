# 
{ config, lib, pkgs, ... }:
let
  url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  waylandOverlay = (import (builtins.fetchTarball url));
  schema = pkgs.gsettings-desktop-schemas;
  datadir = "${schema}/share/gsettings-schemas/${schema.name}";
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  nixpkgs.overlays = [ waylandOverlay];
  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "box"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n = {
    consoleFont = "latarcyrheb-sun32x24";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #

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

  # Disable HiDPI scaling for X apps
   export GDK_SCALE=1
   export QT_AUTO_SCREEN_SCALE_FACTOR=0
  '';

  programs.sway.extraPackages = with pkgs; [
	  xwayland
	  swaybg
	  swayidle
	  swaylock
	  waybar
    #	i3status-rust
	  gebaar-libinput
	  grim
	  kanshi
	  # mako # notification deamon
	  oguri
	  redshift-wayland
	  slurp
	  wf-config
	  wf-recorder
	  wl-clipboard
	  wtype
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

	  vim
	  emacs
	  firefox
    chromium
    htop
    lollypop

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



  virtualisation.docker.enable = true;

  # services.httpd =
  #   {
  #     enable = true;
  #     adminAddr = "localhost";

  #     extraModules =
  #       [
  #         "http2"
  #         {name = "php7"; path = "${pkgs.php}/modules/libphp7.so";}
  #       ];
  #     enablePHP = true;
  #     enableSSL = false;

  #     virtualHosts =
  #       [
  #         {
  #           hostName = "localhost";
  #           serverAliases = [ "localhost" ];
  #           documentRoot = "/data/www";
  #           extraConfig = ''
  #         <Directory "/data/www">
  #           Options +Indexes
  #           AllowOverride All
  #           Order allow,deny
  #           Allow from all
  #         </Directory>
  #         <IfModule mod_dir.c>
  #           DirectoryIndex index.htm index.html index.php index.php3 default.html index.cgi
  #         </IfModule>
  #       '';
  #         }
  #       ];
  #   };

  # programs.dconf.enable = true;
  # services.dbus.packages = [ pkgs.gnome3.dconf ];




  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = false;
  services.xserver.layout = "dvorak,us,sk";
  services.xserver.xkbVariant = ",,qwerty";
  services.xserver.xkbOptions = "eurosign:e, caps:escape";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.windowManager.i3.enable = true;

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
  security.wrappers = {
    pmount.source = "${pkgs.pmount}/bin/pmount";
    pumount.source = "${pkgs.pmount}/bin/pumount";
  };

  security.sudo.configFile = ''
Defaults rootpw
'';


  # Running unstable packages anyway !!

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  # system.autoUpgrade = true;
  system.stateVersion = "19.09"; # Did you read the comment?

}
