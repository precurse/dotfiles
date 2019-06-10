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
            sudo apt install -y stow
        fi
    else
        # Use uname instead
        case "$(uname -s)" in
          OpenBSD)
            doas pkg_add stow
            ;;

          Darwin)
            brew update
            brew install stow
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
