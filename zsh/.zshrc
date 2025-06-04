export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="refined"
plugins=(vi-mode)

VI_MODE_SET_CURSOR=true
source $ZSH/oh-my-zsh.sh

export EDITOR=nvim
export VISUAL="$EDITOR"
set -o vi
compinit

eval "$(zoxide init --cmd cd zsh)"


