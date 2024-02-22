




# def ascii_print(img, width, height):
#     from io import StringIO
#     buf = StringIO()
#     for x in range(0, width, 8):
#         for y in range(0, height, 8):
#             pixel = img[x*width + y]
#             if pixel == 0:
#                 buf.write("  ")
#             elif pixel == 2**8 - 1:
#                 buf.write("X ")
#             else:
#                 buf.write("? ")
#         buf.write("\n")
#     buf.seek(0)
#     print(buf.read())

import png
import quirc
import time
import sys

if sys.platform == 'esp32':
    import machine
    if machine.freq() != 240_000_000:
        machine.freq(240_000_000)  # 240MHz
        print("Set CPU frequency to 240MHz")
elif sys.platform == 'linux':
    img_location = "/code/tests/img/" + img_location


def run_test(quirc_max_resolution: int = 120):
    print(f"{quirc_max_resolution=}")

    if quirc_max_resolution == 240:
        img_location = f"psbt_{quirc_max_resolution}x{quirc_max_resolution}.png"
    else:
        img_location = f"c0ffee_{quirc_max_resolution}x{quirc_max_resolution}.png"

    start = time.ticks_ms()
    reader = png.Reader(filename=img_location)
    print(f"png.Reader: {time.ticks_ms() - start}ms")

    start = time.ticks_ms()
    width, height, pixels, metadata = reader.asDirect()
    print(f"reader.asDirect: {time.ticks_ms() - start}ms")

    start = time.ticks_ms()
    grayscale = []
    for row in pixels:
        for i in range(0, len(row), 3):
            grayscale.append(row[i])
    print(f"grayscale convert: {time.ticks_ms() - start}ms")


    start = time.ticks_ms()
    quirc.init(quirc_max_resolution, quirc_max_resolution)
    print(f"quirc.init: {time.ticks_ms() - start}ms")

    start = time.ticks_ms()
    img_data = bytes(grayscale)
    print(f"cast to bytes: {time.ticks_ms() - start}ms")

    start = time.ticks_ms()
    quirc.load_framebuffer(img_data)
    print(f"quirc.load_framebuffer: {time.ticks_ms() - start}ms")

    start = time.ticks_ms()
    quirc.scan()
    print(f"quirc.scan: {time.ticks_ms() - start}ms")

    start = time.ticks_ms()
    data = quirc.get_data()
    print(f"quirc.get_data: {time.ticks_ms() - start}ms")
    print(data)

