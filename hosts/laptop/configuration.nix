{
  pkgs,
  inputs,
  lib,
  config,
  outputs,
  ...
}: {
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };

  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    # Add overlays your own flake exports (from overlays and pkgs dir):
    outputs.overlays.modifications
    outputs.overlays.stable-packages
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-89e1723a-9109-4cdf-a6f0-eae2778f252a".device = "/dev/disk/by-uuid/89e1723a-9109-4cdf-a6f0-eae2778f252a";
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "notascam"; # Define your hostname.
  # networking.wireless.enable = true; # Enables wireless support wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.firewall = {
    allowedTCPPortRanges = [
      # spice
      {
        from = 5900;
        to = 5999;
      }
    ];
    allowedTCPPorts = [
      # libvirt
      16509
    ];
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.defaultSession = "hyprland";
  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-mocha";
  };
  # services.xserver.desktopManager.plasma5.enable = true;

  # Gnome DE
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;

  programs.hyprland.enable = true;

  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (
        subject.isInGroup("users")
          && (
            action.id == "org.freedesktop.login1.reboot" ||
            action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
            action.id == "org.freedesktop.login1.power-off" ||
            action.id == "org.freedesktop.login1.power-off-multiple-sessions"
          )
        )
      {
        return polkit.Result.YES;
      }
    })
  '';

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  programs.bash = {
    interactiveShellInit = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.logan = {
    isNormalUser = true;
    description = "Logan Roberts";
    extraGroups = ["networkmanager" "wheel" "libvirtd" "docker"];
    shell = pkgs.bash;
    packages = with pkgs; [
      stable.firefox
      stable.xsel
      stable.git
      stable.steam-run # useful to emulate a standard file system for some applications
      stable.dolphin
      okular
      stable.libreoffice
      (pkgs.writeShellScriptBin "rebuild-system" ''
        rm ~/.gtkrc-2.0
        sudo nixos-rebuild switch --flake $HOME/nixos#laptop
      '')
    ];
  };
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  fonts = {
    fontDir.enable = true;
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
      source-code-pro
      noto-fonts
      noto-fonts-emoji-blob-bin
      carlito
      dejavu_fonts
      ipafont
      kochi-substitute
      ttf_bitstream_vera
      noto-fonts-cjk
    ];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {"logan" = import ./home.nix;};
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  services.flatpak.enable = true;
  environment.systemPackages = with pkgs; [
    stable.vim
    stable.unzip
    stable.appimage-run
    stable.virtiofsd
    stable.virtio-win
    stable.pulseaudio
    stable.distrobox
    stable.openssl
    stable.glibc

    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
    libsForQt5.breeze-qt5
    libsForQt5.qt5ct
    libsForQt5.breeze-icons
    kdePackages.qt6ct
    (callPackage ./sddm-theme.nix {})
  ];
  virtualisation.docker.enable = true;

  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [fcitx5-mozc fcitx5-with-addons];
  };

  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    QT_QPA_PLATFORMTHEME = "qt5ct";

    # Not officially in the specification
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = ["${XDG_BIN_HOME}"];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        ovmf.enable = true;
        ovmf.packages = [pkgs.OVMFFull.fd];
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
  programs.virt-manager.enable = true;

  services.power-profiles-daemon.enable = false;

  security.pam.services.swaylock = {};

  system.stateVersion = "23.11";
}
