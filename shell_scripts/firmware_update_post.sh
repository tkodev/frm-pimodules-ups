#!/bin/bash

# sudo access check
  source ./auth.sh
  set -e

# main
  echo '--- restoring pre_fw files if exists'
  if [ -f "/boot/cmdline.txt.pre_fw" ]; then
    echo '--- restoring /boot/cmdline.txt'
    sudo rm /boot/cmdline.txt
    sudo cp /boot/cmdline.txt.pre_fw /boot/cmdline.txt
    sudo rm /boot/cmdline.txt.pre_fw
  fi
  if [ -f "/boot/config.txt.pre_fw" ]; then
    echo '--- restoring /boot/config.txt'
    sudo rm /boot/config.txt
    sudo cp /boot/config.txt.pre_fw /boot/config.txt
    sudo rm /boot/config.txt.pre_fw
  fi
  echo '--- enabling hciuart'
  sudo systemctl enable hciuart
  echo '--- enabling serial'
  sudo systemctl start serial-getty@ttyAMA0.service
  sudo systemctl enable serial-getty@ttyAMA0.service
  sudo systemctl start serial-getty@ttyS0.service
  sudo systemctl enable serial-getty@ttyS0.service
  echo '--- all done, rebooting'
  sudo reboot
  exit 0