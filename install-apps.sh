#!/bin/bash

# Setup common
sudo apt install -y konsole emacs git clamav clamav-daemon

# Setup desktop environment
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4

sudo apt install ./keyring.deb

echo "deb https://debian.sur5r.net/i3/ bullseye main" | \
sudo tee /etc/apt/sources.list.d/sur5r-i3.list

sudo apt update
sudo apt install i3 lightdm light-locker x11-xserver-utils fonts-noto-cjk fcitx5-mozc thunar im-config pm-utils firefox-esr feh

# git setup
git config --global user.name water-dropwort
git config --global user.email 57586990+water-dropwort@users.noreply.github.com
git config --gloabl init.defaultbranch main
