# Personal NixOS System Configuration

A reproducible, desktop-focused NixOS setup managed using **Nix Flakes** and **Home Manager**.

## System Hardware
- **CPU:** Ryzen 7 9700X
- **GPU:** RX 9070 XT
- **RAM:** 32 GB DDR5
- **Window Manager:** Sway (Wayland)
- **Monitors:** Dual display setup (1920x1080p @ 244Hz, 1440p @ 144Hz)

## Configuration

### Flakes
- Uses `flake.nix` as the central system entry point.
- Combines the stable channel with `nixpkgs-unstable` passed to `configuration.nix` to access unstable packages where needed.

### Reproducible Home Environment
- Uses `home-manager` for user-level configuration.
- Custom dotfiles are symlinked out-of-store directly into `~/.config` using `mkOutOfStoreSymlink`. This allows for editing configs without having to rebuild system:

```nix
xdg.configFile."sway" = {
  source = config.lib.file.mkOutOfStoreSymlink "/home/andre/nixos-dotfiles/config/sway/";
  recursive = true;
};
```
### Window manager and Workflows
-
- Hotkey for grim and slurp to take and automatically save screenshots to ```~/Pictures``` with timestamps and copies them to clipboard using ```wl-clipboard```:

```bindsym $mod+shift+g exec slurp | grim -g - - | tee ~/Pictures/$(date +%s).png | wl-copy```
