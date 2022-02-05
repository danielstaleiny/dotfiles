# 
{ config, lib, pkgs, ... }:
let
  # url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  # waylandOverlay = (import (builtins.fetchTarball url));
  schema = pkgs.gsettings-desktop-schemas;
  datadir = "${schema}/share/gsettings-schemas/${schema.name}";
  # ip = import "/home/anon/work/daniel/wireguard-server-nixos-digititalocean-private/ip.nix";
  home-manager = (builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "829e89a16f4f96428d1b94e68d4c06107b5491c0";
    ref = "master";
  });
  cachixpkgs = (import (builtins.fetchTarball { url = "https://cachix.org/api/v1/install"; }) {});
  rlang = pkgs.rWrapper.override{ packages = with pkgs.rPackages;[ggplot2 dplyr xts lattice tidyverse ggthemes]; };
  # custom-python = pkgs.python3.withPackages (ps: with ps; [
  #   ipykernel
  #   jupyterlab
  #   matplotlib
  #   numpy
  #   pandas
  #   seaborn
  #   networkx
  #   scipy
  #   scikit-learn
  #   Keras
  #   tensorflow
  #   conda
  # ]);

  config = {
    font = {
      px = 20;
      px-str = "20px";
      pt = 14.5;
      pt-str = "14.5";


    };
    color = {

      # fg = "#fbf8ef";
      # bg = "#383838";
      # black = "#fbf8ef";
      # white = "#383838";

      bg = "#f5f8f6";
      fg = "#111111";
      white = "#ffffff";
      black = "#111111";

      red = "#df967c";
      blue = "#004c7d";
      blue2 = "#0082c2";
      green = "#00a84c";
      green2 = "#73bf42";
      green3 = "#c2d72e";
      brown = "#d7a86e";
      brown2 = "#e1c297";
      brown3 = "#eee1c5";
      yellow = "#faa619";
      orangeSway = "#df967c";
      orange = "#f57f1e";
      red2 = "#eb1c23";
      red3 = "#c2262b";
      gray = "#808080";
    };
  };

in
{
  imports =
    [
      ./hardware-configuration.nix
      (import "${home-manager}/nixos")
    ];



  # TODO remove this once flakes land in upstream
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    keep-outputs = true
    keep-derivations = true
    experimental-features = nix-command flakes
  '';

  networking.hosts = {
    "127.0.0.1" = ["l"];
    "0.0.0.0" = [
      # "www.reddit.com"
      # "reddit.com"
      # "www.instagram.com"
      "teddit.net"
      # "www.facebook.com"
      # "news.ycombinator.com"
      # "twitch.tv"
      # "www.twitch.tv"
      "lobste.rs"
      # # "youtube.com"
      # # "www.youtube.com"
      "9gag.com"
      "www.9gag.com"
      "mojevideo.sk"
      # "dennikn.sk"
      # "www.dennikn.sk"
      # "www.pornhub.com"
      "beeg.com"
    ];
  };




  home-manager.users.anon = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;
    home.packages = []
      ++ (with cachixpkgs; [ cachix ])
      ++ (with pkgs; [
      gotop
      fzf
      unzip
      gnupg
      sqlite
      autojump
      ncdu
      zeal
      wine
      playonlinux
      nix-prefetch-git
      pmount
      coreutils
      cmake
      nixfmt
      graphviz
      aspell
      aspellDicts.en
      shellcheck
      fd
      clang
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
      # custom-python
      conda
      dhall
      docker-compose
      pandoc
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
      gnome3.nautilus #file manager
      gnome3.eog
      qt5.qtwayland
      pavucontrol
      mongodb-compass
      # manix
      ffmpeg-full
      notify-desktop
      grim
      slurp
      wl-clipboard
      wf-recorder
      redshift-wlr
      mpd
      vimpc
      unrar
      texlive.combined.scheme-full
      qbittorrent
      anki
      gtypist
      teamspeak_client
      rlang
      ssb-patchwork
      tree
      rstudio
      poppler_utils
      weechat
      # polkit-kde-agent
      gnome.gnome-screenshot
      element-desktop
      discord
      (steam.override { extraPkgs = pkgs: with pkgs; [ pango harfbuzz libthai ];})
      dotnet-sdk_5
      iptables
      tcpdump
      nm-tray
      pavucontrol
      vscode
      wayvnc
      gnome.vinagre
    ]);

    wayland.windowManager.sway = {
      enable = true;
      config = null;
      extraConfig = builtins.readFile "/home/anon/.config/sway/.config";

      extraSessionCommands = ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      export XDG_CURRENT_DESKTOP=sway
      export XDG_SESSION_TYPE=wayland
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
      export MOZ_ENABLE_WAYLAND=1
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
      font.name = "Noto Sans Mono ${config.font.pt-str}";
      # iconTheme.name = "arc-icon-theme";
      # theme.name = "art-theme";
      iconTheme.name = "Adwaita";
      theme.name = "Adwaita";
      # theme.name = "Adwaita-dark";
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
            x = 48;
            y = 48;
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
          size = config.font.px;
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
            background = config.color.bg;
            foreground = config.color.fg;
          };
          cursor = {
            text = config.color.fg;
            cursor = config.color.red;
          };
          normal = {
            black=   config.color.black;
            red=     config.color.red;
            green=   config.color.green;
            yellow=  config.color.orange;
            blue=    config.color.blue;
            magenta= config.color.red2;
            cyan=    config.color.blue2;
            white=   config.color.gray;
          };
          bright = {
            black=   config.color.black;
            red=     config.color.red;
            green=   config.color.green;
            yellow=  config.color.orange;
            blue=    config.color.blue;
            magenta= config.color.red2;
            cyan=    config.color.blue2;
            white=   config.color.gray;
          };
          indexed_colors = [];
        };
        background_opacity = 1;
        mouse_bindings = [{ mouse =  "Middle"; action = "PasteSelection"; }];
        mouse = {
          double_click = { threshold = 300; };
          triple_click = { threshold = 300; };
          hide_when_typing =  true;
          hints = {
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
        key_bindings = [
          {
            key = "N";
            mods = "Control";
            action = "SpawnNewInstance";
          }
        ];
      };
    };
    programs.bat.enable = true; # like cat
    programs.bat.config = {theme = "TwoDark";};

    programs.beets.enable = true; # get music info
    programs.broot.enable = true; # ranger alternative, dir visualizer
    programs.browserpass.enable = true;
    programs.browserpass.browsers = ["firefox"];
    programs.chromium.enable = true;
    programs.direnv.enable = true;
    programs.direnv.nix-direnv.enable = true;
    # programs.direnv.enableZshIntegration = true; # this works only if the home-manager manages the zsh shell.
    programs.emacs.enable = true;
    # services.emacs.enable = true; # enable emacs deamon
    # programs.emacs.package = pkgs.emacs;
    programs.emacs.extraPackages = epkgs: [
      epkgs.sqlite3
      epkgs.vterm
      epkgs.auctex-latexmk
      epkgs.org-pdftools
      ];
    programs.feh.enable = true;
    programs.fzf.enable = true;

    # programs.vscode.enable = true;


    programs.git.enable = true;
    programs.git.userEmail = "daniel.rafaj@tuta.io";
    programs.git.userName = "Daniel Rafaj";

    programs.gpg.enable = true;
    services.gpg-agent.enable = true;
    # services.gpg-agent.enableSshSupport = true; # test this 
    programs.htop.enable = true;
    programs.info.enable = true;
    programs.jq.enable = true;
    programs.lesspipe.enable = true;
    programs.lf.enable = true; # like ranger
    programs.mako.enable = true; # supports styling
    programs.mako.font = "EtBembo Italic 20.0";
    programs.mako.maxVisible = 3;
    programs.mako.defaultTimeout = 5000; # in miliseconds
    programs.mako.backgroundColor = config.color.bg;
    programs.mako.textColor = config.color.fg;
    programs.mako.borderColor = config.color.orangeSway;
    programs.mako.borderSize = 4;
    programs.mako.padding = "40,40,20,40";
    programs.mako.margin = "25";
    programs.mako.icons = false;
    programs.mako.width = 500;
    programs.mako.height = 500;
    programs.mako.borderRadius = 0; # default 0
    programs.mpv.enable = true;
    programs.neovim.enable = true;
    programs.neovim.vimAlias = true;
    programs.neovim.vimdiffAlias = true;
    programs.neovim.withNodeJs = true;
    programs.noti.enable = true;
    programs.obs-studio.enable = true;
    programs.obs-studio.plugins = [ pkgs.obs-studio-plugins.wlrobs];
    # programs.obs-studio.plugins = [pkgs.obs-wlrobs pkgs.obs-v4l2sink];
    programs.password-store.enable = true;
    programs.pazi.enable = true; # use Z to jump into directory


    programs.rofi = {
      enable = true;
      # extraConfig = builtins.readFile "/home/anon/.config/rofi/.config";
      theme = "custome";
      font = "Noto Sans Mono ${config.font.pt-str}";
      # font = "EtBembo ${config.font.pt-str}";
    };

    programs.ssh.enable = true;
    programs.zathura.enable = true;
    programs.zathura.options = {
      default-bg = config.color.bg;
      default-fg = config.color.fg;
      recolor = true;
      recolor-darkcolor = config.color.fg;
      recolor-lightcolor = config.color.bg;
      selection-clipboard = "clipboard";
    };
    # qt.enable = true;
    # qt.platformTheme = "gtk";
    # services.flameshot.enable = true; # test if it works in wayland
    # services.fluidsynth.enable = true;
    # services.mpd.enable = true; # maybe nice music player in background
    # services.mpdris2.enable = true;
    services.udiskie.enable = true;

    services.gammastep.enable = true;
    services.gammastep.latitude = "48.148598";
    services.gammastep.longitude = "17.107748";
    services.gammastep.temperature.day = 6500;
    services.gammastep.settings.general.brightness-day = "1";
    services.gammastep.temperature.night = 3700;
    services.gammastep.settings.general.brightness-night = "0.7";

    services.network-manager-applet.enable = true;

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

  # console.font = "latarcyrheb-sun32x24";
  console.keyMap = "dvorak";
  i18n.defaultLocale = "en_US.UTF-8";

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  #


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
    gnugrep
    mesa
    vulkan-tools
    vulkan-loader
    vulkan-headers
    vulkan-validation-layers
    wireguard
    wireguard-tools

    #FONTS
    source-code-pro
    liberation_ttf
    fira-code
    fira-code-symbols
    lato
    montserrat
    etBook
    liberation_ttf
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
  ];

  fonts.fonts = with pkgs; [
    source-code-pro
    liberation_ttf
    fira-code
    fira-code-symbols
    etBook
    lato
    montserrat
    liberation_ttf
    noto-fonts
    noto-fonts-extra
    noto-fonts-emoji
  ];

  programs.steam.enable = true;

  # for sharing screen
  services.pipewire.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ]; # sway


  # services.syncthing.enable = false;
  # services.syncthing.openDefaultPorts = true;
  # services.syncthing.systemService = true;
  # services.syncthing.user = "anon";
  # services.syncthing.group = "wheel";
  # services.syncthing.dataDir = "/home/anon";
  # services.syncthing.declarative.devices = {
  #   xps = { id = "THXJHNG-CKBJSV4-IXU5FCT-YAN55WF-BIEBUBX-NZTFNZK-MVOZUCR-QA2FCQQ";};
  #   musicPi = { id = "4TZTBZM-PUZTL2V-XZX7WYU-SOVQRIM-D64Z3MA-DANZY4Y-VXFALR7-KAQG7QA";};
  # };
  # services.syncthing.declarative.folders = {
  #   "~/share" = { devices = [ "xps" ]; id = "secrets"; };
  #   "~/Music" = { devices = [ "musicPi" "xps" ]; id = "music"; };
  # };





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
    extraPackages = with pkgs; [amdvlk libva ];
    extraPackages32 = with pkgs.driversi686Linux; [ mesa amdvlk ];
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

# networking.wireguard.interfaces = {
#     # "wg0" is the network interface name. You can name the interface arbitrarily.
#     wg0 = {
#       # Determines the IP address and subnet of the client's end of the tunnel interface.
#       ips = [ "10.0.0.2/24" ];
#       listenPort = 51820; # to match firewall allowedUDPPorts (without this wg uses random port numbers)

#       # Path to the private key file.
#       #
#       # Note: The private key can also be included inline via the privateKey option,
#       # but this makes the private key world-readable; thus, using privateKeyFile is
#       # recommended.
#       privateKeyFile = "/home/anon/wireguard-keys/private";

#       peers = [
#         # For a client configuration, one peer entry for the server will suffice.

#         {
#           # Public key of the server (not a file path).
#           publicKey = "S9wLwLW8l3j9lEHjvd1p6Tq2ZYwcrJ+DwS71yQZx+U0=";

#           # Forward all the traffic via VPN.
#           allowedIPs = [ "0.0.0.0/0" ];
#           # Or forward only particular subnets
#           #allowedIPs = [ "10.100.0.1" "91.108.12.0/22" ];

#           # Set this to the server IP and port.
#           endpoint = "${ip}:51820"; # ToDo: route to endpoint not automatically configured https://wiki.archlinux.org/index.php/WireGuard#Loop_routing https://discourse.nixos.org/t/solved-minimal-firewall-setup-for-wireguard-client/7577

#           # Send keepalives every 25 seconds. Important to keep NAT tables alive.
#           persistentKeepalive = 25;
#         }
#       ];
#     };
#   };




  # Open ports in the firewall.
  # networking.firewall.allowedUDPPorts = [ 51820 ];
  networking.firewall.enable = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.package = pkgs.pulseaudioFull;
  hardware.pulseaudio.extraConfig = ''
load-module module-echo-cancel use_master_format=1 aec_method=webrtc aec_args="analog_gain_control=0\ digital_gain_control=1" source_name=echoCancel_source sink_name=echoCancel_sink
set-default-source echoCancel_source
set-default-sink echoCancel_sink
'';


  # services.avahi.enable = true;
  # services.avahi.nssmdns = true;

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
  # virtualisation.virtualbox.host.enable = true;
  # users.extraGroups.vboxusers.members = [ "anon" ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.anon = {
    isNormalUser = true;
    extraGroups = [
	    "wheel"
	    "input"
	    "tty"
	    "audio"
	    "video"
	    "sway"
      "docker"
      # "vboxusers"
	  ]; # Enable ‘sudo’ for the user.
  };
  # security.wrappers = {
  #   pmount.source = "${pkgs.pmount}/bin/pmount";
  #   pumount.source = "${pkgs.pmount}/bin/pumount";
  # };

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
