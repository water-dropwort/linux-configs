#!/bin/bash
# This script is for use with Debian Bookworm or Devuan Daedalus.
wget -O- https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
sudo gpg --yes --output /etc/apt/trusted.gpg.d/postgresql.gpg --dearmor

echo "deb [arch=amd64] https://apt.postgresql.org/pub/repos/apt bookworm-pgdg main" | \
sudo tee /etc/apt/sources.list.d/pgdg.list
