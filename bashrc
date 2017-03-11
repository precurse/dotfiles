#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

export VISUAL=nvim
export EDITOR="$VISUAL"

alias vi="nvim"
alias vimdiff="nvim -d"
alias gws="git status --short"
alias gc="git commit"
alias gca="git commit -a"
alias gco="git checkout"
alias ga="git add"
alias gb="git branch"
alias gm="git merge"
alias gps="git push"
alias gpl="git pull"
alias rm="rm -i"
alias pbcopy="xclip -selection clipboard -i"
alias pbpaste="xclip -selection clipboard -o"


if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add
