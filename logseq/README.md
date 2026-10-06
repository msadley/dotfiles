# Logseq — caelestia theme

Unified color scheme for the `~/logseq` graph via caelestia user templates.

## How it works

- Template: `caelestia/dot-config/caelestia/templates/logseq.css`
  renders to `~/.local/state/caelestia/theme/logseq.css` on every
  `caelestia scheme set`.
- This package stows a symlink:
  `~/logseq/logseq/custom.css -> ~/.local/state/caelestia/theme/logseq.css`
  so Logseq always loads the generated theme. Switching schemes updates
  Logseq after a restart (no re-stow needed).

## Setup

1. Back up the current file (empty by default, but just in case):
   `cp ~/logseq/logseq/custom.css ~/logseq/logseq/custom.css.bak`
2. Stow the package: `cd ~/dotfiles && stow --dotfiles logseq`
   (use `stow --dotfiles -R logseq` if it is already stowed).
3. Regenerate themes: `caelestia scheme set -n <name> -f <flavour> -m <mode> -v <variant>`
   (re-running your current scheme is enough to render `logseq.css`).
4. Restart Logseq (desktop) and re-index if prompted.

## Notes

- Only the `~/logseq` graph is themed (per your choice). For a new graph,
  either symlink its `logseq/custom.css` the same way or copy the import.
- Your Rosé Pine plugin (`~/.logseq/plugins/logseq-rose-pine-theme`) stays
  installed but is superseded by `custom.css`. Disable it in
  Logseq → Settings → Themes if colors look doubled-up.
- To add personal overrides, edit the template, not the generated file.
