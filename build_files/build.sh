#!/bin/bash

set -ouex pipefail

# Install packages from Fedora repositories
dnf5 install -y tmux neovim curl

dnf5 -y copr enable mboaisha/assortment
dnf5 -y install lavat
dnf5 -y copr disable mboaisha/assortment

# Add Terra repo
dnf5 install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

# Yeet sway and replace it with Swayfx
# Note: You might have stuttering issues if you use this in a virtual machine
dnf5 swap -y sway swayfx --allowerasing --setopt=protected_packages=

# Install Rust to build Wayle
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

systemctl enable podman.socket