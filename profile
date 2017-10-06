## Get OS Variables
if [ -f /etc/os-release ]
then
  . /etc/os-release
else
  echo "WARNING: /etc/os-release not found on this OS. Using 'uname -s'."
  case "$(uname -s)" in
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

PATH="$PATH:$HOME/node_modules/.bin"
PATH="$PATH:$HOME/bin"
PATH="$PATH:$HOME/.local/bin"
PATH="$PATH:/usr/local/sbin"
PATH="$PATH:/usr/local/bin"
PATH="$PATH:/opt/local/sbin"
PATH="$PATH:/opt/local/bin"

export VISUAL EDITOR PATH

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

# Use neovim then vim (if neovim not available)
if which nvim > /dev/null 2>&1; then
  alias vi="nvim"
  alias vim="nvim"
  alias vimdiff="nvim -d"
elif which vim > /dev/null 2>&1; then
  alias vi="vim"
fi

alias pbcopy="xclip -selection clipboard -i"
alias pbpaste="xclip -selection clipboard -o"

# Git
#
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

## FUNCTIONS

function up {
  local ups=""
  for i in $(seq 1 $1)
  do
    ups=$ups"../"
  done
  cd $ups
}

# list dir contents after cd
function cd () { builtin cd "$@" && ls -l; }

# remove line n from a file (removeline N FILE)
function removeline () { sed -i $1d $2; }

# Clean all OpenStack env variables
function os_clean { unset OS_AUTH_URL OS_TENANT_NAME OS_USERNAME OS_PASSWORD OS_REGION_NAME OS_PROJECT_NAME; }


## OS-specific Stuff
##
if case ${ID_LIKE} in arch*) ;; *) false;; esac; then
  alias pacfetch="sudo pacman --sysupgrade --sync --refresh --downloadonly"
  alias pacupdate="sudo pacman --sysupgrade --sync --refresh"

  function pacdep { comm -12 <(pactree -srl $1 | sort) <(pacman -Qq | sort); }
fi

## SSH AGENT
##
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
## / SSH AGENT ##


