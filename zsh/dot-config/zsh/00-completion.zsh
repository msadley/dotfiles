autoload -Uz compinit
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zmodload zsh/complist

local zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ ! -f "$zcompdump" ]] || () { setopt localoptions extendedglob; [[ -n ${zcompdump}(#qN.mh+24) ]]; }; then
  compinit -d "$zcompdump"
else
  compinit -C -d "$zcompdump"
fi

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[Z' reverse-menu-complete
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

