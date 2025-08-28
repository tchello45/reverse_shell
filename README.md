# A reverse shell in NASM for Linux

The goal of this project is to create a simple reverse shell using NASM (Netwide Assembler) for Linux systems. A reverse shell is a type of shell where the target machine opens a connection to an attacking machine, allowing the attacker to execute commands on the target system.

Our `reverse_shell.asm` will connect to a remote listener `nc -lvnp 8080` listening on port 8080.

The reverse shell constist of 6 syscalls.

## Required Syscalls

| Syscall Name  | Purpose                                          | Syscall Number |
| ------------- | ------------------------------------------------ | :------------: |
| `sys_socket`  | Create a socket                                  |       41       |
| `sys_connect` | Connect to a remote server (our netcat listener) |       42       |
| `sys_dup2`    | Duplicate file descriptors                       |       33       |
| `sys_execve`  | Execute a program                                |       59       |
| `sys_exit`    | Exit the program                                 |       60       |

We use the `sys_socket` to create a socket file descriptor. This file descriptor will be used to establish a connection to the attacker's machine. Via this file descriptor messages can be read and sent.

With the `sys_connect` syscall, we connect to the attacker's machine on the specified port (8080 in this case) and bring our socket file descriptor to life.

Now the shell will use standard input, output, and error file descriptors (0, 1, and 2). But we want to redirect these file descriptors to our socket, so that any input/output/error goes through the socket.

To achieve this, we use the `sys_dup2` syscall to duplicate our socket file descriptor to the standard file descriptors.

Last but not least, we use the `sys_execve` syscall to execute a shell (`/bin/sh`) with the socket file descriptor as its standard input/output/error.
