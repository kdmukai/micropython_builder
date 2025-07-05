# Create an INTERFACE library for our C module.
add_library(quirc INTERFACE)

# Add our source files to the lib
target_sources(quirc INTERFACE
    ${CMAKE_CURRENT_LIST_DIR}/quirc/lib/decode.c
    ${CMAKE_CURRENT_LIST_DIR}/quirc/lib/identify.c
    ${CMAKE_CURRENT_LIST_DIR}/quirc/lib/quirc.c
    ${CMAKE_CURRENT_LIST_DIR}/quirc/lib/version_db.c
    ${CMAKE_CURRENT_LIST_DIR}/quirc_bindings.c
 )

# Add the current directory as an include directory.
target_include_directories(quirc INTERFACE
    ${CMAKE_CURRENT_LIST_DIR}
)

target_compile_definitions(quirc INTERFACE
    # force quirc to use single precision floating point math
    -DQUIRC_FLOAT_TYPE=float
    -DQUIRC_USE_TGMATH=1
)

# Be sure to set the -O2 "optimize" flag!!
target_compile_options(quirc INTERFACE
    -O2
)

# Link our INTERFACE library to the usermod target.
target_link_libraries(usermod INTERFACE quirc)

