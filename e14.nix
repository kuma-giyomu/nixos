# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-18dd3f0f-0e8a-408f-ab2b-874db45506d4".device = "/dev/disk/by-uuid/18dd3f0f-0e8a-408f-ab2b-874db45506d4";

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ja_JP.UTF-8";
    LC_IDENTIFICATION = "ja_JP.UTF-8";
    LC_MEASUREMENT = "ja_JP.UTF-8";
    LC_MONETARY = "ja_JP.UTF-8";
    LC_NAME = "ja_JP.UTF-8";
    LC_NUMERIC = "ja_JP.UTF-8";
    LC_PAPER = "ja_JP.UTF-8";
    LC_TELEPHONE = "ja_JP.UTF-8";
    LC_TIME = "ja_JP.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Deepin Desktop Environment.
  services.xserver.displayManager.lightdm.enable = false;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.bluetooth = {
    enable = true; # enables support for Bluetooth
    powerOnBoot = true; # powers up the default Bluetooth controller on boot
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.guillaume = {
    isNormalUser = true;
    description = "guillaume";
    extraGroups = ["networkmanager" "wheel" "docker"];
    packages = with pkgs; [
      ferdium
      asdf-vm
      taskwarrior
    ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    alejandra
    foot
    zsh
    libnotify
    wget
    curl
    hyprland
    clipman
    wl-clipboard
    fuzzel
    udisks2
    udiskie
    mako
    pcmanfm
    grim
    slurp
    hyprpaper
    waybar
    killall
    ripgrep
    fd
    eza
    delta
    tig
    lazygit
    magic-wormhole-rs
    papirus-icon-theme
    firefox-wayland
    ungoogled-chromium
    pavucontrol
    zoxide
    bat
    fzf
    fzf-zsh
    zenith
    gcc
    gnumake
    vimPlugins.telescope-fzf-native-nvim
    amdvlk
    sshfs
    gimp
    inkscape
    docker
    bottom
    lazydocker
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      (nerdfonts.override {fonts = ["Hack"];})
    ];
    fontconfig = {
      defaultFonts = {
        serif = ["Noto Serif CJK JP" "DejaVu Serif"];
        sansSerif = ["Noto Sans CJK JP" "DejaVu Sans"];
        monospace = ["Noto Sans Mono CJK JP" "DejaVu Sans Mono"];
      };
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.blueman.enable = true;
  services.gvfs.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # gtk = {
  #   enable = true;
  #   gtk3.extraConfig.gtk-decoration-layout = "menu:";
  #   cursorTheme.name = "Qogir";
  #   iconTheme.name = "Papyrus-";
  #   theme.name = "Jasper-Grey-Dark-Compact";
  # };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
    ];
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  programs.git = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
  };

  environment = {
    sessionVariables = {
      INPUT_METHOD = "fcitx";
      QT_IM_MODULE = "fcitx";
      # GTK_IM_MODULE = "fcitx";
      "XMODIFIERS=@im" = "fcitx";
      XIM_SERVERS = "fcitx";
    };
    shellAliases = {
      ls = "eza --icons --group-directories-first";
      zenith = "zenith -c 0 -d 0 -n 0";
      suspend = "systemctl suspend";
      wormhole = "wormhole";
    };
  };

  programs.hyprland = {
    enable = true;
  };

  virtualisation.docker = {
    enable = true;
  };
}
