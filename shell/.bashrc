#!/bin/bash
# Only run in interactive shells
[[ $- != *i* ]] && return

# ---- Sources ----
for f in \
  "$HOME/.profile" \
  "$HOME/.bashsec" \
  "$HOME/.git-prompt.sh" \
  /usr/share/bash-completion/bash_completion \
  /usr/share/fzf/shell/key-bindings.bash \
  /usr/share/doc/fzf/examples/key-bindings.bash \
  "$HOME/tools/source.sh"
do
  [[ -r "$f" ]] && source "$f"
done

export GIT_PS1_SHOWDIRTYSTATE=1

# ---- OpenStack ----
openstack_user() {
  [[ -n "$OS_USERNAME" ]] && printf "OS:%s" "$OS_USERNAME"
}

function openstack_user {
  if [ -n "$OS_USERNAME" ]; then
    echo -n "OS:$OS_USERNAME"
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

  PS1+="$R\t$RES:" # Time

  if [ $EXIT != 0 ]; then
      PS1+="${BR}\u${RES}"      # Add red if exit code non 0
  else
      PS1+="${BG}\u${RES}"      # Green if exit code is 0
  fi

  PS1+="${BG}@\h:${RES}"                                # Hostname
  PS1+="${BB}\w${RES}"                                  # Location
  PS1+='$(__git_ps1 " (%s)") ${RES} '

  PS1+="${Y}$(openstack_user)${RES}"                    # Openstack User
  PS1+="\n${BM}\$ ${RES}"                               # Tail

}

PROMPT_COMMAND=bash_prompt
