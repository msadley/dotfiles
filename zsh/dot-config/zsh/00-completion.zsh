autoload -Uz compinit up-line-or-beginning-search down-line-or-beginning-search

zmodload zsh/complist

local zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
if [[ -f "$zcompdump" ]]; then
  compinit -C -d "$zcompdump"
  if [[ ! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc" ]] || () { setopt localoptions extendedglob; [[ -n ${zcompdump}(#qN.mh+24) ]]; }; then
    {
      autoload -Uz compinit
      compinit -d "$zcompdump"
      zcompile "$zcompdump"
    } &!
  fi
else
  compinit -d "$zcompdump"
  zcompile "$zcompdump"
fi

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey '^[[Z' reverse-menu-complete
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

