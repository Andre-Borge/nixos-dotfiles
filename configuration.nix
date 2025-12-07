# configuration.nix
{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  ## Boot / System basics

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking = {
    hostname = "nix";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Oslo";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nixpkgs.allowUnfree = true;
  system.stateVersion = "25.05";

  ## Graphics / Display / Window manager(s)
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.i3.enable = true;
  };
  services.displayManager.ly.enable = true;

  hardware.graphics = {
	  enable = true;
	  enable32Bit = true;
  };
  
  hardware.nvidia = {
    modesetting.enable = true;
	  powerManagement.enable = true;
	  open = false;
	  package = config.boot.kernelPackages.nvidiaPackages.production;
  };

  ## Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.pulseaudio.enable = false;
  
  ## Users
  users.users.andre = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
  };
  ## System Packages
  environment.systemPackages = with pkgs; [
    wget
    librewolf
    firefox
    kitty
    pavucontrol
    tree-sitter
    docker
    unzip
    tree
    notepadqq ## notepad++ replica
    
    ## Tools required for Telescope(vim)
    
    # language servers/languages
    rust-analyzer # rust
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted # json, html, css language servers
    nodePackages.eslint
    nodePackages.eslint_d
    lua-language-server 
    php
    mysql84 
    lua
    nodejs
    python3
    go
    mariadb
    
   
    # programming
    vim
    gcc # compiler
    
    ## torrents
    qbittorrent 
   

    ## gaming
    mangohud # cpu, gpu etc info
    protonup
    htop
];
  ## Services

  programs.nix-ld.enable = true;
  programs.git.enable = true;
  programs.vim.enable = true;
  programs.gamemode.enable = true; 
  programs.steam.enable = true;

  services.postgresql.enable = true;
  services.picom.enable = true;

  services.mysql = {
    enable = true;
    package = pkgs.mariadb;
  };
  





  services.xserver.videoDrivers = ["nvidia"];

 
  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
	    "/home/user/.steam/root./compatibilitytools.d";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json";
    STEAM_USE_VULKAN = "1";
  };
 



  fonts.packages = with pkgs; [
	  fira-code
	  nerd-fonts.jetbrains-mono
  ];

}

