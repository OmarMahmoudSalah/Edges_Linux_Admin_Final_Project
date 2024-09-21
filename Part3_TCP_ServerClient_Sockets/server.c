/*
 * server.c
 *
 *  Created on: Sep 5, 2024
 *      Author: omar
 */
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <signal.h>

/********** Global Variables / Structs Decleration *********/
int PortNumber = 3500;
char No_of_Connections = 3;
char ErrorStatus = 0;
int forkstatus;
///////////// Socket Data /////////////
int SocketFile_Descriptor;
struct sockaddr_in binding_server_struct;
int Server_Struct_length;
int SocketOptions = 1;
/////////////  Client Data /////////////
int ClientFile_Descriptor;
struct sockaddr_in client_addr_struct;
socklen_t Client_Struct_length;
const char Max_Command_Length = 100;
int CommandReturnValue;

/********** Function Definitions *********/
void Server_Create_Socket(void) {
	/*	int socket(int __domain, int __type, int __protocol)
	 Create a new socket of type TYPE in domain DOMAIN, using
	 protocol PROTOCOL. If PROTOCOL is zero, one is chosen automatically.
	 Returns a file descriptor for the new socket, or -1 for errors.
	 AF_INET : IPv4 Connection type
	 SOCK_STREAM : TCP
	 0: IP Protocol
	 */
	SocketFile_Descriptor = socket(AF_INET, SOCK_STREAM, 0);
    /*
    setsockopt function is used to configure socket options in a TCP or UDP network
    SOL_SOCKET: This specifies that you are setting a socket-level option,
                as opposed to a protocol-specific option.
    SO_REUSEADDR : allows a socket to bind to an address that is already in use by another socket.
                 This is particularly useful when you want to restart a server
    Allow reuse of local addresses for binding to support quick server restarts
    */
    ErrorStatus = setsockopt(SocketFile_Descriptor, SOL_SOCKET, SO_REUSEADDR,
			&SocketOptions, sizeof(SocketOptions));
	// check if options are set successfully
	if (ErrorStatus < 0) {
		perror("Couldn't set options");
		exit(EXIT_FAILURE);
	}
	if (SocketFile_Descriptor < 0) {
		perror("Error Occured While Creating Socket File Descriptor \n");
		perror("Exit Status -1");
		exit(-1);
	}
	// initializing structure elements for address
	binding_server_struct.sin_family = AF_INET; //IPv4
	binding_server_struct.sin_port = htons(PortNumber);
	binding_server_struct.sin_addr.s_addr = INADDR_ANY; // Address to accept any incoming messages.
	Server_Struct_length = sizeof(binding_server_struct);
	
	printf("Socket Created \n");

}
void Server_Bind_Socket(void) {
	/*
	 bind (): Give the socket FD the local address ADDR (which is LEN bytes long).
	 */
	ErrorStatus = bind(SocketFile_Descriptor,
			(const struct sockaddr*) &binding_server_struct,
			Server_Struct_length);
	if (ErrorStatus < 0) {
		perror("Binding Error");
		exit(EXIT_FAILURE);
	}
	printf("Socket Binded \n");

}
void Server_Listen_socket(void) {

	/*listen():Prepare to accept connections on socket FD.
	N connection requests will be queued before further requests are refused.
	Returns 0 on success, -1 for errors.*/

	ErrorStatus = listen(SocketFile_Descriptor, No_of_Connections);
	if (ErrorStatus < 0) {
		perror("Couldn't listen for connections");
		exit(EXIT_FAILURE);
	}
	printf("Socket Listening \n");

}
void Server_Accept_Socket(void) {
	/*Accept(): Await a connection on socket FD.
	When a connection arrives, open a new socket to communicate with it,
	set *ADDR (which is *ADDR_LEN bytes long) to the address of the connecting
	peer and *ADDR_LEN to the address's actual length, and return the
	new socket's descriptor, or -1 for errors.*/

	Client_Struct_length = sizeof(client_addr_struct);
	ClientFile_Descriptor = accept(SocketFile_Descriptor,
			(struct sockaddr*) &client_addr_struct, &Client_Struct_length);
	if (ClientFile_Descriptor < 0) {
		perror("Couldn't establish connection with client");
		exit(EXIT_FAILURE);
	}
	printf("New Socket Accepted \n");

}
void sig_int_handler(int sig_nb) {
	printf("\nReceived SIGINT, terminating server...\n");
	close(SocketFile_Descriptor);
	exit(0);
}

void sigchld_handler(int sig) {
    // Clean up all child processes that have terminated
    while (waitpid(-1, NULL, WNOHANG) > 0);
}

int main() {
	// Define the Signal Handlers
	// Handles Ctrl+c Requests by user
	signal(SIGINT, sig_int_handler); //Interactive attention signal.

	// Register a signal handler for SIGCHLD to clean up terminated child processes
	// This prevents zombie processes by reaping child processes as they exit,
	signal(SIGCHLD, sigchld_handler); //Child terminated or stopped.
	Server_Create_Socket();
	Server_Bind_Socket();
	Server_Listen_socket();
	char ReceivedCommand_Array[Max_Command_Length];

	while (1) {
		Server_Accept_Socket();

		/*fork(): Clone the calling process, creating an exact copy.
		Return -1 for errors, 0 to the new process,
		and the process ID of the new process to the old proces*/

		forkstatus = fork();
		if (forkstatus == 0) {
			// Excuting Child Code
			while (1) {
				//Clearing the buffer before receiving a new command
				memset(ReceivedCommand_Array, 0, sizeof(ReceivedCommand_Array));
				// Receive data sent by the client
				read(ClientFile_Descriptor, ReceivedCommand_Array,
						Max_Command_Length);
				printf("Command received from client: %s \n",
						ReceivedCommand_Array);
				// check for "stop" command
				if (strncmp(ReceivedCommand_Array, "stop", 4) == 0) {
					printf("Stopping communication with client\n");
					break; // Closes Socket
				}
				// system(): Execute the given line as a shell command.
				// Added Command Return Value to check for Exit Status
				CommandReturnValue = system(ReceivedCommand_Array);
				printf("The Command Return = %d\n", CommandReturnValue);
				/*Converting the return value to network byte order*/
				int x = htonl(CommandReturnValue);

				/*Sending the return value back to the client.*/
				send(ClientFile_Descriptor, &x, sizeof(x), 0);
			}
			// Close Client Socket if Stop requested
			close(ClientFile_Descriptor);
			exit(0);  // Make sure the child process exits

		} else {
			// Excuting Parent Code , Now Child is handling Connections
			close(ClientFile_Descriptor);
		}

	}

	/*Closing the Server Socket*/
		close(SocketFile_Descriptor);
		return 0;
}

