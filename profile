## Get OS Variables
if [ -f /etc/os-release ]
then
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

# Use ack for FZF fuzzy finder
if [ -x "$(command -v fzf)" ]; then
  if [ -x "$(command -v ack)" ] ; then
    export FZF_DEFAULT_COMMAND='ack -f'
  else
    export FZF_DEFAULT_COMMAND="find . -type f -print -o -type l -print 2> /dev/null | sed s/^..//"
  fi
fi

# ALIASES
#
alias ..="cd .."
alias ll="ls -lAh | less"
alias cp="cp -i"    # prompt before overwrite
alias mv="mv -i -u" # prompt before overwrite / move only if source file newer
alias rm="rm -i"    # prompt before overwrite
alias df="df -h"    # human readable
alias mkdir="mkdir -p" # always make it
alias genpass="< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;"

# Use neovim then vim (if available)
if [ -x "$(command -v nvim)" ]; then
  alias vi="nvim"
  alias vim="nvim"
  alias vimdiff="nvim -d"
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
  alias gm="git merge"
  alias gps="git push"
  alias gpl="git pull"
else
  echo "git executable not found."
fi

## FUNCTIONS

# Up, up, and away
up() {
  ups=""
  for i in $(seq 1 $1)
  do
    ups=$ups"../"
  done
  cd $ups
}

# list dir contents after cd
cd() { builtin cd "$@" && ls -l; }

# remove line n from a file (removeline N FILE)
removeline() { sed -i $1d $2; }

# Clean all OpenStack env variables
os_clean() { unset OS_AUTH_URL OS_TENANT_NAME OS_USERNAME OS_PASSWORD OS_REGION_NAME OS_PROJECT_NAME; }


## OS-specific Stuff
##

# Arch Linux
if case ${ID_LIKE} in arch*) ;; *) false;; esac; then
  alias pacfetch="sudo pacman --sysupgrade --sync --refresh --downloadonly"
  alias pacupdate="sudo pacman --sysupgrade --sync --refresh"

  #pacdep() { comm -12 <(pactree -srl $1 | sort) <(pacman -Qq | sort); }
fi

if case ${ID_LIKE} in openbsd*) ;; *) false;; esac; then
  alias sudo="doas $@"
  alias reboot="doas shutdown -r now"
  alias shutdown="doas shutdown -p now"

  alias mv="mv -i"

  # i3 in openbsd needs TERMINAL set since it doesn't have i3-sensible-terminal
  TERMINAL="urxvt"
fi

####
## SSH AGENT
####
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
  echo "Initialising new SSH agent..."
  env ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
  echo succeeded
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}" > /dev/null
  env ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps -p ${SSH_AGENT_PID} > /dev/null || {
      start_agent;
  }
else
  start_agent;
fi
