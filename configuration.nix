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
    hostName = "nix";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Oslo";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";

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
  

  ## Audio 
  services.pipewire.enable = false;
  services.pulseaudio = {
    enable = true;
    support32Bit = true;
  };

  
  ## Users
  users.users.andre = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; 
  };
  ## System Packages
  environment.systemPackages = with pkgs; [
    wget
    librewolf
    kitty
    pavucontrol
    tree-sitter
    docker
    unzip
    tree
    feh
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
    pyright
    ruff
    go
		gopls
    mariadb
    
   
    # programming
    vim
    gcc # compiler
    
    ## torrents
    qbittorrent 
   

    ## gaming
    mangohud # cpu, gpu etc info
    htop
    protonup-ng
];
  ## Services

  programs.nix-ld.enable = true;
  programs.vim.enable = true;
  programs.gamemode.enable = true; 
	programs.steam.enable = true;
	services.postgresql.enable = true;
	services.picom.enable = true;

	services.mysql = {
		enable = true;
		package = pkgs.mariadb;
	};


	services.xserver.videoDrivers = ["amdgpu"];

	environment.sessionVariables = {
		STEAM_EXTRA_COMPAT_TOOLS_PATHS =
			"home/user/.steam/root/compatibilitytools.d";
	};

	fonts.packages = with pkgs; [
		fira-code
			nerd-fonts.jetbrains-mono
	];
}

