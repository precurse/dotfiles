# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[ -f ~/.profile ] && . ~/.profile
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

function openstack_user {
  if [ -n "$OS_USERNAME" ]; then
    echo -n "OS:$OS_USERNAME"
  fi
}

function git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* (*\([^)]*\))*/\1/'
}

function markup_git_branch {
  if [[ -n $@ ]]; then
    if [[ -z $(git status --porcelain 2> /dev/null | tail -n1) ]]; then
      echo -e " \001\033[32m\002($@)\001\033[0m\002"
    else
      echo -e " \001\033[31m\002($@)\001\033[0m\002"
    fi
  fi
}

function bash_prompt {
  local EXIT="$?"             # This needs to be first

  # regular colors
  local K="\[\e[0;30m\]"    # black
  local R="\[\e[0;31m\]"    # red
  local G="\[\e[0;32m\]"    # green
  local Y="\[\e[0;33m\]"    # yellow
  local B="\[\e[0;34m\]"    # blue
  local M="\[\e[0;35m\]"    # magenta
  local C="\[\e[0;36m\]"    # cyan
  local W="\[\e[0;37m\]"    # white

  # emphasized (bolded) colors
  local BK="\[\e[1;30m\]"
  local BR="\[\e[1;31m\]"
  local BG="\[\e[1;32m\]"
  local BY="\[\e[1;33m\]"
  local BB="\[\e[1;34m\]"
  local BM="\[\e[1;35m\]"
  local BC="\[\e[1;36m\]"
  local BW="\[\e[1;37m\]"

  local RES="\[\e[0m\]"

  PS1=""

  PS1+="$BR\t$RES:" # Time

  if [ $EXIT != 0 ]; then
      PS1+="${BR}\u${RES}"      # Add red if exit code non 0
  else
      PS1+="${BG}\u${RES}"      # Green if exit code is 0
  fi

  PS1+="${BG}@\h:${RES}"                                # Hostname
  PS1+="${BB}\w${RES}"                                  # Location
  PS1+="${BR}\$(markup_git_branch \$(git_branch)) ${RES}" # Git
  PS1+="${Y}$(openstack_user)${RES}"                    # Openstack User
  PS1+="\n${BM}\$ ${RES}"                               # Tail

}

PROMPT_COMMAND=bash_prompt
