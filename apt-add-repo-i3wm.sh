#!/bin/bash
# ref: https://i3wm.org/docs/repositories.html
/usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2024.03.04_all.deb keyring.deb SHA256:f9bb4340b5ce0ded29b7e014ee9ce788006e9bbfe31e96c09b2118ab91fca734

sudo apt install ./keyring.deb

echo "deb https://debian.sur5r.net/i3/ bookworm main" | \
sudo tee /etc/apt/sources.list.d/sur5r-i3.list
