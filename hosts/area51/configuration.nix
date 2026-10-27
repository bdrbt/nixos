{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../common/fonts.nix
    ];

  # nix settings
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    # auto-optimize-store = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "area51";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Tashkent";
  i18n.defaultLocale = "en_US.UTF-8";

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  # services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;
  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  #services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  services.devmon.enable = true;
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  users.users.bdrbt = {
    isNormalUser = true;
    initialPassword = "q1w2e3r4";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };


  # hjem settings
  hjem.clobberByDefault = true;
  hjem.users.bdrbt = {
    enable = true;
    directory = "/home/bdrbt";
    imports = [
      ../../modules/commondev
      ../../modules/neovim
      ../../modules/foot
      ../../modules/git
      ../../modules/waybar
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    tree
    wget
    yazi
    btop
    fuzzel
    xwayland-satellite
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableLsColors = true;
    autosuggestions.enable = true;
  };

  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
  };

  system.stateVersion = "26.05"; # Did you read the comment?
}

