# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.profile ]] && . ~/.profile

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
  # regular colors
  local K="\[\033[0;30m\]"    # black
  local R="\[\033[0;31m\]"    # red
  local G="\[\033[0;32m\]"    # green
  local Y="\[\033[0;33m\]"    # yellow
  local B="\[\033[0;34m\]"    # blue
  local M="\[\033[0;35m\]"    # magenta
  local C="\[\033[0;36m\]"    # cyan
  local W="\[\033[0;37m\]"    # white

  # emphasized (bolded) colors
  local BK="\[\033[1;30m\]"
  local BR="\[\033[1;31m\]"
  local BG="\[\033[1;32m\]"
  local BY="\[\033[1;33m\]"
  local BB="\[\033[1;34m\]"
  local BM="\[\033[1;35m\]"
  local BC="\[\033[1;36m\]"
  local BW="\[\033[1;37m\]"

  local __user_and_host="\u@\h:"
  local __cur_location="\w"
  local __cur_time="\t"
  local __prompt_tail="\$ \[$(tput sgr0)\]"

  export PS1="$BR$__cur_time:$BG$__user_and_host$BB$__cur_location$BR\$(markup_git_branch \$(git_branch)) $Y$(openstack_user)\n$BM$__prompt_tail"
}

PROMPT_COMMAND=bash_prompt
