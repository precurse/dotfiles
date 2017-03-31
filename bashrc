# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.profile ]] && . ~/.profile

function color_my_prompt {
    local __user_and_host="\[\033[01;32m\]\u@\h:"
    local __cur_location="\[\033[01;34m\]\w"
    local __cur_time="\A"
    local __git_branch_color="\[\033[31m\]"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`\n'
    local __prompt_tail="\[\033[35m\]\\$ \[$(tput sgr0)\]"
    local __last_color="\[\033[00m\]"
    export PS1="$__user_and_host$__cur_location $__git_branch_color$__git_branch$__cur_time $__prompt_tail$__last_color"
}
color_my_prompt
