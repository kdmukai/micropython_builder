#!/bin/bash
make -C /root/micropython/ports/esp32 BOARD=ESP32_GENERIC_S3 clean
make -C /root/micropython/ports/esp32 BOARD=ESP32_GENERIC_S3
mkdir -p /code/builds/ESP32_GENERIC_S3
cp /root/micropython/ports/esp32/build-ESP32_GENERIC_S3/bootloader/bootloader.bin /code/builds/ESP32_GENERIC_S3/.
cp /root/micropython/ports/esp32/build-ESP32_GENERIC_S3/partition_table/partition-table.bin /code/builds/ESP32_GENERIC_S3/.
cp /root/micropython/ports/esp32/build-ESP32_GENERIC_S3/micropython.bin /code/builds/ESP32_GENERIC_S3/.
