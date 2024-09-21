AR=ar

CAESAR_CFLAGS = -I $(CAESAR_CIPHER_INC)

# Modules Source files
CAESAR_CIPHER_SRC = $(CAESAR_CIPHER_DIR)/src
# Modules Headers files
CAESAR_CIPHER_INC = $(CAESAR_CIPHER_DIR)/inc
# Modules Object files
CAESAR_CIPHER_OBJ = $(APP_OBJ_DIR)
# Modules Library files
CAESAR_CIPHER_LIB = $(APP_LIB_DIR)

#- a rule to archive these 2 object files into a library file
lib_caesar.a: caesar_cipher_object $(CAESAR_CIPHER_OBJ)/caesar_encrypt.o $(CAESAR_CIPHER_OBJ)/caesar_decrypt.o 
	$(AR) -cr $(CAESAR_CIPHER_LIB)/lib_caesar.a $(CAESAR_CIPHER_OBJ)/caesar_encrypt.o $(CAESAR_CIPHER_OBJ)/caesar_decrypt.o
	
#- a rule to compile the 2 source files and generate 2 object files 
caesar_cipher_object:$(CAESAR_CIPHER_SRC)/caesar_encrypt.c $(CAESAR_CIPHER_SRC)/caesar_decrypt.c
	$(CC) -c $(CAESAR_CIPHER_SRC)/caesar_encrypt.c -o $(CAESAR_CIPHER_OBJ)/caesar_encrypt.o $(CAESAR_CFLAGS)
	$(CC) -c $(CAESAR_CIPHER_SRC)/caesar_decrypt.c -o $(CAESAR_CIPHER_OBJ)/caesar_decrypt.o $(CAESAR_CFLAGS)
	

