#!/bin/bash

# sudo access check
  source ./auth.sh
  # set -e

# do firmware update
  echo '--- show picofssd service status'
  service picofssd status
  echo '--- is UPS PICo running on Cable (0x01) or Bat (0x02)'
  sudo i2cget -y 1 0x69 0x00
  echo '--- is UPS PIco running? both returned hex codes should be different'
  sudo i2cget -y 1 0x69 0x22 w && i2cget -y 1 0x69 0x22 w
  # echo '--- toggling Buzzer'
  # sudo i2cset -y 1 0x6D 0x00 # Deactivate permanently the buzzer (no sunds wil be played)
  # sudo i2cset -y 1 0x6D 0x01
  # sudo i2cset -y 1 0x6B 0x0e 1047 w # Set the frequency to C (1047 Hz) note
  # sudo i2cset -y 1 0x6B 0x10 100 # Set the duration to 1 second
  # echo '--- toggling Orange, Green and Blue LEDS'
  # sudo i2cset -y 1 0x6b 0x09 0x01 # for ON the Orange LED
  # sleep 2s
  # sudo i2cset -y 1 0x6b 0x09 0x00 # for OFF the Orange LED
  # sudo i2cset -y 1 0x6b 0x0A 0x01 # for ON the Green LED
  # sleep 2s
  # sudo i2cset -y 1 0x6b 0x0A 0x00 # for OFF the Green LED
  # sudo i2cset -y 1 0x6b 0x0b 0x01 # for ON the Blue LED
  # sleep 2s
  # sudo i2cset -y 1 0x6b 0x0b 0x00 # for OFF the Blue LED
  # echo '--- is any of the buttons pressed? should return 1, 2 or 3'
  # sudo i2cget -y 1 0x69 0x1A
  # sudo i2cset -y 1 0x69 0x1A 0x00 # reset pressed state
  # echo '--- reset and set bistable relay'
  # sudo i2cset -y 1 0x6B 0x0c 0x00 # reset
  # sudo i2cset -y 1 0x6B 0x0c 0x01 # set