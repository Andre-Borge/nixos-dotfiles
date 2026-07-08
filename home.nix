{ config, pkgs, ...}:
{
    home.username = "andre";
    home.homeDirectory = "/home/andre";
    home.stateVersion = "26.05";  
    programs.bash = { enable = true; };
    xdg.configFile."i3" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/andre/nixos-dotfiles/config/i3/";
      recursive = true;
    };
    xdg.configFile."nvim" = {
     source = config.lib.file.mkOutOfStoreSymlink "/home/andre/nixos-dotfiles/config/nvim2/";
     recursive = true;
    };

    xdg.configFile."sway" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/andre/nixos-dotfiles/config/sway/";
      recursive = true;
    };

    xdg.configFile."kitty" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/andre/nixos-dotfiles/config/kitty/";
      recursive = true;
    };
    xdg.configFile."i3status" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/andre/nixos-dotfiles/config/sway/i3status/";
      recursive = true;
    };
    home.packages = with pkgs; [
      bat
      qbittorrent
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      sideloadInitLua = true; #seems needed to make init.lua work? 
    };
    programs.fzf.enable = true;

    programs.git = {
      enable = true;
      settings.init.defaultBranch = "main";
      settings.user.name = "Andre Borge";
      settings.user.email = "andreborge1008@gmail.com";
    };
}


