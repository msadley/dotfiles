export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
if (( $+commands[starship] )); then
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
  local cache_file="$cache_dir/starship.zsh"
  local starship_bin="${commands[starship]}"
  if [[ -f "$cache_file" && "$cache_file" -nt "$starship_bin" ]]; then
    source "$cache_file"
  else
    mkdir -p "$cache_dir"
    starship init zsh > "$cache_file" 2>/dev/null && source "$cache_file"
  fi
fi

