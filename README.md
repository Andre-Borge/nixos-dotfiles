# Personal NixOS System Configuration

A reproducible, desktop-focused NixOS setup managed using **Nix Flakes** and **Home Manager**

## System Hardware
- **CPU:** Ryzen 7 9700X
- **GPU:** RX 9070 XT
- **RAM:** 32 GB DDR5
- **Window Manager:** Sway (Wayland)
- **Monitors:** Dual display setup (1920x1080p @ 244Hz, 1440p @ 144Hz)

## Configuration

### Flakes
- Uses `flake.nix` as the central system entry point
- Combines the stable channel with `nixpkgs-unstable` passed to `configuration.nix` to access unstable packages where needed

### Reproducible Home Environment
- Uses `home-manager` for user-level and config configuration
- Custom dotfiles are symlinked into `~/.config` using `mkOutOfStoreSymlink`. This allows for updating program configs without having to rebuild system
```nix
xdg.configFile."sway" = {
  source = config.lib.file.mkOutOfStoreSymlink "home/<user>/nixos-dotfiles/config/sway/";
  recursive = true;
};
```
- nix garbage collector that weekly removes old generations after 30 days
```nix
nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 30d";
};
```
### Window manager and Workflows
- Hotkey for grim and slurp to take and automatically save screenshots to ```~/Pictures``` with timestamps and copies them to clipboard using ```wl-clipboard```

```sway
bindsym $mod+shift+g exec slurp | grim -g - - | tee ~/Pictures/$(date +%s).png | wl-copy
```


## Deployment & System Rebuilds

The system configuration is in `~/nixos-dotfiles` rather than the default `/etc/nixos` location to keep all dotfiles, Flakes, and other within a single repository.

To apply system updates and rebuild the environment

```bash
sudo nixos-rebuild switch --flake ~/nixos-dotfiles#<nixosConfigurations.nixos>
```
> Make sure the `nixosConfigurations.nixos` corresponds to what you have set in flake.nix(eg. nixosconfigurations.example would be #example) 

