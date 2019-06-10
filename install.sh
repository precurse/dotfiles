#!/bin/sh
set -ex

# Ensure GNU stow installed
# If not, then try to install it
if ! command -v stow >/dev/null; then
    # Linux
    if [ -f /etc/os-release ]; then
	source /etc/os-release

	if [ $ID == "fedora" ]; then
	    sudo dnf install -y stow
	fi

	if [ $ID == "debian" ]; then
	    sudo apt install -y stow
	fi

    else
	echo "Please install GNU stow manually"
    fi
fi


# Install all
stow git
#stow emacs
#stow nvim
#stow i3
#stow shell
#stow ssh
#stow tmux
#stow x11
