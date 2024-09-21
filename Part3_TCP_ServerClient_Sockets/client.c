/*
 * client.c
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
#include <arpa/inet.h>

/********** Global Variables / Structs Decleration *********/
char ErrorStatus = 0;
/////////////  Client Data /////////////
const char Max_Command_Length = 100;
int ClientFile_Descriptor;
struct sockaddr_in client_addr_struct;
int Client_Struct_length;

/********** Function Definitions *********/
void Client_Create_Socket(void){

    // Create an Ipv4 and TCP socket
    ClientFile_Descriptor = socket(AF_INET,SOCK_STREAM,0);
    // Check whether the socket is created successfully
    if(ClientFile_Descriptor<0)
    {
        perror("Socket Creation Failed");
        exit(EXIT_FAILURE);
    }
}
void Client_Connect_Socket(char * ip_address ,char * Port_array){
    int port_number=atoi(Port_array);
    // Initialize address structure for binding
    client_addr_struct.sin_family = AF_INET;
    client_addr_struct.sin_port = htons(port_number);
    client_addr_struct.sin_addr.s_addr = inet_addr(ip_address);
    
    Client_Struct_length=sizeof(client_addr_struct);
    // Connect to the server
    ErrorStatus=connect(ClientFile_Descriptor,(struct sockaddr*)&client_addr_struct,
                     Client_Struct_length);
    if(ErrorStatus<0)
    {
        perror("Couldn't connect with the server");
        exit(EXIT_FAILURE);
    }

}
/****************** Client Code ******************/

int main(int argc, char *argv[])
{
	if (argc != 3)
	{
        perror("Please pass the remote IP/Port as arguments");
        exit(EXIT_FAILURE);
	}
    
    Client_Create_Socket();
    Client_Connect_Socket(argv[1],argv[2]);

    while (1)
    {
        /*Get the command from the CLI*/
        printf("Please enter the command: ");
        char command[Max_Command_Length];
        fgets(command, sizeof(command), stdin);

        /*Send command to the server*/
        printf("Sending command to server... ");
        send(ClientFile_Descriptor, command, strlen(command), 0);

        /*Receive the Return value from the server*/
        int command_return;
        recv(ClientFile_Descriptor, &command_return, sizeof(int), 0);
        printf("Message from server: %d\n", ntohl(command_return));

        /*This condition to Check that if the received command is Stop to End the Communication with the Server*/
        if (strncmp(command, "stop", 4) == 0)
        {
            printf("Stopping communication with server\n");
            break;
        }
    }

        /*Closes the socket, terminating the connection to the server*/
        close(ClientFile_Descriptor);
    return 0;
}


