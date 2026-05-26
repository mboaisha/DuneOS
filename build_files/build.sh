#!/bin/bash

set -ouex pipefail

# Install packages from Fedora repositories
dnf5 install -y tmux neovim curl wget wlogout fuzzel fastfetch

# Add my personal COPR and install lavat
dnf5 -y copr enable mboaisha/assortment
dnf5 -y install lavat
dnf5 -y copr disable mboaisha/assortment

# Add Terra repo
dnf5 install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

# Yeet sway and replace it with Swayfx
# Note: You might have stuttering issues if you use this in a virtual machine
dnf5 swap -y sway swayfx --allowerasing --setopt=protected_packages=

# Install VSCodium
# Note: .repo is already defined in the image
dnf5 install -y codium

# Install Rust to build Wayle
#dnf5 install -y rust cargo

# Deps for building Wayle
#dnf5 -y install git cmake pkgconf-pkg-config gtk4-devel gtk4-layer-shell-devel \
#  gtksourceview5-devel pulseaudio-libs-devel fftw-devel pipewire-devel \
#  systemd-devel clang gcc libxkbcommon-devel

# Build and install Wayle
#export CARGO_HOME=/var/tmp/cargo
#git clone https://github.com/wayle-rs/wayle
#cd wayle
#cargo install --root /usr --path wayle
#cargo install --root /usr --path crates/wayle-settings

systemctl enable podman.socket

dnf5 clean all