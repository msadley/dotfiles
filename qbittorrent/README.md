# qBittorrent — caelestia folder theme

Unified color scheme for qBittorrent 5.x (Qt6) using the supported
folder-theme mode: a directory containing `config.json` + `stylesheet.qss`.
No `.qbtheme` compilation needed.

## How it works

- Templates in `caelestia/dot-config/caelestia/templates/`:
  - `qbittorrent-config.json` → `~/.local/state/caelestia/theme/qbittorrent-config.json`
    (QPalette + TransferList + Log colors)
  - `qbittorrent-stylesheet.qss` → `~/.local/state/caelestia/theme/qbittorrent-stylesheet.qss`
- This package stows:
  - `~/.config/qBittorrent/themes/caelestia/config.json -> .../theme/qbittorrent-config.json`
  - `~/.config/qBittorrent/themes/caelestia/stylesheet.qss -> .../theme/qbittorrent-stylesheet.qss`
  so switching schemes updates qBittorrent after a restart.

## Setup (one time)

1. Stow: `cd ~/dotfiles && stow --dotfiles qbittorrent`
2. Regenerate: `caelestia scheme set -n <name> -f <flavour> -m <mode> -v <variant>`
   (re-running the current scheme renders the two files).
3. In qBittorrent: Tools → Preferences → Behavior → Interface →
   check “Use custom UI Theme” and select
   `~/.config/qBittorrent/themes/caelestia/config.json`
   (pick the `config.json` file itself, not the folder).
4. Apply and restart qBittorrent.

## Notes

- If the file picker filters for `*.qbtheme`, change the filter to
  “All files” to select `config.json` — folder themes are supported
  (`FolderThemeSource` in `uithememanager.cpp`).
- To stop using it, uncheck “Use custom UI Theme” and restart.
