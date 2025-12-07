{ config, pkgs, ...}:
{
    home.username = "andre";
    home.homeDirectory = "/home/andre";
    home.stateVersion = "25.05";
    
    programs.bash = {
      enable = true;

    };
    xdg.configFile."i3" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/andre/nixos-dotfiles/config/i3/";
      recursive = true;
    };
    

    home.packages = with pkgs; [
      neovim
      ripgrep
      fzf
      fd

      bat
      qbittorrent
    ];
}


