# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  # Allow unfree packages eg. nvidia drivers and google chrome
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    #keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  services.xserver = {
    enable = true;
#    windowManager.i3 = {
#      enable = true;
#      extraPackages = with pkgs; [
#        dmenu
#        i3status
#        xfce.xfce4-panel
#      ];
#    };
#    desktopManager = {
#      xterm.enable = false;
#      xfce = {
#        enable = true;
#        noDesktop = true;
#        enableXfwm = false;
#      };
#    };

#    displayManager.lightdm.enable = true;
#    displayManager.lightdm.greeters.gtk.extraConfig = ''user-background = false'';
    displayManager.gdm.enable = true;
    #displayManager.gdm.wayland = false;

    desktopManager.gnome.enable = true;
  };

  #services.displayManager.sddm.enable = true;
  #services.displayManager.defaultSession = "xfce+i3";

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sander = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      firefox
      google-chrome
    ];
  };

  # Enable Flakes feature and accompanying new nix command-line tool
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    neovim # neovim needs clang zig etc. for kickstart.nvim init.lua to work right
    clang
    zig 
    tmux
    tree
    git
    git-credential-manager
    wget
    gparted
    xorg.xbacklight
  ];

  # Set the default editor to vim
  environment.variables.EDITOR = "vim";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  services.syncthing = {
    enable = false;
    dataDir = "/home/sander";
    openDefaultPorts = true;
    configDir = "/home/sander/.config/syncthing";
    user = "sander";
    group = "users";
    guiAddress = "0.0.0.0:8384";
    # declarative = { SNIPPED };
  };

  fonts.fontDir.enable = true;
}
