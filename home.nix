{ config, pkgs, ...}:
{
    home.username = "andre";
    home.homeDirectory = "/home/andre";
    home.stateVersion = "25.11";  
    programs.bash = {
      enable = true;
    };
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

    home.packages = with pkgs; [
      bat
      qbittorrent
    ];

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      plugins = with pkgs.vimPlugins; [
        mason-nvim
        kanagawa-nvim ## colorscheme
        LazyVim
      ];
      extraPackages = [ pkgs.ripgrep pkgs.fzf pkgs.fd ];
    };
    programs.fzf.enable = true;

		programs.git = {
			enable = true;
			settings = {
				init.defaultBranch = "main";
			};
		};
}


