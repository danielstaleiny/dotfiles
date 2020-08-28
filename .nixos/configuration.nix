# 
{ config, lib, pkgs, ... }:
let
  # url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  # waylandOverlay = (import (builtins.fetchTarball url));
  schema = pkgs.gsettings-desktop-schemas;
  datadir = "${schema}/share/gsettings-schemas/${schema.name}";
  home-manager = (builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "6cf6b587b575493e7718bf08b209013d7dcf4d58"; 
    ref = "master";
  });
  cachixpkgs = (import (builtins.fetchTarball { url = "https://cachix.org/api/v1/install"; }) {});
in
{
  imports =
    [
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
  '';

  home-manager.users.anon = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;
    home.packages = []
      ++ (with cachixpkgs; [ cachix ])
      ++ (with pkgs; [
      gotop
      fzf
      unzip
      gnupg
      autojump
      ncdu
      zeal
      wine
      playonlinux
	    nix-prefetch-git
      pmount
      ripgrep
      ripgrep-all
      zim
      whois
      youtube-dl
      gimp
      imagemagick

      lf # like ranger
      tldr # man examples
	    # cage
      lollypop
      #PROGRAMMING
      git
      nodejs
      python
      dhall
      docker-compose
      pandoc
      # texlive.combined.scheme-full
      tectonic
      plantuml
      gdb
      jq
      ispell
      filezilla
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
      steam
      steam-run
      gnome3.nautilus #file manager
      gnome3.eog
      qt5.qtwayland
    ]);

    wayland.windowManager.sway = {
      enable = true;
      config = null;
      extraConfig = builtins.readFile "/home/anon/.config/sway/.config";
      extraSessionCommands = ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      export SDL_VIDEODRIVER=wayland
      # needs qt5.qtwayland in systemPackages
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      export QT_AUTO_SCREEN_SCALE_FACTOR=0
      export _JAVA_AWT_WM_NONREPARENTING=1
      export CLUTTER_BACKEND=wayland
      export SQL_VIDEODRIVER=wayland
      export LD_LIBRARY_PATH=/run/opengl-driver/lib
      export WLR_DRM_NO_ATOMIC=1 sway
      export GDK_SCALE=1
      '';
    };

    # example for symlinking config files
    # home.file."foo".source = config.lib.file.mkOutOfStoreSymlink ./bar;

    programs.qutebrowser = {
      enable = true;
      extraConfig = ''
        c.auto_save.session = True
        '';
    };
    programs.firefox = {
      enable = true;
    #   profiles.anon.settings = {
    #       "beacon.enabled" = false;
    #       # "browser.display.background_color" = "#c5c8c6";
    #       # "browser.display.foreground_color" = "#1d1f21";
    #       "browser.safebrowsing.appRepURL" = "";
    #       "browser.safebrowsing.malware.enabled" = false;
    #       "browser.search.hiddenOneOffs" = "Google,Yahoo,Bing,Amazon.com,Twitter";
    #       "browser.search.suggest.enabled" = false;
    #       "browser.send_pings" = false;
    #       "browser.startup.page" = 3;
    #       "browser.tabs.closeWindowWithLastTab" = false;
    #       "browser.urlbar.placeholderName" = "DuckDuckGo";
    #       "browser.urlbar.speculativeConnect.enabled" = false;
    #       # "devtools.theme" = "${config.theme.base16.kind}";
    #       "dom.battery.enabled" = false;
    #       "dom.event.clipboardevents.enabled" = false;
    #       "experiments.activeExperiment" = false;
    #       "experiments.enabled" = false;
    #       "experiments.supported" = false;
    #       "extensions.pocket.enabled" = false;
    #       "general.smoothScroll" = false;
    #       "geo.enabled" = false;
    #       "layout.css.devPixelsPerPx" = "1";
    #       "media.navigator.enabled" = false;
    #       "media.video_stats.enabled" = false;
    #       "network.IDN_show_punycode" = true;
    #       "network.allow-experiments" = false;
    #       "network.dns.disablePrefetch" = true;
    #       "network.http.referer.XOriginPolicy" = 2;
    #       "network.http.referer.XOriginTrimmingPolicy" = 2;
    #       "network.http.referer.trimmingPolicy" = 2;
    #       "network.prefetch-next" = false;
    #       "permissions.default.shortcuts" = 2; # Don't steal my shortcuts!
    #       "privacy.donottrackheader.enabled" = true;
    #       "privacy.donottrackheader.value" = 1;
    #       "privacy.firstparty.isolate" = true;
    #       "signon.rememberSignons" = false;
    #       "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    #       "default.zoom" = "133%";
    #       # "widget.content.gtk-theme-override" = "Adwaita:light";

    #   };
    };


    gtk = {
      enable = true;
      font.name = "Noto Sans Mono 16";
      # iconTheme.name = "arc-icon-theme";
      # theme.name = "art-theme";
      iconTheme.name = "Adwaita";
      theme.name = "Adwaita-dark";
    };

    programs.alacritty = {
      enable = true;
      settings = {
        env = {TERM = "xterm-256color";};
        window = {
          dimensions = {
            columns = 0;
            lines = 0;
          };
          padding = {
            x = 12;
            y = 12;
          };
          dynamic_padding = true;
          decorations = "full";
          startup_mode = "Windowed";
        };
        scrolling = {
          history = 10000;
          multiplier = 3;
        };
        font = {
          normal = {
            family = "Noto Sans Mono";
            style = "Medium";
          };
          bold = {
            family = "Noto Sans Mono";
            style = "Bold";
          };
          italic = {
            family = "Source Code Pro";
            style = "Medium Italic";
          };
          size = 18.0;
          offset = {
            x = 0;
            y = 0;
          };
          glyph_offset = {
            x = 0;
            y = 0;
          };
          use_thin_strokes = true;
        };

        draw_bold_text_with_bright_colors = true;

        colors= {
          primary = {
            background = "0x282828";
            foreground = "0xeaeaea";
          };
          cursor = {
            text = "0x9ec400";
            cursor = "0x9ec400";
          };
          normal = {
            black=   "0x000000";
            red=     "0xd54e53";
            green=   "0xb9ca4a";
            yellow=  "0xe6c547";
            blue=    "0x7aa6da";
            magenta= "0xc397d8";
            cyan=    "0x70c0ba";
            white=   "0xeaeaea";
          };
          bright = {
            black=   "0x666666";
            red=     "0xff3334";
            green=   "0x9ec400";
            yellow=  "0xe7c547";
            blue=    "0x7aa6da";
            magenta= "0xb77ee0";
            cyan=    "0x54ced6";
            white=   "0xeaeaea";
          };
          indexed_colors = [];
        };
        background_opacity = 1;
        mouse_bindings = [{ mouse =  "Middle"; action = "PasteSelection"; }];
        mouse = {
          double_click = { threshold = 300; };
          triple_click = { threshold = 300; };
          hide_when_typing =  true;
          url = {
            modifiers = "None";
          };
        };

        selection = {
          semantic_escape_chars = ",│`|:\"' ()[]{}<>";
          save_to_clipboard = false;
        };
        cursor = {
          style = "Block";
          unfocused_hollow = true;
        };
        live_config_reload = true;

        shell = {
          program = "/run/current-system/sw/bin/zsh";
        };
        working_directory = "None";
        enable_experimental_conpty_backend = false;
        alt_send_esc = true;

        debug = {
          render_timer = false;
          persistent_logging = false;
          log_level = "Warn";
          print_events = false;
          ref_test = false;
        };

      };
    };
    programs.bat.enable = true; # like cat
    programs.beets.enable = true; # get music info
    programs.broot.enable = true; # ranger alternative, dir visualizer
    programs.browserpass.enable = true;
    programs.browserpass.browsers = ["firefox"];
    programs.chromium.enable = true;
    programs.direnv.enable = true;
    programs.direnv.enableNixDirenvIntegration = true;
    services.lorri.enable = true;
    programs.emacs.enable = true;
    # services.emacs.enable = true; # enable emacs deamon
    # programs.emacs.package = pkgs.emacs;
    # programs.emacs.extraPackages = "epkgs: [epkgs.magit]";
    programs.feh.enable = true;
    programs.fzf.enable = true;


    # programs.git.enable = true;
    # programs.git.userEmail = "daniel.rafaj@tuta.io";
    # programs.git.userName = "Daniel Rafaj";

    programs.gpg.enable = true;
    services.gpg-agent.enable = true;
    # services.gpg-agent.enableSshSupport = true; # test this 
    programs.htop.enable = true;
    programs.info.enable = true;
    programs.jq.enable = true;
    programs.lesspipe.enable = true;
    programs.lf.enable = true; # like ranger
    programs.mako.enable = true; # supports styling
    programs.mako.maxVisible = 3;
    programs.mpv.enable = true;
    programs.neovim.enable = true;
    programs.neovim.vimAlias = true;
    programs.neovim.vimdiffAlias = true;
    programs.neovim.withNodeJs = true;
    programs.noti.enable = true;
    programs.obs-studio.enable = true;
    programs.password-store.enable = true;
    programs.pazi.enable = true; # use Z to jump into directory
    programs.rofi.enable = true;
    # programs.rofi.font = "";
    programs.ssh.enable = true;
    programs.texlive.enable = true;
    programs.zathura.enable = true;
    # qt.enable = true;
    # qt.platformTheme = "gtk";
    services.flameshot.enable = true; # test if it works in wayland
    services.fluidsynth.enable = true;
    # services.mpd.enable = true; # maybe nice music player in background
    # services.mpdris2.enable = true;
    services.redshift.enable = true;
    services.redshift.latitude = "48,15"; # Bratislava
    services.redshift.longitude = "17,1166667";

    # services.syncthing.enable = true; # synthing
    services.udiskie.enable = true;




  };

  # nixpkgs.overlays = [ waylandOverlay];
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

  console.font = "latarcyrheb-sun32x24";
  console.keyMap = "dvorak";
  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #

  # programs.sway.enable = true;
  # programs.sway.extraSessionCommands = ''
  #  ## Tell toolkits to use wayland
  #  export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
  #  export CLUTTER_BACKEND=wayland
  #  #export QT_QPA_PLATFORM=wayland-egl
  #  export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
  #  export SQL_VIDEODRIVER=wayland
  #  # Fix kirta and other egl using apps
  #  export LD_LIBRARY_PATH=/run/opengl-driver/lib
  #  WLR_DRM_NO_ATOMIC=1 sway
  #  # for gameees
  #  SDL_VIDEODRIVER=wayland

  # # Disable HiDPI scaling for X apps
  #  export GDK_SCALE=1
  #  export QT_AUTO_SCREEN_SCALE_FACTOR=0
  # '';

  # programs.sway.extraPackages = with pkgs; [
	#   xwayland
	#   swaybg
	#   swayidle
	#   swaylock
	#   waybar
  #   #	i3status-rust
	#   gebaar-libinput
	#   grim
	#   kanshi
	#   # mako # notification deamon
	#   oguri
	#   redshift-wayland
	#   slurp
	#   wf-recorder
	#   wl-clipboard
	#   wtype
  #   wofi
  # ];

  # System packages accessable everywhere
  environment.systemPackages = with pkgs; [
	  wget
    zsh
	  vim
	  firefox
    git


    #FONTS
	  source-code-pro
    noto-fonts-extra
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
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

 hardware.opengl = {
    enable = true;
    driSupport32Bit = true; # very important
    driSupport = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };




 services.dbus.packages = with pkgs; [ gnome3.dconf gnome2.GConf ];
 programs.dconf.enable = true; # for GNOME aps to accept themes




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
  networking.firewall.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  # services.xserver.layout = "dvorak,us,sk";
  # services.xserver.xkbVariant = ",,qwerty";
  # services.xserver.xkbOptions = "eurosign:e, caps:escape";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;
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
  system.stateVersion = "20.09"; # Did you read the comment?

}
