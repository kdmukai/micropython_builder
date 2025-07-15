#!/bin/bash
cp -R /code/src/frozen/* /root/micropython/ports/rp2/modules/.


# Trim embit submodule
rm -rf /root/micropython/ports/rp2/modules/embit/docs
rm -rf /root/micropython/ports/rp2/modules/embit/examples
rm -rf /root/micropython/ports/rp2/modules/embit/secp256k1
rm -rf /root/micropython/ports/rp2/modules/embit/tests
rm -rf /root/micropython/ports/rp2/modules/embit/src/embit/liquid
rm -rf /root/micropython/ports/rp2/modules/embit/src/embit/util
rm -rf /root/micropython/ports/rp2/modules/embit/.git*
rm /root/micropython/ports/rp2/modules/embit/.pre-commit-config.yaml
rm /root/micropython/ports/rp2/modules/embit/LICENSE
rm /root/micropython/ports/rp2/modules/embit/pyproject.toml
rm /root/micropython/ports/rp2/modules/embit/README.md
rm /root/micropython/ports/rp2/modules/embit/setup.py

# Move the actual python files to the package root for proper import
mv /root/micropython/ports/rp2/modules/embit/src/embit/* /root/micropython/ports/rp2/modules/embit/.
rm -rf /root/micropython/ports/rp2/modules/embit/src
echo "Removed unnecessary files from embit module"


# export BOARD_NAME=RPI_PICO2
export BOARD_NAME=SPARKFUN_PROMICRO_RP2350
echo "Building for board: $BOARD_NAME"


make -C /root/micropython/ports/rp2 BOARD=$BOARD_NAME clean
make -C /root/micropython/ports/rp2 BOARD=$BOARD_NAME USER_C_MODULES=/root/usermods/micropython.cmake


export TARGET_BUILD_DIR=/code/builds/$BOARD_NAME
mkdir -p $TARGET_BUILD_DIR
cp /root/micropython/ports/rp2/build-$BOARD_NAME/firmware.uf2 $TARGET_BUILD_DIR/.
echo "Build files copied to $TARGET_BUILD_DIR"
