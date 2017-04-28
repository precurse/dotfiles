
# You should also set $VISUAL, as some programs (correctly) use that instead of $EDITOR (see VISUAL vs. EDITOR)
VISUAL="nvim"
EDITOR="$VISUAL"
PATH="$HOME/bin:$HOME/.local/bin:$HOME/node_modules/.bin:$PATH"

export VISUAL EDITOR PATH

## ALIASES

alias ls='ls --color=auto'
alias vi="nvim"
alias vimdiff="nvim -d"
alias rm="rm -i"
alias pbcopy="xclip -selection clipboard -i"
alias pbpaste="xclip -selection clipboard -o"

# Git
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
     env ps --pid ${SSH_AGENT_PID} > /dev/null || {
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

