default: backup tmux shell ssh vim git

laptop: default x11 i3

minimal: backup shell tmux

.PHONY: confdir
confdir:
	mkdir -p ${HOME}/.config

.PHONY: tmux
tmux:
	ln -fvs ${PWD}/tmux.conf ${HOME}/.tmux.conf \
	&& tmux source-file ~/.tmux.conf || true

.PHONY: shell
shell:
	ln -fvs "${PWD}/bashrc" "${HOME}/.bashrc" \
	&& ln -fvs "${PWD}/bash_login" "${HOME}/.bash_login" \
	&& ln -fvs "${PWD}/profile" "${HOME}/.profile" \
	&& ln -fvs "${PWD}/zshrc" "${HOME}/.zshrc"

.PHONY: ssh
ssh:
	mkdir -p "${HOME}/.ssh" \
	&& ln -fvs "${PWD}/ssh/authorized_keys" "${HOME}/.ssh/authorized_keys"

.PHONY: vim
vim: confdir
	ln -fvs "${PWD}/.config/nvim" "${HOME}/.config/nvim" \
	&& ln -fvs "${PWD}/.config/nvim" "${HOME}/.vim" \
	&& ln -fvs "${PWD}/.config/nvim/init.vim" "${HOME}/.vimrc"

.PHONY: git
git:
	ln -fvs "${PWD}/gitconfig" "${HOME}/.gitconfig"

.PHONY: backup
backup:
	mkdir -p "${HOME}/.dotbackup" \
    && cp -a "${HOME}/.tmux.conf" "${HOME}/.dotbackup/" ||true \
    && cp -a "${HOME}/.bash_login" "${HOME}/.dotbackup/" ||true \
    && cp -a "${HOME}/.bashrc" "${HOME}/.dotbackup/" ||true \
    && cp -a "${HOME}/.profile" "${HOME}/.dotbackup/" ||true \
    && cp -a "${HOME}/.ssh/authorized_keys" "${HOME}/.dotbackup/" ||true \
    && cp -a "${HOME}/.gitconfig" "${HOME}/.dotbackup/" ||true \
    && cp -a "${HOME}/.vim" "${HOME}/.dotbackup/" ||true \
    && cp -a "${HOME}/.vimrc" "${HOME}/.dotbackup/" ||true

.PHONY: i3
i3: confdir
	ln -fvs "${PWD}/i3-laptop/config" "${HOME}/.config/i3/config" \
	&& ln -fvs "${DIR}/i3-laptop/i3status.conf" "${HOME}/.i3status.conf"

.PHONY: x11
x11:
	ln -fvs "${PWD}/Xresources" "${HOME}/.Xresources" \
	&& ln -fvs "${PWD}/Xmodmap" "${HOME}/.Xmodmap"
