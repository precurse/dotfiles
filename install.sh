#!/bin/sh
set -ex

# Ensure GNU stow installed
# If not, then try to install it
if ! command -v stow >/dev/null; then
    # Linux
    if [ -f /etc/os-release ]; then
        . /etc/os-release

        if [ "$ID" = "fedora" ]; then
            sudo dnf install -y stow
        fi

        if [ "$ID" = "debian" ] || [ "$ID" = "ubuntu" ]; then
            sudo apt update
            sudo apt install -y stow shellcheck
        fi
    else
        # Use uname instead
        case "$(uname -s)" in
          OpenBSD)
            doas pkg_add stow
            ;;

          Darwin)
            brew update
            brew install stow shellcheck
            ;;
          *)
            echo "Please install GNU stow manually"
            ;;
        esac
    fi
fi

# Install all
stow git
stow shell
#stow emacs
#stow nvim
#stow i3
#stow ssh
#stow tmux
#stow x11

if [ "$#" -eq 1 ]; then
    # Testing
    . ../.bashrc
    genpass
    ll
    mcd tmp1
    touch file1
    cp file1 file2
    cd ..
    mv tmp1 tmp2
    rm tmp2
    df
    du
    shellcheck -s sh ../.profile
    shellcheck -s bash ../.bashrc
fi
