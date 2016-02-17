export PS1='\[\033[0;32m\]\u \[\033[0;34m\]\w\[\033[0m\] $(__git_ps1 "(%s)")\n$ '
export EDITOR="vim"
export VAGRANT_DEFAULT_PROVIDER=virtualbox

## Aliases
alias vi="nvim"
alias rm="rm -i"
alias vimdiff="nvim -d"
alias git='hub'
alias dm='docker-machine'
alias dockerrm='docker rm $(docker ps -a | grep -v Up | grep -v data | grep -v CONTAINER | cut -d" " -f1) 2>/dev/null'
alias dockerrmi='docker rmi $(docker images -q -f dangling=true) 2>/dev/null'
alias dockerrmv='docker volume rm $(docker volume ls -q -f dangling=true) 2>/dev/null'
alias dockerclean='dockerrm; dockerrmi'




case $OSTYPE in
darwin*)
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
    PATH=/usr/local/bin:/usr/local/sbin:$PATH
    export CLICOLOR=1
    alias tmux="TERM=screen-256color tmux"
    ;;
linux*)
    eval "$(dircolors)"
    ;;
esac



### Cybera Specific

if [ -f $HOME/devel/lmc/bin/lmc ]; then
  eval "$(/Users/andrew/lmc/bin/lmc init -)"
fi


vpnon() {
    ps aux | grep openconnect | grep -v grep > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "VPN already connected"
        return
    fi

    case $OSTYPE in
    darwin*)
        user=$(security 2>/dev/null find-generic-password -gs vpn.cybera.ca | grep "acct" | cut -d '"' -f 4 | sed 's/\\$/\\\\\\\$/g')
        password=$(security 2>&1 >/dev/null find-generic-password -gs vpn.cybera.ca | cut -d '"' -f 2 | sed 's/\\$/\\\\\\\$/g')

        if [ "$password" == "security: SecKeychainSearchCopyNext: The specified item could not be found in the keychain." ]; then
            sudo openconnect -q -l -b vpn.cybera.ca
        else
            echo "$password" | sudo openconnect -q -l -u $user --passwd-on-stdin -b vpn.cybera.ca
        fi
        ;;
    linux*)
        sudo openconnect -q -l -b vpn.cybera.ca
        ;;
    esac
}

vpnoff() {
    sudo killall openconnect
}

