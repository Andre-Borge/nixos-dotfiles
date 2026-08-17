{ config, lib, pkgs, pkgsUnstable, freesmlauncher, ... }: {
  imports = [ 
      ./hardware-configuration.nix
      ./config/rgb/default.nix
  ];
#  networking.wireguard.enable = true;
##  networking.wg-quick.interfaces.protonvpn = {
##   configFile = "/etc/wireguard/protonvpn.conf";
##  };
  ## Boot / System basics

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking = {
    hostName = "nix";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Oslo";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";

  ## Graphics / Display / Window manager(s)
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.i3.enable = false;
  };
  services.displayManager.ly.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  ## Audio 
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    jack.enable = true;
  };
  hardware.pulseaudio.enable = false;

  users.users.andre = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
  };
  ## System Packages
  environment.systemPackages = [
    freesmlauncher.packages.${pkgs.system}.default
    ##pkgsUnstable.proton-vpn
    ##pkgsUnstable.wireguard-tools
    pkgs.python3
    pkgs.wl-clipboard
    pkgs.grim
    pkgs.slurp
    pkgs.vulkan-tools
    pkgs.easyeffects
    pkgs.i3status
    pkgs.jdk25 
    pkgs.jdk21
    pkgs.unrar
    pkgs.wget
    pkgs.librewolf
    pkgs.kitty
    pkgs.pavucontrol
    pkgs.tree-sitter
    pkgs.docker
    pkgs.unzip
    pkgs.tree
    pkgs.feh
    pkgs.xclip # to enable clipboard support for neovim on x11
    pkgs.virtualbox
    ## Tools required for Telescope(vim)
    # language servers/languages
    pkgs.lua-language-server 
    pkgs.lua
    pkgs.ruff
    pkgs.go
    pkgs.gopls
    pkgs.mariadb
    pkgs.lsfg-vk-ui
    pkgs.lsfg-vk
    pkgs.openssl # cryptographic libary
    # programming
    pkgs.vim
    pkgs.gcc # compiler
    ## torrents
    pkgs.qbittorrent 
    pkgs.lm_sensors
    ## gaming
    pkgs.mangohud # cpu, gpu etc info
    pkgs.htop
    pkgs.protonup-ng
    pkgs.wofi
    pkgs.wine
    pkgsUnstable.heroic
    pkgs.pciutils
    pkgs.i2c-tools
    pkgsUnstable.rusty-path-of-building

];
  ## Services
programs.sway = {
  enable = true;
  wrapperFeatures.gtk = true;
};
programs.firefox.enable = true;
programs.xwayland.enable = true;
programs.nix-ld.enable = true;
programs.vim.enable = true;
programs.gamemode.enable = true; 
programs.gamescope.enable = true;
programs.steam = {
  enable = true;
  extraCompatPackages = with pkgs; [
    proton-ge-bin
  ];
};
programs.appimage.enable = true;
programs.appimage.binfmt = true;
services.postgresql.enable = true;
services.flatpak.enable = true;
xdg.portal = {
  enable = true;
  wlr.enable = true;

  extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];
};
services.xserver.videoDrivers = ["amdgpu"];
boot.kernelPackages = pkgs.linuxPackages_latest;
boot.kernelParams = ["clearcpuid=umip"];
boot.kernelModules = ["amdgpu"];
environment.sessionVariables = {
  STEAM_EXTRA_COMPAT_TOOLS_PATHS =
    "home/user/.steam/root/compatibilitytools.d";
};

fonts.packages = with pkgs; [
  fira-code
  nerd-fonts.jetbrains-mono
];

}

