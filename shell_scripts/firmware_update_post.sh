#!/bin/bash

# sudo access check
  source ./auth.sh
  set -e

# main
	echo '--- save and edit cmdline.txt'
	sudo rm /boot/cmdline.txt
	sudo cp /boot/cmdline.txt.save /boot/cmdline.txt
	echo '--- adding line to config.txt'
	sudo sed -i 's|dtparam=pi3-disable-bt|#dtparam=pi3-disable-bt|' /boot/config.txt
	echo '--- enabling hciuart'
	sudo systemctl enable hciuart
	echo '--- enabling serial'
	sudo systemctl start serial-getty@ttyAMA0.service
	sudo systemctl enable serial-getty@ttyAMA0.service
	sudo systemctl start serial-getty@ttyS0.service
	sudo systemctl enable serial-getty@ttyS0.service
	echo '--- all done'
	exit 0