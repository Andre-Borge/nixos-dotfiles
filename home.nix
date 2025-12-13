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
    xdg.configFile."nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/andre/nixos-dotfiles/config/nvim/";
      recursive = true;
    };
    

    home.packages = with pkgs; [
      ripgrep
      fzf
      fd

      bat
      qbittorrent
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        mason-nvim
	kanagawa-nvim ## colorscheme
      ];
    };
}


