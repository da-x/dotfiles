#!/bin/bash

#
# Incomplete scriptlets for installing various development environment dependencies.
#

if [[ -e /etc/os-release ]] ; then
    source /etc/os-release
else
    echo "Unknown system"
    exit -1
fi

set -e
set -u

# TODO: stable chrome repo install
# TODO: user-dirs https://wiki.archlinux.org/index.php/XDG_user_directories

if [[ "$NAME" == "CentOS Linux" ]] ; then
    centos7-gui() {
	sudo yum -y install epel-release
	sudo yum -y groupinstall xfce
	sudo yum -y groupinstall "X Window System"
	sudo yum -y install lightdm

	sudo unlink /etc/systemd/system/default.target
	sudo ln -sf /lib/systemd/system/graphical.target /etc/systemd/system/default.target
    }

    centos7-base-setup() {
	sudo yum -y groupinstall 'Development Tools' && sudo yum install curl wget file git fedpkg
	sudo usermod -a -G mock $USER
	sudo su -c 'echo config_opts[\"dnf_warning\"] = False >> /etc/mock/site-defaults.cfg'
	sudo yum install -y https://centos7.iuscommunity.org/ius-release.rpm
	sudo yum install -y python36u-pip python36u-devel python36u python-pip python-devel
	sudo yum install -y fedpkg xsel xclip
    }

    build-path() {
	mkdir -p ~/trash/build
	cd ~/trash/build
    }

    centos7-zsh() {
	build-path
	fedpkg clone -a zsh
	cd zsh
	git reset --hard origin/f28
	rm -rf results_zsh
	fedpkg --release epel7 mockbuild
	sudo yum install -y results_zsh/*/*.el7/zsh-5*.x86_64.rpm
	sudo chsh $USER -s /bin/zsh
	sudo rm -f /etc/zlogout
	cd ..
    }

    centos7-tmux() {
	build-path
	sudo yum install -y libjemalloc-devel libevent-devel ncurses-devel jemalloc-devel
	git clone --depth 1 https://github.com/da-x/tmux

	cd tmux
	bash autogen.sh
	./configure --prefix=/usr/local --enable-jemalloc
	make -j8
	sudo make install
    }

    centos7-packages() {
	mkdir -p ~/rpms
	cd ~/rpms

	echo "pkgs.fedoraproject.org,209.132.181.4 ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAnhQyqu6oY5g01SOEbtrgrlCk3/eoLVZl2oh6c+Xq2oJg5ppPCtvmdWgU9rEltS+jgAYTH3LG4lGd02boMk8mmV5QvzGGRA9HmN991Phm7y4EN5r84A0gibf2O5QzhU2IMBQuOkEMwqZC+wc7pGGFJeXQjzBAVidjacxXtVJyfFOhAIYoHerIYq3VbJrTzEGkHmcJ8o3ZnP8Mt35aBESNsHdIaCOpvZzK1NVHdUHwRGcXIjG6t06mNVG4DVbdpB6xmMbAD5bemPoPVG0oYVs9wmhSHC0LmOZbvv8CDO2Z0DJ8q25FwVlTjo1Eq2A8VJc4LnHTDHZbtDZiKGTo/UMvvQ==" >> ~/.ssh/known_hosts

	centos7-zsh
	centos7-tmux
    }

    centos7-git() {
	build-path
	fedpkg clone -a git
	cd git
	git reset --hard origin/f28
	rm -rf results_git
	fedpkg --release epel7 mockbuild
	sudo yum install -y results_git/*/*.el7/*.{noarch,x86_64}.rpm
	cd ..
    }

    centos7-neovim() {
	build-path

        sudo yum -y install cmake

        git clone --depth 1 --no-single-branch https://github.com/da-x/neovim
	cd neovim

	make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=/usr/local/neovim"
	sudo make install
	sudo ln -s /usr/local/neovim/bin/nvim /usr/local/bin/nvim

	pip install --user --upgrade pynvim
	pip3.6 install --user --upgrade pynvim
    }

    centos7-alacritty() {
	build-path
	sudo yum install -y freetype-devel expat-devel

	git clone https://github.com/da-x/alacritty

	cd alacritty
	git checkout auto-small-font
	cargo install --path .
    }

    centos7-mc() {
	build-path
	fedpkg clone -a mc
	cd mc
	git reset --hard origin/f29
	rm -rf results_git
	fedpkg --release epel7 mockbuild
	sudo yum install -y results_mc/*/*.el7/*.x86_64.rpm
	cd ..
    }
fi

rust-install() {
    curl https://sh.rustup.rs -sSf | sh

    ~/.cargo/bin/cargo install bat ripgrep lsd
}

haskell-install() {
    cd ~
    curl -sSL https://get.haskellstack.org/ | sh
    mkdir -p .local/bin
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> .profile
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> .zprofile
}

fancydiff-install() {
    build-path

    sudo yum install -y libicu-devel zlib-devel openssl-devel

    git clone --depth 1 https://github.com/da-x/fancydiff
    cd fancydiff
    stack install
}

dotfiles-install() {
    cd ~
    git clone https://github.com/da-x/dotfiles .files
    cd .files
    ./sync.sh
}

devenv-install() {
    mkdir -p ~/dev/env

    cd ~/dev/env

    git clone https://github.com/da-x/misc-gitology
    cd misc-gitology
    mkdir -p ~/.local/bin
    ln -s ~/.local/bin
    ln -s ~/dev/env/misc-gitology/git-* .

    git clone https://github.com/da-x/git-search-replace
    cd git-search-replace
    python setup.py install --user

    cd ~/.local/bin
    ln -s git-search-replace.py gsr

    cd ~/dev/env
    git clone https://github.com/da-x/git-bottle
    cd ~/.local/bin
    ln -s ~/dev/env/git-bottle/git-* .
}

"$@"
