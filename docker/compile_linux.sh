#!/bin/bash
cp -R /code/src/frozen/* /root/micropython/ports/unix/modules/.
make -C /root/micropython/ports/unix USER_C_MODULES=/code/src/usermods clean
make -C /root/micropython/ports/unix USER_C_MODULES=/code/src/usermods LDFLAGS="-lffi -lm" DEBUG=1 
# mkdir -p /code/builds/ESP32_GENERIC_S3
# cp /root/micropython/ports/esp32/build-ESP32_GENERIC_S3-SPIRAM_OCT/bootloader/bootloader.bin /code/builds/ESP32_GENERIC_S3/.
# cp /root/micropython/ports/esp32/build-ESP32_GENERIC_S3-SPIRAM_OCT/partition_table/partition-table.bin /code/builds/ESP32_GENERIC_S3/.
# cp /root/micropython/ports/esp32/build-ESP32_GENERIC_S3-SPIRAM_OCT/micropython.bin /code/builds/ESP32_GENERIC_S3/.
