local mise_bin="/home/adley/.local/bin/mise"
if [[ -x "$mise_bin" ]]; then
  local cache_dir="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
  local cache_file="$cache_dir/mise.zsh"
  local mise_cfg="$HOME/.config/mise/config.toml"
  local mise_installs="$HOME/.local/share/mise/installs/.mise-installs.toml"

  if [[ ! -f "$cache_file" || "$mise_bin" -nt "$cache_file" || "$mise_cfg" -nt "$cache_file" || "$mise_installs" -nt "$cache_file" ]]; then
    mkdir -p "$cache_dir"
    {
      print -r -- 'export __MISE_ORIG_PATH="$PATH"'
      "$mise_bin" activate zsh 2>/dev/null | sed \
        -e '1{/^export PATH=/d;}' \
        -e 's/^_mise_hook$/# _mise_hook handled below/' \
        -e 's/^export __MISE_ZSH_ACTIVATE_PATH=/# &/' \
        -e 's/^export __MISE_ZSH_ACTIVATE_ENV=/# &/' \
        -e 's/\[ -n "\$(declare -f command_not_found_handler)" \]/(( $+functions[command_not_found_handler] ))/' \
        -e 's/elif \[ -n "\$(declare -f _command_not_found_handler)" \]; then/elif (( $+functions[_command_not_found_handler] )); then/'
      print -r -- 'if [[ -f mise.toml || -f .mise.toml || -f .tool-versions ]]; then'
      print -r -- '  _mise_hook'
      print -r -- '  export __MISE_ZSH_ACTIVATE_PATH="$PATH"'
      print -r -- '  export __MISE_ZSH_ACTIVATE_ENV="$(_mise_hook_env_state)"'
      print -r -- 'else'
      (cd "$HOME" && env -i HOME="$HOME" MISE_SHELL=zsh PATH="__MISE_PATH__" "$mise_bin" hook-env -s zsh 2>/dev/null) \
        | grep -v '^export PATH=__MISE_PATH__$' \
        | sed "s|export PATH='\(.*\):__MISE_PATH__'|  export PATH=\"\1:\$PATH\"|; s|^export __MISE_|  export __MISE_|"
      print -r -- '  export __MISE_ZSH_ACTIVATE_PATH="$PATH"'
      print -r -- '  export __MISE_ZSH_ACTIVATE_ENV="export MISE_SHELL=zsh"'
      print -r -- 'fi'
    } > "$cache_file"
    zcompile "$cache_file"
  fi
  source "$cache_file"
elif (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

