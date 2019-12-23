#!/bin/bash
## Get OS Variables
if [ -f /etc/os-release ]
then
  # shellcheck disable=SC1091
  . /etc/os-release
else
  echo "WARNING: /etc/os-release not found on this OS. Using 'uname -s'."
  case "$(uname -s)" in
    OpenBSD)
      ID_LIKE="openbsd"
      ;;

    Darwin)
      ID_LIKE="osx"
      ;;

    Linux)
      ID_LIKE="linux-unknown"
      ;;

    CYGWIN*|MINGW32*|MSYS*)
      ID_LIKE="Windows"
      ;;

    *)
      ID_LIKE="Unknown"
      ;;
  esac
fi

# Load system profile if available
if [ -f "/etc/profile" ]; then
    # shellcheck disable=SC1091
    . /etc/profile
fi

# Environment Variables
# You should also set $VISUAL, as some programs (correctly) use that instead of $EDITOR (see VISUAL vs. EDITOR)
VISUAL="vim"
EDITOR="$VISUAL"

PATH="$PATH:/usr/local/sbin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/opt/local/sbin"
PATH="$PATH:/opt/local/bin"
PATH="$PATH:$HOME/node_modules/.bin"
PATH="$PATH:$HOME/bin"
PATH="$PATH:$HOME/.local/bin"

export VISUAL EDITOR PATH

######
## ALIASES
######

alias ..="cd .."
alias ll="ls -lAh | less"
alias cp="cp -i"        # prompt before overwrite
alias mv="mv -i"     # prompt before overwrite
alias rm="rm -i"        # prompt before overwrite
alias df="df -h"        # human readable
alias du="du -h"        # human readable
alias free="free -ht"   # human readable + total
alias mkdir="mkdir -pv" # always make it
alias wget="wget -c"    # continue download

# Use neovim then vim (if available)
if [ -x "$(command -v nvim)" ]; then
  alias vi="nvim"
  alias vim="nvim"
  alias vimdiff="nvim -d"

  # Export as well
  export VISUAL="nvim"
  export EDITOR="$VISUAL"
elif [ -x "$(command -v vim)" ]; then
  alias vi="vim"
fi

# Xclip pasting
if [ -x "$(command -v xclip)" ]; then
  alias pbcopy="xclip -selection clipboard -i"
  alias pbpaste="xclip -selection clipboard -o"
fi

# Git aliases
#
if [ -x "$(command -v git)" ]; then
  alias gws="git status --short"
  alias gs="git status"
  alias gc="git commit"
  alias gca="git commit -a"
  alias gco="git checkout"
  alias ga="git add"
  alias gb="git branch"
  alias gd="git diff"
  alias gdc="git diff --cached"
  alias gm="git merge"
  alias gps="git push"
  alias gpl="git pull"
else
  echo "git executable not found."
fi

#######
## FUNCTIONS
#######

# Up, up, and away
up() {
  ups=""
  # shellcheck disable=SC2034  # i is unused
  for i in $(seq 1 "$1")
  do
    ups=$ups"../"
  done
  cd $ups || exit
}

# list dir contents after cd
cd() { builtin cd "$@" && ls -l; }

# Create dir and go into it
mcd() { mkdir -p "$1"; cd "$1" || exit;}

# remove line n from a file (removeline N FILE)
rmline() { sed -i "$1d" "$2"; }
alias removeline="rmline"

# Clean all OpenStack env variables
os_clean() { unset OS_AUTH_URL OS_TENANT_NAME OS_USERNAME OS_PASSWORD OS_REGION_NAME OS_PROJECT_NAME OS_TENANT_ID OS_IDENTITY_API_VERSION OS_ENDPOINT_TYPE OS_PROJECT_ID OS_INTERFACE; }

# Password generation
genpass() { < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c"${1:-32}";echo; }

dockshell() {

    if [ "$#" -eq 0 ]; then
        IMAGE=precurse/security-tools
    elif [ "$#" -eq 1 ]; then
        IMAGE=$1
    else
        echo "Usage: ${FUNCNAME[0]} [image name]"
        return
    fi

    docker run -v "${PWD}":"${PWD}" --user "${UID}":"$(id -g)" -w "${PWD}" -it "${IMAGE}" /bin/sh
}

######
## OS-specific
######

# OpenBSD
if case ${ID_LIKE} in openbsd*) ;; *) false;; esac; then
  alias mkdir="mkdir -p" # always make it
  alias reboot="doas shutdown -r now"
  alias shutdown="doas shutdown -p now"

  genpass() { < /dev/urandom strings -n1 | tr -dc _A-Z-a-z-0-9 | dd count=1 bs=32 2>/dev/null;echo; }
  sudo() { doas "$@"; }
fi

# OSX
if case ${ID_LIKE} in osx*) ;; *) false;; esac; then
  PATH="$PATH:$HOME/Library/Python/2.7/bin"
fi

# Exit earlier if non-interactive. Don't want aliases or SSH-agent setup on login shells
case $- in
  *i*) :;;
  *) echo "Not running interactively. Exiting early." && return;;
esac

####
## SSH AGENT
####
SSH_ENV="$HOME/.ssh/environment"

start_agent() {
  echo "Initialising new SSH agent..."
  env ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  # shellcheck source=/home/piranha/.ssh/environment
  . "${SSH_ENV}" > /dev/null
  env ssh-add;
}

# Source SSH settings, if applicable
# SSH_AUTH_SOCKET for ssh-agent forwarding
if [ ! -z "${SSH_AUTH_SOCK}" ]; then
  echo "Forwarded SSH Agent Found"

elif [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps -p ${SSH_AGENT_PID} > /dev/null || {
      start_agent;
  }
else
  start_agent;
fi
