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
  echo '--- save and edit cmdline.txt'
  sudo cp /boot/cmdline.txt /boot/cmdline.txt.pre_fw
  sudo sed -i 's| console=ttyAMA0,115200||' /boot/cmdline.txt
  sudo sed -i 's| console=serial0,115200||' /boot/cmdline.txt
  echo '--- adding line to config.txt'
  sudo cp /boot/config.txt /boot/config.txt.pre_fw
  echo -e "\n\ndtparam=pi3-disable-bt\n\n" | sudo tee -a /boot/config.txt
  echo '--- disabling hciuart'
  sudo systemctl disable hciuart
  echo '--- disabling serial'
  sudo systemctl stop picofssd.service
  sudo systemctl stop serial-getty@ttyAMA0.service
  sudo systemctl disable serial-getty@ttyAMA0.service
  sudo systemctl stop serial-getty@ttyS0.service
  sudo systemctl disable serial-getty@ttyS0.service
  echo '--- all done, rebooting'
  sudo reboot
  exit 0
