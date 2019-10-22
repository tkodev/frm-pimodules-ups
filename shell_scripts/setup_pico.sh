#!/bin/bash

#https://www.raspberrypi.org/forums/viewtopic.php?p=770339#p770339
# along with edits made by @htkoca

# sudo access check
  source ./auth.sh
  set -e

# main script
  echo '--- update'
  sudo apt-get update
  echo '--- upgrade'
  sudo apt-get upgrade -y
  echo '--- dist-upgrade'
  sudo apt-get dist-upgrade -y
  echo '--- rpi-update'
  sudo rpi-update
  echo '--- install some packages'
  sudo apt-get install -y git python-dev python-pip python-serial python-smbus python-jinja2 python-xmltodict python-psutil i2c-tools libi2c-dev
  echo '--- pip install rpi.gpio'
  sudo pip install RPi.GPIO
  echo '--- pip install psutil'
  sudo pip install psutil
  echo '--- pip install xmltodict'
  sudo pip install xmltodict
  echo '--- adding line to config.txt'
  if [ "$(grep -c "^dtoverlay=i2c-rtc,ds1307" /boot/config.txt)" -eq 0 ]; then
    echo -e "\ndtoverlay=i2c-rtc,ds1307\n" | sudo tee -a /boot/config.txt
  fi
  if [ "$(grep -c "^enable_uart=1" /boot/config.txt)" -eq 0 ]; then
    echo -e "\nenable_uart=1\n" | sudo tee -a /boot/config.txt
  fi
  if [ "$(grep -c "^dtparam=i2c_arm=on" /boot/config.txt)" -eq 0 ]; then
    echo -e "\ndtparam=i2c_arm=on\n" | sudo tee -a /boot/config.txt
  fi
  if [ "$(grep -c "^dtparam=i2c1=on" /boot/config.txt)" -eq 0 ]; then
    echo -e "\ndtparam=i2c1=on\n" | sudo tee -a /boot/config.txt
  fi
  echo '--- adding lines to /etc/modules'
  if [ "$(grep -c "^i2c-dev" /etc/modules)" -eq 0 ]; then
    echo -e "\ni2c-dev\n" | sudo tee -a /etc/modules
  fi
  if [ "$(grep -c "^i2c-bcm2708" /etc/modules)" -eq 0 ]; then
    echo -e "\ni2c-bcm2708\n" | sudo tee -a /etc/modules
  fi
  if [ "$(grep -c "^rtc-ds1307" /etc/modules)" -eq 0 ]; then
    echo -e "\nrtc-ds1307\n" | sudo tee -a /etc/modules
  fi
  echo '--- removing fake-hwclock'
  apt-get -y remove fake-hwclock && sudo update-rc.d -f fake-hwclock remove
  echo '--- installing & enabling daemon'
  (cd ../code/python/package && sudo python setup.py install)
  (cd ../code/upspico/picofssd && sudo python setup.py install)
  systemctl enable picofssd.service
  echo '--- all done'
  exit 0
