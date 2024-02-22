# micropython_builder

Docker environment for compiling custom MicroPython firmware.

Initially focused on esp32-S3.


Build the Docker container:
```bash
docker compose build
docker compose up
```

Enter a bash shell inside the container:
```bash
./container_bash.sh
```

Once inside, run the compile script:
```bash
cd /code/docker
./compile.sh
```

The compile script will copy the binaries to /builds.


# Copy firmware to the board
### esp32-S3
```bash
esptool.py -p /dev/tty.usbmodem1101 -b 460800 --before default_reset --chip esp32s3  write_flash --flash_mode dio --flash_size 8MB --flash_freq 80m 0x0 builds/ESP32_GENERIC_S3/bootloader.bin 0x8000 builds/ESP32_GENERIC_S3/partition-table.bin 0x10000 builds/ESP32_GENERIC_S3/micropython.bin
```

### Saola-1R (S2 dev kit)
```bash
cd build/saola_1r
esptool.py -p /dev/tty.usbserial-1110 erase_flash
esptool.py -p /dev/tty.usbserial-2110 -b 460800 --before default_reset --chip esp32s2  write_flash --flash_mode dio --flash_size detect --flash_freq 80m 0x1000 builds/SAOLA_1R/bootloader.bin 0x8000 builds/SAOLA_1R/partition-table.bin 0x10000 builds/SAOLA_1R/micropython.bin
```



## Interact with the board

### `ampy`
Install the `ampy` tool:
```bash
pip install adafruit-ampy
```

```bash
# List the files on the board
ampy -p /dev/tty.usbserial-1110 ls

# Transfer files.
ampy -p /dev/tty.usbmodem1234561 put tests/img/c0ffee_120x120.png
ampy -p /dev/tty.usbmodem1234561 put tests/test_quirc.py

# Transfer a whole directory
ampy -p /dev/tty.usbserial-1110 put mydir

# Run an arbitrary local python file on the ESP32 (not recommended; use mpremote -- see below)
ampy -p /dev/tty.usbserial-1110 run test.py
```


### `mpremote`
Offers similar features to `ampy` but also provides an interactive REPL option. Runs local scripts more reliably.

```bash
pip install mpremote
```

```bash
# Run a local file on the device
mpremote connect /dev/tty.usbserial-1110 run demos/secp256k1_test.py

# Enter the interactive REPL
mpremote connect /dev/tty.usbmodem1234561 repl

# List files on the device
mpremote connect /dev/tty.usbserial-1110 ls

# Mount the current dir to make its files available as if it was onboard, then run
#   a test file that depends on those imports.
mpremote connect /dev/tty.usbserial-1110 mount . run blah/some_test_file.py

```

