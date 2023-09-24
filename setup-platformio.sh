#!/bin/bash

curl -fsSL -o get-platformio.py https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py
python3 get-platformio.py
rm get-platformio.py

BIN_DIR=$HOME/.local/bin
if [ ! -d $BIN_DIR ]; then
  mkdir $BIN_DIR
else
  echo "[INFO] .local/bin directory allready exists."
fi

# Appending PATH=$HOME/.local/bin:$PATH to .bashrc file.
ln -s ~/.platformio/penv/bin/platformio ~/.local/bin/platformio
ln -s ~/.platformio/penv/bin/pio ~/.local/bin/pio
ln -s ~/.platformio/penv/bin/piodebuggdb ~/.local/bin/piodebuggdb

curl -fsSL https://raw.githubusercontent.com/platformio/platformio-core/develop/platformio/assets/system/99-platformio-udev.rules | sudo tee /etc/udev/rules.d/99-platformio-udev.rules

sudo udevadm control --reload-rules
sudo udevadm trigger

sudo usermod -a -G dialout $USER
sudo usermod -a -G plugdev $USER
