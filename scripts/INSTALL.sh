#!/bin/sh
DIR="$(cd "$(dirname "$0")" && pwd)"

ln -s "$DIR/gitconfig" ~/.gitconfig
ln -s "$DIR/tmux.conf" ~/.tmux.conf
ln -s "$DIR/.config/nvim" ~/.config/nvim

# Shells
ln -s "$DIR/profile" ~/.profile
ln -s "$DIR/bashrc" ~/.bashrc
ln -s "$DIR/bash_profile" ~/.bash_profile
ln -s "$DIR/zshrc" ~/.zshrc
ln -s "$DIR/.config/fish" ~/.config/fish

# X11
ln -s "$DIR/Xresources" ~/.Xresources
ln -s "$DIR/Xmodmap" ~/.Xmodmap

# i3
ln -s "$DIR/i3-laptop/config" ~/.config/i3/config
ln -s "$DIR/i3-laptop/i3status.conf" ~/.i3status.conf

# SSH
ln -s "$DIR/ssh/authorized_keys" ~/.ssh/authorized_keys

