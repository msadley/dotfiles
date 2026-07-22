__add_newline=0

precmd() {
  if (( __add_newline )); then
    print ""
  fi
  __add_newline=1
}

alias clear="clear; __add_newline=0"

function _clear_screen_without_newline() {
  __add_newline=0
  zle clear-screen
}
zle -N _clear_screen_without_newline
bindkey '^L' _clear_screen_without_newline

