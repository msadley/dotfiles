# Set PATH Variable
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Set main directory
export ZSH="$HOME/.oh-my-zsh"

# Completion cache directory
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# Color theme
export ZSH_THEME="robbyrussell"

# Add waiting dots to completion process
export COMPLETION_WAITING_DOTS="true"

# Set separate custom aliases config
export ZSH_CUSTOM=$HOME/.zsh-custom

# Exporting lang config
export LANG=pt_BR.UTF-8

# Set auto update every week without asking
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7

# Plugin configuration
plugins=(git)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh