#!/bin/bash
cp -R /code/src/frozen/* /root/micropython/ports/esp32/modules/.
make -C /root/micropython/ports/esp32 BOARD=SAOLA_1R USER_C_MODULES=/code/src/usermods/micropython.cmake DEBUG=1 clean
make -C /root/micropython/ports/esp32 BOARD=SAOLA_1R USER_C_MODULES=/code/src/usermods/micropython.cmake DEBUG=1 
# make -C /root/micropython/ports/esp32 BOARD=SAOLA_1R DEBUG=1 clean
# make -C /root/micropython/ports/esp32 BOARD=SAOLA_1R DEBUG=1 
# make -C /root/micropython/ports/esp32 BOARD=ESP32_GENERIC_S2 DEBUG=1 clean
# make -C /root/micropython/ports/esp32 BOARD=ESP32_GENERIC_S2 DEBUG=1 
mkdir -p /code/builds/SAOLA_1R
cp /root/micropython/ports/esp32/build-SAOLA_1R/bootloader/bootloader.bin /code/builds/SAOLA_1R/.
cp /root/micropython/ports/esp32/build-SAOLA_1R/partition_table/partition-table.bin /code/builds/SAOLA_1R/.
cp /root/micropython/ports/esp32/build-SAOLA_1R/micropython.bin /code/builds/SAOLA_1R/.
