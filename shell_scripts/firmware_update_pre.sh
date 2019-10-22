#!/bin/bash

# sudo access check
  source ./auth.sh
  set -e

# main
	echo '--- save and edit cmdline.txt'
	sudo cp /boot/cmdline.txt /boot/cmdline.txt.save
	sudo sed -i 's| console=ttyAMA0,115200||' /boot/cmdline.txt
	sudo sed -i 's| console=serial0,115200||' /boot/cmdline.txt
	echo '--- adding line to config.txt'
	echo -e "\n\ndtparam=pi3-disable-bt\n\n" | sudo tee -a /boot/config.txt
	echo '--- disabling hciuart'
	sudo systemctl disable hciuart
	echo '--- disabling serial'
	sudo systemctl stop serial-getty@ttyAMA0.service
	sudo systemctl disable serial-getty@ttyAMA0.service
	sudo systemctl stop serial-getty@ttyS0.service
	sudo systemctl disable serial-getty@ttyS0.service
	echo '--- all done'
	exit 0
