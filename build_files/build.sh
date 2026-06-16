#!/bin/bash

set -ouex pipefail

dnf5 -y swap sway-config sway-config-minimal

# Install packages from Fedora repositories
dnf5 -y install tmux                     \
                neovim                   \
                curl                     \
                wget                     \
                fastfetch                \
                chezmoi                  \
                neo                      \
                distrobox                \
                xwayland-satellite       \
                xorg-x11-server-Xwayland \
                bat                      \
                nemo                     \
                kitty                    \
                wlsunset                 \
                cargo                    \
                tldr                     \
                fzf                      \
                ripgrep

# Install Dank Material Shell
dnf5 -y copr enable avengemedia/dms
dnf5 -y install dms
dnf5 -y install dms-greeter
dnf5 -y copr disable avengemedia/dms

# Package group to install virtualization goodies such as virt-manager
dnf5 install -y @virtualization

# Add my personal COPR and install lavat
dnf5 -y copr enable mboaisha/assortment
dnf5 -y install lavat
dnf5 -y copr disable mboaisha/assortment

# Add Terra repo
dnf5 install -y --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

# ghostty terminal emulator
# Requires Terra repo
#dnf5 install -y ghostty
# A whole slew of fonts
dnf5 -y install ubuntumono-nerd-fonts      \
                iosevka-nerd-fonts         \
                lilex-nerd-fonts           \
                iosevkaterm-nerd-fonts     \
                iosevkatermslab-nerd-fonts \
                inconsolata-nerd-fonts     \
                hack-nerd-fonts            \
                firamono-nerd-fonts        \
                liberationmono-nerd-fonts  \
                zedmono-nerd-fonts         \
                sourcecodepro-nerd-fonts   \
                terminus-nerd-fonts        \
                bigblueterminal-nerd-fonts

# Yeet sway and replace it with Swayfx
# Note: You might have stuttering issues if you use this in a virtual machine
# Requires Terra repo
#dnf5 swap -y sway swayfx --allowerasing --setopt=protected_packages=

# Bitwarden CLI
# Requires Terra repo
dnf5 -y install bitwarden-cli

# Install VSCodium
# Note: .repo is already defined in the image
dnf5 install -y codium

dnf5 install -y tailscale

# Add flathub
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

systemctl enable podman.socket
systemctl enable libvirtd.service
systemctl enable libvirtd-ro.socket
systemctl enable flatpak-preinstall.service
systemctl enable sshd.service
systemctl enable tailscaled.service
systemctl disable sddm
systemctl enable greetd

dnf5 clean all
