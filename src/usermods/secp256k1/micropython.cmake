# Create an INTERFACE library for our C module.
add_library(secp256k1 INTERFACE)

# Add our source files to the lib
target_sources(secp256k1 INTERFACE
    ${CMAKE_CURRENT_LIST_DIR}/secp256k1-embedded/secp256k1/src/secp256k1.c
    ${CMAKE_CURRENT_LIST_DIR}/secp256k1-embedded/mpy/config/ext_callbacks.c
    ${CMAKE_CURRENT_LIST_DIR}/secp256k1-embedded/mpy/libsecp256k1.c
)

# Add the current directory as an include directory.
target_include_directories(secp256k1 INTERFACE
    ${CMAKE_CURRENT_LIST_DIR}/secp256k1-embedded/secp256k1
    ${CMAKE_CURRENT_LIST_DIR}/secp256k1-embedded/secp256k1/src
    ${CMAKE_CURRENT_LIST_DIR}/secp256k1-embedded/mpy/config
)
# Be sure to set the -O2 "optimize" flag!!
target_compile_options(secp256k1 INTERFACE
    -DHAVE_CONFIG_H 
    -Wno-unused-function
    -Wno-error
    -O2
)

# Link our INTERFACE library to the usermod target.
target_link_libraries(usermod INTERFACE secp256k1)

