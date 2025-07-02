#!/bin/bash
cp -R /code/src/frozen/* /root/micropython/ports/esp32/modules/.

export BOARD_NAME=UM_FEATHERS3

make clean
# make -C /root/micropython/ports/esp32 BOARD=$BOARD_NAME
# make -C /root/micropython/ports/esp32 BOARD=$BOARD_NAME DEBUG=1
make -C /root/micropython/ports/esp32 BOARD=$BOARD_NAME USER_C_MODULES=/root/usermods/micropython.cmake

mkdir -p /code/builds/$BOARD_NAME
cp /root/micropython/ports/esp32/build-$BOARD_NAME/bootloader/bootloader.bin /code/builds/$BOARD_NAME/.
cp /root/micropython/ports/esp32/build-$BOARD_NAME/partition_table/partition-table.bin /code/builds/$BOARD_NAME/.
cp /root/micropython/ports/esp32/build-$BOARD_NAME/micropython.bin /code/builds/$BOARD_NAME/.

# WHEN FLASHING THE BOARD:
# python -m esptool --chip esp32s3 -b 460800 erase_flash
# python -m esptool --chip esp32s3 -b 460800 --before default_reset --after hard_reset write_flash --flash_mode dio --flash_size detect --flash_freq 80m 0x0 bootloader.bin 0x8000 partition-table.bin 0x10000 micropython.bin

# ampy -p /dev/tty.usbmodem101 put ~/dev/micropython_builder/tests/test_quirc.py
# ampy -p /dev/tty.usbmodem101 put ~/dev/micropython_builder/tests/img/c0ffee_120x120.png
# ampy -p /dev/tty.usbmodem101 put ~/dev/micropython_builder/tests/img/c0ffee_240x240.png