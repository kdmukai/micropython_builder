

import gc
import io
import png
import qrdecode
import time
import sys

gc.enable()

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
#        img_location = f"psbt_{quirc_max_resolution}x{quirc_max_resolution}.png"
#        img_location = f"9638917d_compact_{quirc_max_resolution}x{quirc_max_resolution}.png"
        img_location = f"8c65eb9f_compact_{quirc_max_resolution}x{quirc_max_resolution}.png"
#        img_location = f"c0ffee_{quirc_max_resolution}x{quirc_max_resolution}.png"
    else:
        img_location = f"c0ffee_{quirc_max_resolution}x{quirc_max_resolution}.png"

    print(f"Before `quirc.init()`: {gc.mem_free()}")
    

    def read_image_as_grayscale():
        start = time.ticks_ms()
        reader = png.Reader(filename=img_location)
        print(f"png.Reader: {time.ticks_ms() - start}ms")

        start = time.ticks_ms()
        width, height, pixels, metadata = reader.asDirect()
        print(f"{width=}, {height=}, {metadata=}")
        print(f"reader.asDirect: {time.ticks_ms() - start}ms")

        start = time.ticks_ms()
        grayscale = []
        num_channels = 3 if not metadata["alpha"] else 4
        for row in pixels:
            for i in range(0, len(row), num_channels):
                grayscale.append(row[i])
        print(f"grayscale convert: {time.ticks_ms() - start}ms")
        return grayscale
    
    grayscale = read_image_as_grayscale()
    
    gc.collect()
    gc.threshold(gc.mem_free() // 4 + gc.mem_alloc())

    start = time.ticks_ms()
    img_data = bytes(grayscale)
    print(f"{len(grayscale)=}")
    print(f"cast to bytes: {time.ticks_ms() - start}ms")
    
    print(f"Before freeing `grayscale`: {gc.mem_free()}")
    grayscale = None
    gc.collect()
    gc.threshold(gc.mem_free() // 4 + gc.mem_alloc())
    print(f"After freeing `grayscale`: {gc.mem_free()}")
    
    start = time.ticks_ms()
    try:
        result = qrdecode.qrdecode(img_data, quirc_max_resolution, quirc_max_resolution)
    except Exception as e:
        print(e)
        result = None
    print(f"qrdecode (grayscale): {time.ticks_ms() - start}ms")
    
    return result




