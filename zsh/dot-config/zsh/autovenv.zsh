autoload -U add-zsh-hook

export VIRTUAL_ENV_DISABLE_PROMPT=1

_auto_venv() {
  if [[ -n "$VIRTUAL_ENV" ]]; then
    local venv_parent="${VIRTUAL_ENV%/*}"
    if [[ "$PWD"/ != "$venv_parent"/* && "$PWD" != "$venv_parent" ]]; then
      deactivate
    fi
  fi

  if [[ -z "$VIRTUAL_ENV" ]]; then
    for dir in .venv venv env .env; do
      if [[ -f "$PWD/$dir/bin/activate" ]]; then
        source "$PWD/$dir/bin/activate"
        break
      fi
    done
  fi
}

add-zsh-hook chpwd _auto_venv
_auto_venv

