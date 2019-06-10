default: backup tmux shell ssh vim git

laptop: default x11 i3

minimal: backup shell tmux

.PHONY: confdir
confdir:
	mkdir -p ${HOME}/.config

.PHONY: tmux
tmux:
	ln -fs ${PWD}/tmux.conf ${HOME}/.tmux.conf \
	&& tmux source-file ~/.tmux.conf || true

.PHONY: shell
shell:
	ln -fs "${PWD}/bashrc" "${HOME}/.bashrc" \
	&& ln -fs "${PWD}/bash_profile" "${HOME}/.bash_profile" \
	&& ln -fs "${PWD}/profile" "${HOME}/.profile" \

.PHONY: ssh
ssh:
	mkdir -p "${HOME}/.ssh" \
	&& ln -fs "${PWD}/ssh/authorized_keys" "${HOME}/.ssh/authorized_keys"

.PHONY: vim
vim: confdir
	ln -fs "${PWD}/.config/nvim" "${HOME}/.config/nvim" \
	&& ln -fs "${PWD}/.config/nvim" "${HOME}/.vim" \
	&& ln -fs "${PWD}/.config/nvim/init.vim" "${HOME}/.vimrc"

.PHONY: git
git:
	ln -fs "${PWD}/gitconfig" "${HOME}/.gitconfig"

.PHONY: emacs
emacs:
	ln -fs "${PWD}/emacs/.emacs.d" "${HOME}/.emacs.d"

.PHONY: backup
backup:
	mkdir -p "${HOME}/.dotbackup" \
    && cp -rp "${HOME}/.tmux.conf" "${HOME}/.dotbackup/" ||true \
    && cp -rp "${HOME}/.bash_profile" "${HOME}/.dotbackup/" ||true \
    && cp -rp "${HOME}/.bashrc" "${HOME}/.dotbackup/" ||true \
    && cp -rp "${HOME}/.profile" "${HOME}/.dotbackup/" ||true \
    && cp -rp "${HOME}/.ssh/authorized_keys" "${HOME}/.dotbackup/" ||true \
    && cp -rp "${HOME}/.gitconfig" "${HOME}/.dotbackup/" ||true \
    && cp -rp "${HOME}/.vim" "${HOME}/.dotbackup/" ||true \
    && cp -rp "${HOME}/.vimrc" "${HOME}/.dotbackup/" ||true \
    && cp -rp "${HOME}/.emacs.d" "${HOME}/.dotbackup/" ||true

.PHONY: i3
i3: confdir
	ln -fs "${PWD}/.config/i3" "${HOME}/.config/" \
	&& ln -fs "${PWD}/.config/i3status" "${HOME}/.config/"

.PHONY: x11
x11:
	ln -fs "${PWD}/x11/Xresources" "${HOME}/.Xresources" \
	&& ln -fs "${PWD}/x11/Xmodmap" "${HOME}/.Xmodmap" \
	&& ln -fs "${PWD}/x11/xsession" "${HOME}/.xsession" \
	&& ln -fs "${PWD}/x11/xsessionrc" "${HOME}/.xsessionrc"
