#!/bin/bash

#https://www.raspberrypi.org/forums/viewtopic.php?p=770339#p770339
# along with edits made by @htkoca

# sudo access check
  source ./auth.sh
  set -e

# main script
  echo '--- adding line to config.txt'
  sudo cp /boot/cmdline.txt /boot/cmdline.txt.orig
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
  sudo cp /etc/modules /etc/modules.orig
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
  sudo apt-get -y remove fake-hwclock && sudo update-rc.d -f fake-hwclock remove
  echo '--- installing & enabling daemon'
  (cd ../code/python/package && sudo python setup.py install)
  (cd ../code/python/upspico/picofssd && sudo python setup.py install)
  (cd ../code/python/upspico/picofssd && sudo systemctl enable picofssd.service)
  echo '--- all done, rebooting'
  sudo reboot
  exit 0
