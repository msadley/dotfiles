autoload -Uz add-zsh-hook

__newline_pending=0

_screen_prompt_preexec() {
  __newline_pending=1
}

_screen_prompt_precmd() {
  if (( __newline_pending )); then
    print ""
    __newline_pending=0
  fi
}

add-zsh-hook preexec _screen_prompt_preexec
add-zsh-hook precmd _screen_prompt_precmd

alias clear="clear; __newline_pending=0"

function _clear_screen_without_newline() {
  __newline_pending=0
  zle clear-screen
}
zle -N _clear_screen_without_newline
bindkey '^L' _clear_screen_without_newline

function _accept_line_or_do_nothing() {
  if [[ -z "${BUFFER//[[:space:]]/}" ]]; then
    return 0
  fi
  zle accept-line
}
zle -N _accept_line_or_do_nothing
bindkey '^M' _accept_line_or_do_nothing
bindkey '^J' _accept_line_or_do_nothing
