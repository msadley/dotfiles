autoload -Uz compinit
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zmodload zsh/complist

if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[Z' reverse-menu-complete
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

