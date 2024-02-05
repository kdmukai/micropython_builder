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
