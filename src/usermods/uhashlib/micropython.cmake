# Create an INTERFACE library for our C module.
add_library(hashlib INTERFACE)

# Add our source files to the lib
target_sources(hashlib INTERFACE
    ${CMAKE_CURRENT_LIST_DIR}/uhashlib/crypto/ripemd160.c
    ${CMAKE_CURRENT_LIST_DIR}/uhashlib/crypto/sha2.c
    ${CMAKE_CURRENT_LIST_DIR}/uhashlib/crypto/hmac.c
    ${CMAKE_CURRENT_LIST_DIR}/uhashlib/crypto/pbkdf2.c
    ${CMAKE_CURRENT_LIST_DIR}/uhashlib/crypto/memzero.c
    ${CMAKE_CURRENT_LIST_DIR}/uhashlib/hashlib.c
    ${CMAKE_CURRENT_LIST_DIR}/uhashlib/uhmac.c
)

# Add the current directory as an include directory.
target_include_directories(hashlib INTERFACE
    ${CMAKE_CURRENT_LIST_DIR}/uhashlib/
    ${CMAKE_CURRENT_LIST_DIR}/uhashlib/crypto
)

# Be sure to set the -O2 "optimize" flag!!
target_compile_options(hashlib INTERFACE
    -O2
)

# Link our INTERFACE library to the usermod target.
target_link_libraries(usermod INTERFACE hashlib)