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
    windowManager.i3.enable = false;
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
		xclip # to enable clipboard support for neovim on x11
		virtualbox
    ## Tools required for Telescope(vim)
		 
    # language servers/languages
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted # json, html, css language servers
    nodePackages.eslint
    nodePackages.eslint_d
    lua-language-server 
		lua
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
		wofi
		wine
		rusty-path-of-building
		lutris
		pciutils
#		openrgb
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
programs.steam.enable = true;
programs.appimage.enable = true;
programs.appimage.binfmt = true;
services.postgresql.enable = true;
services.picom.enable = true;
services.flatpak.enable = true;
#services.hardware.openrgb = {
#	enable = true;
#	package = pkgs.openrgb-with-all-plugins;
#	motherboard = "amd";
#};
#hardware.i2c.enable = true;
xdg.portal = {
	enable = true;
	wlr.enable = true;
};
services.xserver.videoDrivers = ["amdgpu"];
boot.kernelModules = ["amdgpu" "i2c-dev"];

environment.sessionVariables = {
	STEAM_EXTRA_COMPAT_TOOLS_PATHS =
		"home/user/.steam/root/compatibilitytools.d";
};
fonts.packages = with pkgs; [
	fira-code
	nerd-fonts.jetbrains-mono
];




	
}

