# 
{ config, lib, pkgs, ... }:
let
  # url = "https://github.com/colemickens/nixpkgs-wayland/archive/master.tar.gz";
  # waylandOverlay = (import (builtins.fetchTarball url));
  schema = pkgs.gsettings-desktop-schemas;
  datadir = "${schema}/share/gsettings-schemas/${schema.name}";
  home-manager = (builtins.fetchGit {
    url = "https://github.com/rycee/home-manager.git";
    rev = "5c639ff68abf0f16f2e63fb3f8aca016d54c7d10"; 
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

  home-manager.users.anon = {pkgs, ...}: {
    nixpkgs.config.allowUnfree = true;
    home.packages = []
      ++ (with cachixpkgs; [ cachix ])
      ++ (with pkgs; [
      htop
      gotop
      fzf
      unzip
      autojump
      ncdu
      zathura
      zeal
      wine
      playonlinux
	    nix-prefetch-git
      pmount
      ripgrep
      ripgrep-all
      bat # like cat but with syntax
      zim
      whois
      youtube-dl
      gimp
      imagemagick

      lf # like ranger
      tldr # man examples
	    # cage
      htop
	    vim
	    emacs
      chromium
      lollypop
      rofi #X11 Launcher
      #PROGRAMMING
      git
      nodejs
      python
      dhall
      docker-compose
      pandoc
      texlive.combined.scheme-full
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
    ]);

    wayland.windowManager.sway = {
      enable = true;
      config = null;
      extraConfig = builtins.readFile "/home/anon/.config/sway/.config";
    };
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

        key_bindings = [
          { key = "V";        mods =  "Control|Shift"; action = "Paste";            }
          { key = "C";        mods =  "Control|Shift"; action = "Copy";            }
          { key = "N";        mods =  "Control"; action = "SpawnNewInstance";            }
          { key = "Key0";        mods =  "Control"; action = "ResetFontSize";            }
          { key = "Equals";        mods =  "Control"; action = "IncreaseFontSize";            }
          { key = "Add";        mods =  "Control"; action = "IncreaseFontSize";            }
          { key = "Subtract";        mods =  "Control"; action = "DecreaseFontSize";            }
          { key = "Minus";        mods =  "Control"; action = "DecreaseFontSize";            }
          { key = "Paste";        action = "Paste";            }
          { key = "Copy";        action = "Copy";            }
          { key = "L";        mods = "Control"; action = "ClearLogNotice";            }
          { key = "L";        mods = "Control"; chars = "\x0c";            }
          { key = "Home";        mods = "Alt"; chars = "\x1b[1;3H";            }
          { key = "Home";        chars = "\x1bOH"; mode = "AppCursor";           }
          { key = "Home";        chars = "\x1b[H"; mode = "~AppCursor";           }
          { key = "End";       mods = "Alt"; chars = "\x1b[1;3F"; }
          { key = "End";       chars = "\x1bOF";  mode = "AppCursor";}
          { key = "End";       chars = "\x1b[F";  mode = "~AppCursor";}
          { key = "PageUp";      mods = "Shift"; action = "ScrollPageUp";  mode = "~Alt";}
          { key = "PageUp";      mods = "Shift"; chars = "\x1b[5;2~";  mode = "Alt";}
          { key = "PageUp";      mods = "Control"; chars = "\x1b[5;5~";  }
          { key = "PageUp";      mods = "Alt"; chars = "\x1b[5;3~";  }
          { key = "PageUp";       chars = "\x1b[5~";  }
          { key = "PageDown";      mods = "Shift"; action = "ScrollPageDown"; mode = "~Alt";  }
          { key = "PageDown";      mods = "Shift"; chars = "\x1b[6;2~"; mode = "Alt";  }
          { key = "PageDown";      mods = "Control"; chars = "\x1b[6;5~"; }
          { key = "PageDown";      mods = "Alt"; chars = "\x1b[6;3~"; }
          { key = "PageDown";      chars = "\x1b[6~"; }
          { key = "Tab";     mods = "Shift"; chars = "\x1b[Z"; }
          { key = "Back";      chars = "\x7f"; }
          { key = "Back";     mods = "Alt"; chars = "\x1b\x7f"; }
          { key = "Insert";     chars = "\x1b[2~"; }
          { key = "Delete";     chars = "\x1b[3~"; }
          { key = "Left";    mods = "Shift"; chars = "\x1b[1;2D"; }
          { key = "Left";    mods = "Control"; chars = "\x1b[1;5D"; }
          { key = "Left";    mods = "Alt"; chars = "\x1b[1;3D"; }
          { key = "Left";    chars = "\x1b[D";  mode = "~AppCursor";}
          { key = "Left";    chars = "\x1bOD";  mode = "AppCursor";}
          { key = "Right";   mods = "Shift"; chars = "\x1b[1;2C";  }
          { key = "Right";   mods = "Control"; chars = "\x1b[1;5C";  }
          { key = "Right";   mods = "Alt"; chars = "\x1b[1;3C";  }
          { key = "Right";   chars = "\x1b[C"; mode = "~AppCursor"; }
          { key = "Right";   chars = "\x1bOC"; mode = "AppCursor"; }
          { key = "Up";   mods = "Shift"; chars = "\x1b[1;2A";  }
          { key = "Up";   mods = "Control"; chars = "\x1b[1;5A";  }
          { key = "Up";   mods = "Alt"; chars = "\x1b[1;3A";  }
          { key = "Up";   chars = "\x1b[A"; mode = "~AppCursor"; }
          { key = "Up";   chars = "\x1bOA"; mode = "AppCursor"; }
          { key = "Down";   mods = "Shift"; chars = "\x1b[1;2B";  }
          { key = "Down";   mods = "Control"; chars = "\x1b[1;5B";  }
          { key = "Down";   mods = "Alt"; chars = "\x1b[1;3B";  }
          { key = "Down";   chars = "\x1b[B"; mode = "~AppCursor"; }
          { key = "Down";   chars = "\x1bOB"; mode = "AppCursor"; }
          { key = "F1";   chars = "\x1bOP"; }
          { key = "F2";   chars = "\x1bOQ"; }
          { key = "F3";   chars = "\x1bOR"; }
          { key = "F4";   chars = "\x1bOS"; }
          { key = "F5";   chars = "\x1b[15~"; }
          { key = "F6";   chars = "\x1b[17~"; }
          { key = "F7";   chars = "\x1b[18~"; }
          { key = "F8";   chars = "\x1b[19~"; }
          { key = "F9";   chars = "\x1b[20~"; }
          { key = "F10";   chars = "\x1b[21~"; }
          { key = "F11";   chars = "\x1b[23~"; }
          { key = "F12";   chars = "\x1b[24~"; }
          { key = "F1"; mods = "Shift";  chars = "\x1b[1;2P"; }
          { key = "F2"; mods = "Shift";  chars = "\x1b[1;2Q"; }
          { key = "F3"; mods = "Shift";  chars = "\x1b[1;2R"; }
          { key = "F4"; mods = "Shift";  chars = "\x1b[1;2S"; }
          { key = "F5"; mods = "Shift";  chars = "\x1b[15;2~"; }
          { key = "F6"; mods = "Shift";  chars = "\x1b[17;2~"; }
          { key = "F7"; mods = "Shift";  chars = "\x1b[18;2~"; }
          { key = "F8"; mods = "Shift";  chars = "\x1b[19;2~"; }
          { key = "F9"; mods = "Shift";  chars = "\x1b[20;2~"; }
          { key = "F10"; mods = "Shift";  chars = "\x1b[21;2~"; }
          { key = "F11"; mods = "Shift";  chars = "\x1b[23;2~"; }
          { key = "F12"; mods = "Shift";  chars = "\x1b[24;2~"; }
          { key = "F1"; mods = "Control";  chars = "\x1b[1;5P"; }
          { key = "F2"; mods = "Control";  chars = "\x1b[1;5Q"; }
          { key = "F3"; mods = "Control";  chars = "\x1b[1;5R"; }
          { key = "F4"; mods = "Control";  chars = "\x1b[1;5S"; }
          { key = "F5"; mods = "Control";  chars = "\x1b[15;5~"; }
          { key = "F6"; mods = "Control";  chars = "\x1b[17;5~"; }
          { key = "F7"; mods = "Control";  chars = "\x1b[18;5~"; }
          { key = "F8"; mods = "Control";  chars = "\x1b[19;5~"; }
          { key = "F9"; mods = "Control";  chars = "\x1b[20;5~"; }
          { key = "F10"; mods = "Control";  chars = "\x1b[21;5~"; }
          { key = "F11"; mods = "Control";  chars = "\x1b[23;5~"; }
          { key = "F12"; mods = "Control";  chars = "\x1b[24;5~"; }
          { key = "F1"; mods = "Alt";  chars = "\x1b[1;6P"; }
          { key = "F2"; mods = "Alt";  chars = "\x1b[1;6Q"; }
          { key = "F3"; mods = "Alt";  chars = "\x1b[1;6R"; }
          { key = "F4"; mods = "Alt";  chars = "\x1b[1;6S"; }
          { key = "F5"; mods = "Alt";  chars = "\x1b[15;6~"; }
          { key = "F6"; mods = "Alt";  chars = "\x1b[17;6~"; }
          { key = "F7"; mods = "Alt";  chars = "\x1b[18;6~"; }
          { key = "F8"; mods = "Alt";  chars = "\x1b[19;6~"; }
          { key = "F9"; mods = "Alt";  chars = "\x1b[20;6~"; }
          { key = "F10"; mods = "Alt";  chars = "\x1b[21;6~"; }
          { key = "F11"; mods = "Alt";  chars = "\x1b[23;6~"; }
          { key = "F12"; mods = "Alt";  chars = "\x1b[24;6~"; }
          { key = "F1"; mods = "Super";  chars = "\x1b[1;3P"; }
          { key = "F2"; mods = "Super";  chars = "\x1b[1;3Q"; }
          { key = "F3"; mods = "Super";  chars = "\x1b[1;3R"; }
          { key = "F4"; mods = "Super";  chars = "\x1b[1;3S"; }
          { key = "F5"; mods = "Super";  chars = "\x1b[15;3~"; }
          { key = "F6"; mods = "Super";  chars = "\x1b[17;3~"; }
          { key = "F7"; mods = "Super";  chars = "\x1b[18;3~"; }
          { key = "F8"; mods = "Super";  chars = "\x1b[19;3~"; }
          { key = "F9"; mods = "Super";  chars = "\x1b[20;3~"; }
          { key = "F10"; mods = "Super";  chars = "\x1b[21;3~"; }
          { key = "F11"; mods = "Super";  chars = "\x1b[23;3~"; }
          { key = "F12"; mods = "Super";  chars = "\x1b[24;3~"; }
          { key = "NumpadEnter"; chars = "\n"; }
        ];
      };
    };



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
