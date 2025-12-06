# configuration.nix
{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

networking.hostName = "nix"; # hostname.
networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

nix.settings.experimental-features = [ "nix-command" "flakes" ];
# Time zone.
time.timeZone = "Europe/Oslo";

services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
    windowManager.i3.enable = true;
};
services.displayManager.ly.enable = true;

users.users.andre = {
  isNormalUser = true;
  extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  packages = with pkgs; [
    tree
  ];
};

environment.systemPackages = with pkgs; [
    # programs
  wget
  librewolf
  firefox
  kitty
  pavucontrol
  tree-sitter
    docker
    unzip
    notepadqq ## notepad++ replica
    
    ## Tools required for Telescope(vim)
    ripgrep
    fd
    fzf
    
    # language servers/languages
    rust-analyzer # rust
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted # json, html, css language servers
    nodePackages.eslint
    nodePackages.eslint_d
    lua-language-server 
    php
    intelephense # php language server
    mysql84 
    lua
    nodejs
    python3
    pyright ## Python lsp
    go
    gopls ## golang lsp
    postgresql
    mariadb
   
    # programming
    git
    neovim
    vim
    gcc # compiler
    docker
    
    ## torrents
    stremio
    qbittorrent 
   

    ## gaming
    mangohud # cpu, gpu etc info
    protonup
    htop
];
  
	
system.stateVersion = "25.05"; 
  

# Enable unfree software
nixpkgs.config = {
	allowUnfree = true;
};

### audio
services.pipewire.enable = false;
services.pulseaudio.enable = true;


programs.nix-ld.enable = true;
programs.git.enable = true;
programs.vim.enable = true;
services.postgresql.enable = true;
services.picom.enable = true;

services.mysql = {
   enable = true;
   package = pkgs.mariadb;
};

programs.gamemode.enable = true; 

  
  ## drivers
hardware.graphics = {
	enable = true;
	enable32Bit = true;
};

services.xserver.videoDrivers = ["nvidia"];

hardware.nvidia = {
  	modesetting.enable = true;
	powerManagement.enable = true;
	open = false;
	package = config.boot.kernelPackages.nvidiaPackages.production;
};
 
environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
	"/home/user/.steam/root./compatibilitytools.d";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json";
    STEAM_USE_VULKAN = "1";
};
 
programs.steam.enable = true;



 ## fonts
fonts.packages = with pkgs; [
	fira-code
	nerd-fonts.jetbrains-mono
];

}

