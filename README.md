# A position independent reverse shell in NASM for Linux

The goal of this project is to create a simple reverse shell using **NASM** (Netwide Assembler) for Linux systems. A reverse shell is a type of shell where the target machine opens a connection to an attacking machine, allowing the attacker to execute commands on the target system.

Our `reverse_shell.asm` will connect to a remote listener, which can be set up using a command like `nc -lvnp 8080` listening on port 8080.

## Compile and run

To compile the `reverse_shell.asm` file, you can use the following command:

```bash
nasm -f elf64 reverse_shell.asm -o reverse_shell.o
```

Then, link the object file to create the final executable:

```bash
ld reverse_shell.o -o reverse_shell
```

Finally, run the reverse shell:

```bash
./reverse_shell
```

## Explanation

The reverse shell consists of four key syscalls.

---

## Required Syscalls

| Syscall Name  | Purpose                                          | Syscall Number |
| :------------ | :----------------------------------------------- | :------------: |
| `sys_fork`    | Create a fork of the original process            |       57       |
| `sys_mmap`    | Memory mapping                                   |       9        |
| `sys_socket`  | Create a socket                                  |       41       |
| `sys_connect` | Connect to a remote server (our netcat listener) |       42       |
| `sys_dup2`    | Duplicate file descriptors                       |       33       |
| `sys_execve`  | Execute a program                                |       59       |

We use the `sys_fork` syscall to create a child process. This allows us to run the reverse shell in the background while still maintaining control of the original process. In our example we will terminate the original process after forking.

We use the `sys_mmap` syscall to create a memory region that will hold a buffer for our socket file descriptor.

We use the `sys_socket` syscall to create a socket file descriptor. This file descriptor will be used to establish a connection to the attacker's machine. Messages can be read from and sent to the attacker via this file descriptor.

With the `sys_connect` syscall, we connect to the attacker's machine on the specified port (8080 in this case), which brings our socket file descriptor to life.

Now, the shell will use standard input, output, and error file descriptors (0, 1, and 2). However, we want to redirect these file descriptors to our socket so that any input, output, and errors go through the socket instead.

To achieve this, we use the `sys_dup2` syscall to duplicate our socket file descriptor to the standard file descriptors.

Last but not least, we use the `sys_execve` syscall to execute a shell (`/bin/sh`) with the socket file descriptor as its standard input/output/error.
