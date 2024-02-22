#define MICROPY_HW_BOARD_NAME               "ESP32S2 module"
#define MICROPY_HW_MCU_NAME                 "ESP32S2"

#define MICROPY_PY_BLUETOOTH                (0)
#define MICROPY_HW_ENABLE_SDCARD            (0)

// Enable UART REPL for modules that have an external USB-UART and don't use native USB.
#define MICROPY_HW_ENABLE_UART_REPL         (1)


// The offset only has an effect if a board has psram
// it allows the start of the range allocated to
#define MICROPY_ALLOCATE_HEAP_USING_MALLOC (1)
#define MICROPY_HEAP_SIZE_REDUCTION (512 * 1024)


// #ifndef CONFIG_QUIRC_QR_MAX_HOR_RES
// #define CONFIG_QUIRC_QR_MAX_HOR_RES (120)
// #endif

// #ifndef CONFIG_QUIRC_QR_MAX_VER_RES
// #define CONFIG_QUIRC_QR_MAX_VER_RES (120)
// #endif

