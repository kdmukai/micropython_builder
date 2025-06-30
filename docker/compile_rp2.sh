#!/bin/bash
cp -R /code/src/frozen/* /root/micropython/ports/rp2/modules/.
make -C /root/micropython/ports/rp2 BOARD=ADAFRUIT_FEATHER_RP2350 USER_C_MODULES=/code/src/usermods/micropython.cmake clean
make -C /root/micropython/ports/rp2 BOARD=ADAFRUIT_FEATHER_RP2350 USER_C_MODULES=/code/src/usermods/micropython.cmake DEBUG=1
