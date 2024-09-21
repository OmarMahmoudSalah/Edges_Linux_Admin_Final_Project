
XOR_CFLAGS = -I $(XOR_CIPHER_INC) -fPIC 

# Modules Source files
XOR_CIPHER_SRC = $(XOR_CIPHER_DIR)/src
# Modules Headers files

XOR_CIPHER_INC = $(XOR_CIPHER_DIR)/inc

# Modules Object files
XOR_CIPHER_OBJ = $(APP_OBJ_DIR)
# Modules Library files
XOR_CIPHER_LIB = $(APP_LIB_DIR)


#- a rule to link these 2 object files into a dynamic library file
lib_xor.so:xor_object $(XOR_CIPHER_OBJ)/xor_encrypt.o $(XOR_CIPHER_OBJ)/xor_decrypt.o xor_object
	$(CC) $(XOR_CIPHER_OBJ)/xor_encrypt.o $(XOR_CIPHER_OBJ)/xor_decrypt.o -shared -o $(XOR_CIPHER_LIB)/lib_xor.so

#2) Compile and generate the xor_cipher dynamic library:
#- a rule to compile the 2 source files and generate 2 object files 
xor_object:$(XOR_CIPHER_SRC)/xor_encrypt.c $(XOR_CIPHER_SRC)/xor_decrypt.c
	$(CC) -c  $(XOR_CIPHER_SRC)/xor_encrypt.c -o $(XOR_CIPHER_OBJ)/xor_encrypt.o $(XOR_CFLAGS)
	$(CC) -c  $(XOR_CIPHER_SRC)/xor_decrypt.c -o $(XOR_CIPHER_OBJ)/xor_decrypt.o $(XOR_CFLAGS)


