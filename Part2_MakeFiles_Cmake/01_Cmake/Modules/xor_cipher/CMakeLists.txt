# xor_cipher_cmakelist.txt
###############################################################
set(XOR_CIPHER_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)
set(XOR_CIPHER_INC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/inc)
###############################################################
# Source files
set(XOR_CIPHER_SRC_FILES
    ${XOR_CIPHER_SRC_DIR}/xor_encrypt.c
    ${XOR_CIPHER_SRC_DIR}/xor_decrypt.c
)
###############################################################
# Create object files and link them into a shared library
add_library(xor_cipher SHARED ${XOR_CIPHER_SRC_FILES})
target_include_directories(xor_cipher PRIVATE ${XOR_CIPHER_INC_DIR})
###############################################################
# Ensure object files are placed in the gen folder
set_target_properties(xor_cipher PROPERTIES
    LIBRARY_OUTPUT_DIRECTORY ${APP_LIB_DIR}
    COMPILE_PDB_OUTPUT_DIRECTORY ${APP_OBJ_DIR}
    COMPILE_OUTPUT_DIRECTORY ${APP_OBJ_DIR}
)

