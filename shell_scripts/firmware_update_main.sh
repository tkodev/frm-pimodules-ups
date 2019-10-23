#!/bin/bash

# sudo access check
  source ./auth.sh
  # set -e

# do firmware update
  (cd ../pico_fu/ && sudo i2cset -y 1 0x6b 0x00 0xff && sleep 3s && sudo python ./picofu.py -v -f ./0xE3_UPS_PIco_HV3.0_main.hex ; sudo i2cget -y 1 0x69 0x26);
  echo '--- all done, powering off for manual power cycle'
  sudo powering off
  exit 0