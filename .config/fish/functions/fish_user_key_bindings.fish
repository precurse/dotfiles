# Workaround for bug where after ssh dies, arrow keys don't work
function fish_user_key_bindings
    bind \eOA up-or-search
    bind \eOB down-or-search
    bind \eOC forward-char
    bind \eOD backward-char
end
