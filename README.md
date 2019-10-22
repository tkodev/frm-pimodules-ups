
# PiModules(R) Product Support Software and Related Files

This repository contains software and other files supporting PiModules(R) UPS PIco HV3.0A.

## Setup Steps
1. Enable `i2c`, use proper timezone & wifi locale via `sudo raspi-config`
2. SSH into your raspberry pi with UPS pico installed.
3. Run `(cd ./shell_scripts/ && ./setup_pico.sh)` to update RPI, config i2c on system, install prerequisite software, hardware RTC, etc
4. Run `sudo reboot` to ensure daemon / drivers are running, etc
5. Run `(cd ./shell_scripts/ && ./setup_firmware.sh)` to prep system for firmware update
6. Run `sudo reboot` to fresh restart

## Extra Scripts
- run `(cd ./pico_status/ && sudo python ./pico_status.py)` - Script to show you some statistics pulled from your UPS PIco HV3.0A.
- run `(cd ./temp_fan/ && sudo python ./pico_HV3.0_temp_fan_v1.0.py)` - Script to automatically change the fan speed based on the temperature of the TO92 sensor.

## Documentation
- Please visit manual in `./doc` to find troubleshooting steps