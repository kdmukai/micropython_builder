FROM debian:bookworm

# Set up the interactive bash shell to our liking
COPY docker/bashrc /root/.bashrc

RUN apt update

# Setup steps from Espressif for ESP32: https://docs.espressif.com/projects/esp-idf/en/latest/esp32/get-started/linux-macos-setup.html
RUN apt install -y git wget flex bison gperf python3 python3-pip python3-venv cmake ninja-build ccache libffi-dev libssl-dev dfu-util libusb-1.0-0

# RUN pip3 install esptool

# Get ESP-IDF compiler for esp32
# WORKDIR /root

# Compatible with MicroPython v1.22.1
# RUN git clone --branch v5.1.2 --recursive https://github.com/espressif/esp-idf.git

# Compatible with MicroPython v1.25.0
# RUN git clone --branch v5.2.5 --recursive https://github.com/espressif/esp-idf.git

# WORKDIR /root/esp-idf
# RUN ./install.sh esp32,esp32s2,esp32s3

WORKDIR /root
RUN git clone https://github.com/micropython/micropython.git
WORKDIR /root/micropython
RUN git checkout v1.25.0
RUN git submodule update --init lib/micropython-lib
RUN git submodule update --init lib/berkeley-db-1.xx

RUN make -C mpy-cross

# For the unix build
RUN git submodule update --init lib/mbedtls
RUN git submodule update --init lib/libffi

# For rp2 (rp2350) build
RUN apt install -y gcc-arm-none-eabi
WORKDIR /root/micropython/ports/rp2
RUN make submodules
RUN make clean

# For esp32 build
# WORKDIR /root/micropython/ports/esp32
# RUN make submodules
# RUN echo "#define MICROPY_PY_UZLIB (1)" >> mpconfigport.h

# WORKDIR /root
# RUN mkdir usermods
# WORKDIR /root/usermods
# RUN git clone https://github.com/kdmukai/quirc
# WORKDIR /root/usermods/quirc
# RUN git checkout 2025_06_30
# COPY src/usermods/micropython.cmake /root/usermods/micropython.cmake
# COPY src/usermods/quirc/quirc_bindings.c /root/usermods/quirc/quirc_bindings.c
# COPY src/usermods/quirc/micropython.mk /root/usermods/quirc/micropython.mk

# Set up frozen mpy modules
# COPY src/frozen/* /root/micropython/ports/esp32/modules/.



# # Add the esp32-camera driver
# WORKDIR /root/home/esp/esp-idf/components
# RUN git clone -b v2.0.2 https://github.com/espressif/esp32-camera.git

# WORKDIR /root

# # Additional utilities
# RUN apt install -y rsync
# COPY docker/compile.sh compile.sh
# RUN chmod +x compile.sh

# ----------------------------------------------------------------------------------------
# Commented out the rest. I had been cloning repos and doing everything within Docker but
# it was too cumbersome to make changes in dependent repos inside the container. Now
# we keep the dependencies on the local machine but make them available to the container
# so we can browse and edit the repos locally but still see the effect of those changes
# when we build inside the container.
# ----------------------------------------------------------------------------------------


# Build MicroPython firmware from esixtyone's fork of lv_micropython w/his tweaks for esp32-S2
# RUN git clone -b fix/esp32s2-build https://github.com/esixtyone/lv_micropython.git
# WORKDIR /root/lv_micropython

# RUN git submodule update --init --recursive lib/lv_bindings

# Freeze embit into the ESP32 firmware; remove unnecessary dirs, soft link from modules
# WORKDIR /root
# RUN git clone -b v0.5.0 https://github.com/diybitcoinhardware/embit.git
# WORKDIR /code/deps/embit
# RUN rm -rf src/embit/liquid
# RUN rm -rf src/embit/util
# RUN ln -s /code/deps/embit/src/embit /code/deps/lv_micropython/ports/esp32/modules/embit

# Build mpy-cross
# RUN make -C deps/lv_micropython/mpy-cross

# # Setup MicroPython ESP32 support
# WORKDIR /code/deps/lv_micropython/ports/esp32
# RUN make submodules

# Get additional resources as usermods:
# WORKDIR /root
# RUN mkdir usermods
# WORKDIR /root/usermods
# RUN git clone --recursive -b esp32_support https://github.com/kdmukai/secp256k1-embedded.git
# RUN git clone -b esp32s2-s3-compatibility https://github.com/diybitcoinhardware/uhashlib.git

# # Add cmake file for compiling usermods
# COPY docker/micropython.cmake /root/usermods/micropython.cmake

# # Add modified partitions to make more room for larger firmware
# COPY docker/partitions-16MiB-lvgl.csv /root/lv_micropython/ports/esp32/partitions-16MiB-lvgl.csv

# # Raspi RP2040 support
# RUN apt install -y gcc-arm-none-eabi build-essential
# WORKDIR /root/lv_micropython/ports/rp2
# RUN make submodules

# # LVGL font converter
# WORKDIR /root
# RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
# RUN apt install -y nodejs
# RUN npm i lv_font_conv -g


