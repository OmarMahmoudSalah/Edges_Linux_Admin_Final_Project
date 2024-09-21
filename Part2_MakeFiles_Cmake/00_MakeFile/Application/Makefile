# Main Directories
CC=gcc
ROOT_DIR = ..
APP_DIR = $(ROOT_DIR)/Application
MODULES_DIR = $(ROOT_DIR)/Modules
CFLAGS_INCLUDE= -I$(CAESAR_CIPHER_DIR)/inc -I$(XOR_CIPHER_DIR)/inc

OBJ=$(APP_OBJ)/app.o $(APP_LIB_DIR)/lib_xor.so $(APP_LIB_DIR)/lib_caesar.a


# Modules Directories
CAESAR_CIPHER_DIR = $(MODULES_DIR)/caesar_cipher
XOR_CIPHER_DIR =$(MODULES_DIR)/xor_cipher
# Application Directories
APP_OUT_DIR = $(APP_DIR)/out
APP_OBJ_DIR = $(APP_OUT_DIR)/gen
APP_LIB_DIR = $(APP_OUT_DIR)/libs

# Application Source files
APP_SRC = $(APP_DIR)
# Application Object files
APP_OBJ = $(APP_OBJ_DIR)

include $(CAESAR_CIPHER_DIR)/caesar_cipher.mk
include $(XOR_CIPHER_DIR)/xor_cipher.mk


# Create necessary directories
setup:
	mkdir -p $(APP_OBJ_DIR) $(APP_LIB_DIR)
	
all:app.o
	$(CC) $(APP_OBJ)/app.o $(CFLAGS_INCLUDE) -L$(APP_LIB_DIR) $(APP_LIB_DIR)/lib_caesar.a $(APP_LIB_DIR)/lib_xor.so -o output
# 3) Compile the app source file to generate the app object file (one rule)

app.o:setup lib_caesar.a lib_xor.so
	$(CC) -c $(APP_SRC)/app.c -o $(APP_OBJ)/app.o -I$(CAESAR_CIPHER_DIR)/inc -I$(XOR_CIPHER_DIR)/inc

clean:
	rm -rf $(APP_OBJ_DIR) $(APP_LIB_DIR) $(APP_OUT_DIR) output

