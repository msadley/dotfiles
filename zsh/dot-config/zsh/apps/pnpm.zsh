export PNPM_HOME="/home/adley/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *)
    export PATH="$PNPM_HOME/bin:$PATH"
    [[ -n "${__MISE_ORIG_PATH:-}" ]] && export __MISE_ORIG_PATH="$PNPM_HOME/bin:$__MISE_ORIG_PATH"
    [[ -n "${__MISE_ZSH_ACTIVATE_PATH:-}" ]] && export __MISE_ZSH_ACTIVATE_PATH="$PATH"
    ;;
esac

