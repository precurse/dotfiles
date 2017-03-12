
# You should also set $VISUAL, as some programs (correctly) use that instead of $EDITOR (see VISUAL vs. EDITOR)
export VISUAL=nvim
export EDITOR="$VISUAL"
export PATH=$HOME/bin:$PATH

## ALIASES

alias ls='ls --color=auto'
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



## SSH AGENT
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
     . "${SSH_ENV}" > /dev/null
     #ps ${SSH_AGENT_PID} doesn't work under cywgin
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
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

