# Caesar_cipher_cmakelist.txt
###############################################################
set(CAESAR_CIPHER_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/src)
set(CAESAR_CIPHER_INC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/inc)
###############################################################
# Source files
set(CAESAR_CIPHER_SRC_FILES
    ${CAESAR_CIPHER_SRC_DIR}/caesar_encrypt.c
    ${CAESAR_CIPHER_SRC_DIR}/caesar_decrypt.c
)
###############################################################
# Create object files and archive them into a static library
add_library(caesar_cipher STATIC ${CAESAR_CIPHER_SRC_FILES})
target_include_directories(caesar_cipher PRIVATE ${CAESAR_CIPHER_INC_DIR})
###############################################################
# Ensure object files are placed in the gen folder
set_target_properties(caesar_cipher PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY ${APP_LIB_DIR}
    COMPILE_PDB_OUTPUT_DIRECTORY ${APP_OBJ_DIR}
    COMPILE_OUTPUT_DIRECTORY ${APP_OBJ_DIR}
)

