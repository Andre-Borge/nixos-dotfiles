# configuration.nix
{ config, lib, pkgs, pkgsUnstable, ... }:
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
  environment.systemPackages = [
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
    pkgs.nodePackages.typescript
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.vscode-langservers-extracted # json, html, css language servers
    pkgs.nodePackages.eslint
    pkgs.nodePackages.eslint_d
    pkgs.lua-language-server 
		pkgs.lua
    pkgs.ruff
    pkgs.go
		pkgs.gopls
    pkgs.mariadb
    
   
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
		pkgs.lutris
		pkgs.pciutils
	#	openrgb
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
programs.steam.enable = true;
programs.appimage.enable = true;
programs.appimage.binfmt = true;
services.postgresql.enable = true;
services.picom.enable = true;
services.flatpak.enable = true;
services.udev.packages = [ pkgs.openrgb ];
services.hardware.openrgb = {
	enable = true;
	package = pkgs.openrgb-with-all-plugins;
	motherboard = "amd";
};
#hardware.i2c.enable = true;
xdg.portal = {
	enable = true;
	wlr.enable = true;
};
services.xserver.videoDrivers = ["amdgpu"];
boot.kernelModules = ["amdgpu" "i2c-dev" "i2c-piix4" "i2c-nct6775"];
boot.kernelParams = [ "acpi_enforce_resources=lax" ];
environment.sessionVariables = {
	STEAM_EXTRA_COMPAT_TOOLS_PATHS =
		"home/user/.steam/root/compatibilitytools.d";
};
fonts.packages = with pkgs; [
	fira-code
	nerd-fonts.jetbrains-mono
];




	
}

