#!/bin/bash

set -ouex pipefail

# Install packages from Fedora repositories
dnf5 install -y tmux neovim

dnf5 -y copr enable mboaisha/assortment
dnf5 -y install lavat
dnf5 -y copr disable mboaisha/assortment

# Add Terra repo
dnf5 install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

# Yeet sway and replace it with Swayfx
dnf5 swap -y sway swayfx --allowerasing --setopt=protected_packages=

systemctl enable podman.socket