#!/bin/bash
cp -R /code/src/frozen/* /root/micropython/ports/esp32/modules/.
make -C /root/micropython/ports/esp32 BOARD=ESP32_GENERIC_S3 BOARD_VARIANT=SPIRAM_OCT USER_C_MODULES=/code/src/usermods/micropython.cmake DEBUG=1 clean
make -C /root/micropython/ports/esp32 BOARD=ESP32_GENERIC_S3 BOARD_VARIANT=SPIRAM_OCT USER_C_MODULES=/code/src/usermods/micropython.cmake DEBUG=1 
mkdir -p /code/builds/ESP32_GENERIC_S3
cp /root/micropython/ports/esp32/build-ESP32_GENERIC_S3-SPIRAM_OCT/bootloader/bootloader.bin /code/builds/ESP32_GENERIC_S3/.
cp /root/micropython/ports/esp32/build-ESP32_GENERIC_S3-SPIRAM_OCT/partition_table/partition-table.bin /code/builds/ESP32_GENERIC_S3/.
cp /root/micropython/ports/esp32/build-ESP32_GENERIC_S3-SPIRAM_OCT/micropython.bin /code/builds/ESP32_GENERIC_S3/.
