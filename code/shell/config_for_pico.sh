#!/bin/bash

if [ `whoami` != 'root' ]; then
	echo 'Must be run as root'
	exit 1
fi

set -e

echo '--- update'
apt-get update
echo '--- install some packages'
apt-get install -y git python-dev python-pip python-serial python-smbus python-jinja2 python-xmltodict python-psutil i2c-tools libi2c-dev

echo '--- pip install rpi.gpio'
sudo pip install RPi.GPIO

echo '--- pip install psutil'
pip install psutil

echo '--- pip install xmltodict'
pip install xmltodict

echo '--- installing & enabling daemon'
cd PiModules/code/python/package
python setup.py install
cd ../upspico/picofssd
python setup.py install
systemctl enable picofssd.service

echo '--- adding line to config.txt'
if [ "$(grep -c "^dtoverlay=i2c-rtc,ds1307" /boot/config.txt)" -eq 0 ]; then
  echo -e "\ndtoverlay=i2c-rtc,ds1307\n" >> /boot/config.txt
fi

if [ "$(grep -c "^enable_uart=1" /boot/config.txt)" -eq 0 ]; then
  echo -e "\nenable_uart=1\n" >> /boot/config.txt
fi

if [ "$(grep -c "^dtparam=i2c_arm=on" /boot/config.txt)" -eq 0 ]; then
  echo -e "\ndtparam=i2c_arm=on\n" >> /boot/config.txt
fi

if [ "$(grep -c "^dtparam=i2c1=on" /boot/config.txt)" -eq 0 ]; then
  echo -e "\ndtparam=i2c1=on\n" >> /boot/config.txt
fi

echo '--- adding lines to /etc/modules'
if [ "$(grep -c "^i2c-bcm2708" /etc/modules)" -eq 0 ]; then
  echo -e "\ni2c-bcm2708\n" >> /etc/modules
fi
if [ "$(grep -c "^rtc-ds1307" /etc/modules)" -eq 0 ]; then
	echo -e "\nrtc-ds1307\n" >> /etc/modules
fi

echo '--- removing fake-hwclock'
apt-get -y remove fake-hwclock && sudo update-rc.d -f fake-hwclock remove

echo '--- all done'
exit 0

#https://www.raspberrypi.org/forums/viewtopic.php?p=770339#p770339