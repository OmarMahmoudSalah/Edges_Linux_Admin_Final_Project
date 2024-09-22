# Linux Administration Project
## Part 1: Bash Scripting

### Script: `userdef`
This script creates a new user and group, assigns the user to the group, and performs various configurations.

#### Usage
```bash
./userdef <username> <userpass> <groupname>
```

#### Features
- Checks if the required arguments are passed.
- Ensures the script is run with `sudo` permissions.
- Creates a new user with a home directory and Bash as the default shell.
- Assigns a password to the new user.
- Displays user and group information.
- Creates a new group with ID=200.
- Adds the new user to the new group.
- Modifies the user's UID to 1600 and sets the primary group.

### Script: 2ndScript
This script creates directories and files, archives them, copies them to the new user's home directory, and extracts them.

#### Features
- Checks if the directory exists and removes it if it does.
- Creates a directory and four files (`main.c`, `main.h`, `hello.c`, `hello.h`).
- Writes a message in each file.
- Compresses the directory into a tar file.
- Copies the tar file to the new user's home directory and extracts it.
- Switches to the new user and performs various file operations.

## Part 2: Makefiles & CMake
### Overview
This part of the project focuses on building the cryptographic algorithm modules using Makefiles and CMake, ensuring that the project is organized and easy to compile.

### Project Structure
- **Modules**: Two directories for cryptographic algorithms:
  - **Caesar Cipher**: Implementation of the Caesar cipher algorithm.
  - **XOR Cipher**: Implementation of the XOR cipher algorithm.
  
- **Application**: A main application that utilizes the libraries generated from the modules.

- **Directories**:
  - `src/`: Contains the source code for the modules and the main application.
  - `libs/`: Contains the compiled libraries for the cryptographic algorithms.
  - `gen/`: Contains all generated object files.

### Build Instructions

#### Using Makefiles
Navigate to the project root directory.
Run the following command to build the project:
```bash
   make
   ```
#### Using CMake

 **Create a build directory:**
```bash
   mkdir build
   cd build
   ```
### Dependencies
- Ensure you have `gcc` and `make` installed for building with Makefiles.
- CMake must be installed to use CMake for building the project.



## Part 3: Client-Server Architecture

### Overview
This part of the project implements a client-server architecture using TCP, allowing the server to handle multiple client connections concurrently.

### Server: `server.c`
The server listens on port 3500 and forks processes for each client connection. It receives shell commands from clients, executes them, and sends back the results.

#### Features
- Listens on a specified port for incoming client connections.
- Forks a new process for each client, enabling concurrent handling.
- Implements signal handling for graceful shutdown on SIGINT.
- Executes shell commands received from clients.
- Sends the output or error messages back to the clients.

### Client: `client.c`
The client connects to the server, sends shell commands, and receives the output.

#### Features
- Establishes a TCP connection to the server.
- Sends user-defined shell commands.
- Receives and displays the command output or error messages.

### Compilation Instructions
- Use the following commands to compile the server and client:
```bash
gcc server.c -o server
gcc client.c -o client
   ```
## Author
Omar Mahmoud Salah
## License
This project is licensed under the MIT License.
