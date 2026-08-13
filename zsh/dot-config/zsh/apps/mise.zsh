local mise_bin="/home/adley/.local/bin/mise"
if [[ -x "$mise_bin" ]]; then
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
  local cache_file="$cache_dir/mise.zsh"
  if [[ -f "$cache_file" && "$cache_file" -nt "$mise_bin" ]]; then
    source "$cache_file"
  else
    mkdir -p "$cache_dir"
    "$mise_bin" activate zsh > "$cache_file" 2>/dev/null && source "$cache_file"
  fi
elif (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

