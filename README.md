
# PiModules(R) Product Support Software and Related Files

This repository contains software and other files supporting PiModules(R) UPS PIco HV3.0A.

## Steps
1. Enable `i2c`, use proper timezone & wifi locale via `sudo raspi-config`
2. Browse `./doc/` for latest prospectus, manuals, etc.
3. SSH into your raspberry pi with UPS pico installed.
4. Run `(cd ./shell_scripts/ && ./setup_pico.sh)` to update RPI, config i2c on system, install prerequisite software, hardware RTC, etc
5. Run `sudo reboot` to ensure daemon / drivers are running, etc
6. Run `(cd ./shell_scripts/ && ./setup_firmware.sh)` to prep system for firmware update
7. Run `sudo reboot` to ensure daemon / drivers are running, etc

## Extra Scripts
- run `(cd ./pico_status/ && sudo python ./pico_status.py)` - Script to show you some statistics pulled from your UPS PIco HV3.0A.
- run `(cd ./temp_fan/ && sudo python ./pico_HV3.0_temp_fan_v1.0.py)` - Script to automatically change the fan speed based on the temperature of the TO92 sensor.