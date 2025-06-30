# esp32-S3

## Wiring the OV2640 camera

The Waveshare OV2640 Camera Module board has two rows of 9 pins. Each row will be connected to the esp32-S3 Dev Kit C roughly as a continuous group (minus the XCLK pin and avoiding GPIO 3 and 46).

```
OV2640      ESP32-S3 Dev Kit C
-----------------
3.3V        3V3
SIOC         14
VSYNC        13
PCLK         12
D9           11
D7           10
D5            9
D3            8
RET         (not connected)

GND         GND
SIOD        17 (SDA)
HREF        16
XCLK        18 (CLK_OUT_3)
D8          15
D6           7
D4           6
D2           5
PWDN        (not connected)
```
