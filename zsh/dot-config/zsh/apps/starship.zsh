export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
local starship_bin="/usr/bin/starship"
[[ -x "$starship_bin" ]] || starship_bin="${commands[starship]}"

if [[ -n "$starship_bin" ]]; then
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
  local cache_file="$cache_dir/starship.zsh"
  if [[ ! -f "$cache_file" || "$starship_bin" -nt "$cache_file" ]]; then
    mkdir -p "$cache_dir"
    "$starship_bin" init zsh 2>/dev/null \
      | sed "s|^PROMPT2=\"\$($starship_bin prompt --continuation)\"|PROMPT2='\$($starship_bin prompt --continuation)'|" \
      > "$cache_file"
    zcompile "$cache_file"
  fi
  source "$cache_file"
fi

