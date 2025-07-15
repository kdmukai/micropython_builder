#!/bin/bash

cp -R /code/src/frozen/* /root/micropython/ports/esp32/modules/.

# Trim embit submodule
rm -rf /root/micropython/ports/esp32/modules/embit/docs
rm -rf /root/micropython/ports/esp32/modules/embit/examples
rm -rf /root/micropython/ports/esp32/modules/embit/secp256k1
rm -rf /root/micropython/ports/esp32/modules/embit/tests
rm -rf /root/micropython/ports/esp32/modules/embit/src/embit/liquid
rm -rf /root/micropython/ports/esp32/modules/embit/src/embit/util
rm -rf /root/micropython/ports/esp32/modules/embit/.git*
rm /root/micropython/ports/esp32/modules/embit/.pre-commit-config.yaml
rm /root/micropython/ports/esp32/modules/embit/LICENSE
rm /root/micropython/ports/esp32/modules/embit/pyproject.toml
rm /root/micropython/ports/esp32/modules/embit/README.md
rm /root/micropython/ports/esp32/modules/embit/setup.py

# Move the actual python files to the package root for proper import
mv /root/micropython/ports/esp32/modules/embit/src/embit/* /root/micropython/ports/esp32/modules/embit/.
rm -rf /root/micropython/ports/esp32/modules/embit/src
echo "Removed unnecessary files from embit module"


export BOARD_NAME=UM_FEATHERS3
# export BOARD_NAME=ESP32_GENERIC_S3
echo "Building for board: $BOARD_NAME"


make -C /root/micropython/ports/esp32 BOARD=$BOARD_NAME USER_C_MODULES=/root/usermods/micropython.cmake clean
make -C /root/micropython/ports/esp32 BOARD=$BOARD_NAME USER_C_MODULES=/root/usermods/micropython.cmake
# make -C /root/micropython/ports/esp32 BOARD=$BOARD_NAME USER_C_MODULES=/root/usermods/micropython.cmake CFLAGS_EXTRA=-DMODULE_SECP256K1_ENABLED=1


export TARGET_BUILD_DIR=/code/builds/$BOARD_NAME
mkdir -p $TARGET_BUILD_DIR
cp /root/micropython/ports/esp32/build-$BOARD_NAME/bootloader/bootloader.bin $TARGET_BUILD_DIR/.
cp /root/micropython/ports/esp32/build-$BOARD_NAME/partition_table/partition-table.bin $TARGET_BUILD_DIR/.
cp /root/micropython/ports/esp32/build-$BOARD_NAME/micropython.bin $TARGET_BUILD_DIR/.
echo "Build files copied to $TARGET_BUILD_DIR"


# WHEN FLASHING THE BOARD:
# python -m esptool --chip esp32s3 -b 460800 erase_flash
# python -m esptool --chip esp32s3 -b 460800 --before default_reset --after hard_reset write_flash --flash_mode dio --flash_size detect --flash_freq 80m 0x0 bootloader.bin 0x8000 partition-table.bin 0x10000 micropython.bin

# ampy -p /dev/tty.usbmodem101 put ~/dev/micropython_builder/tests/test_quirc.py
# ampy -p /dev/tty.usbmodem101 put ~/dev/micropython_builder/tests/img/c0ffee_120x120.png
# ampy -p /dev/tty.usbmodem101 put ~/dev/micropython_builder/tests/img/c0ffee_240x240.png