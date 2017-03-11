#!/bin/sh
DIR="$(cd "$(dirname "$0")" && pwd)"

ln -s "$DIR/Xresources" ~/.Xresources
ln -s "$DIR/Xmodmap" ~/.Xmodmap
ln -s "$DIR/tmux.conf" ~/.tmux.conf
ln -s "$DIR/bashrc" ~/.bashrc
ln -s "$DIR/i3-laptop/config" ~/.config/i3/config
ln -s "$DIR/i3-laptop/i3status.conf" ~/.i3status.conf
ln -s "$DIR/.config/nvim" ~/.config/nvim
ln -s "$DIR/.config/fish" ~/.config/fish
