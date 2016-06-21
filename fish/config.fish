set --erase fish_greeting

# Aliases
balias gws "git status --short"
balias gc "git commit"
balias gca "git commit -a"
balias gco "git checkout"
balias ga "git add"
balias gb "git branch"
balias gm "git merge"
balias gps "git push"
balias gpl "git pull"
alias rm="rm -i"
alias vi="nvim"
alias vim="nvim"

egrep "^export " ~/.profile | while read e
       set var (echo $e | sed -E "s/^export ([A-Z_]+)=(.*)\$/\1/")
       set value (echo $e | sed -E "s/^export ([A-Z_]+)=(.*)\$/\2/")

       # remove surrounding quotes if existing
       set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

       if test $var = "PATH"
               # replace ":" by spaces. this is how PATH looks for Fish
               set value (echo $value | sed -E "s/:/ /g")

               # use eval because we need to expand the value
               eval set -xg $var $value

               continue
       end

       # evaluate variables. we can use eval because we most likely just used "$var"
       set value (eval echo $value)

       #echo "set -xg '$var' '$value' (via '$e')"
       set -xg $var $value
end
