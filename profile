## Environment Variables

# You should also set $VISUAL, as some programs (correctly) use that instead of $EDITOR (see VISUAL vs. EDITOR)
VISUAL="vim"
EDITOR="$VISUAL"
PATH="$HOME/bin:$HOME/.local/bin:$HOME/node_modules/.bin:$PATH"

export VISUAL EDITOR PATH

## ALIASES

alias ..="cd .."
alias ll="ls -lAh | less"
alias cp="cp -i"    # prompt before overwrite
alias mv="mv -i -u" # prompt before overwrite / move only if source file newer
alias rm="rm -i"    # prompt before overwrite
alias df="df -h"    # human readable
alias mkdir="mkdir -p" # always make it
alias genpass="< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;"

# Use neovim then vim (if neovim not available)
if which nvim > /dev/null; then
  alias vi="nvim"
  alias vim="nvim"
  alias vimdiff="nvim -d"
elif which vim > /dev/null; then
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

# Arch specific
alias pacfetch="sudo pacman --upgrades --sync --refresh --downloadonly"
alias pacupdate="sudo pacman --upgrades --sync --refresh"

function pacdep { comm -12 <(pactree -srl $1 | sort) <(pacman -Qq | sort); }

## SSH AGENT

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


## FUNCTIONS

function up {
ups=""
for i in $(seq 1 $1)
do
  ups=$ups"../"
done
cd $ups
}

# list dir contents after cd
cd ()
{
  builtin cd $1
  ls -ltr
}

# remove line n from a file (removeline N FILE)
removeline () { sed -i $1d $2; }

function os_clean {
unset OS_AUTH_URL
unset OS_TENANT_NAME
unset OS_USERNAME
unset OS_PASSWORD
}
