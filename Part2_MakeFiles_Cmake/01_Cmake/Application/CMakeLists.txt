cmake_minimum_required(VERSION 3.10)
####################################################################################
# Set the project name and version
project(Encrypt_Decrypt_App
	VERSION 1.0
	DESCRIPTION "App for Final Project"
	LANGUAGES C)
# Main Directories
####################################################################################
set(ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/..)
set(APP_DIR ${ROOT_DIR}/Application)
set(MODULES_DIR ${ROOT_DIR}/Modules)
####################################################################################
# Set output directories
set(APP_OUT_DIR ${APP_DIR}/out)
set(APP_OBJ_DIR ${APP_OUT_DIR}/gen)  # Object files directory
set(APP_LIB_DIR ${APP_OUT_DIR}/libs)
####################################################################################
# Set .o directories
set(CAESAR_OBJECT_LOCATION ${CMAKE_BINARY_DIR}/caesar_cipher_build/CMakeFiles/caesar_cipher.dir/src)
set(XOR_OBJECT_LOCATION ${CMAKE_BINARY_DIR}/xor_cipher_build/CMakeFiles/xor_cipher.dir/src)
set(APP_OBJECT_LOCATION ${CMAKE_BINARY_DIR}/CMakeFiles/output.dir)
####################################################################################
# Add subdirectories to allow building additional build files of the modules
add_subdirectory(${MODULES_DIR}/caesar_cipher ${CMAKE_BINARY_DIR}/caesar_cipher_build)
add_subdirectory(${MODULES_DIR}/xor_cipher ${CMAKE_BINARY_DIR}/xor_cipher_build)

####################################################################################
# Include directories for caesar and XOR modules
include_directories(
	${MODULES_DIR}/caesar_cipher/inc 
	${MODULES_DIR}/xor_cipher/inc)

# Source files
set(APP_SRC ${APP_DIR})
set(APP_SRC_FILES ${APP_SRC}/app.c)

# Create executable and link libraries
add_executable(output ${APP_SRC_FILES})
target_link_libraries(output PRIVATE xor_cipher caesar_cipher)

# Ensure object files are placed in the gen folder
set_target_properties(output PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY ${APP_DIR}
    COMPILE_PDB_OUTPUT_DIRECTORY ${APP_DIR}
    COMPILE_OUTPUT_DIRECTORY ${APP_DIR}
    )

# Workaround of custom command to copy .o files to gen folder
add_custom_command(
	TARGET output POST_BUILD
	COMMAND ${CMAKE_COMMAND} -E make_directory ${APP_OBJ_DIR}
	COMMAND ${CMAKE_COMMAND} -E copy_if_different ${CAESAR_OBJECT_LOCATION}/*.o ${APP_OBJ_DIR}
	COMMAND ${CMAKE_COMMAND} -E copy_if_different ${XOR_OBJECT_LOCATION}/*.o ${APP_OBJ_DIR}
	COMMAND ${CMAKE_COMMAND} -E copy_if_different ${APP_OBJECT_LOCATION}/*.o ${APP_OBJ_DIR}
	COMMENT "Copying object files  to ${APP_OBJ_DIR}"
)
# Custom clean target
add_custom_target(clean_all_edges
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${APP_OBJ_DIR}
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${APP_LIB_DIR}
    COMMAND ${CMAKE_COMMAND} -E remove ${APP_OUT_DIR}/output
    COMMENT "Cleaning all files"
)
