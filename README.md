# A reverse shell in NASM for Linux

The goal of this project is to create a simple reverse shell using NASM (Netwide Assembler) for Linux systems. A reverse shell is a type of shell where the target machine opens a connection to an attacking machine, allowing the attacker to execute commands on the target system.

Our `reverse_shell.asm` will connect to a remote listener `nc -lvnp 8080` listening on port 8080.