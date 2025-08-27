section .data
    address:
        dw 2
        dw 0x901F
        dd 0x0100007F
        dq 0

    address_len equ $ - address

    msg db "Hello from the ASM client!", 0xa
    msg_len equ $ - msg

section .bss
    socket_fd resq 1

section .text
    global _start

_start:
    mov rax, 41
    mov rdi, 2
    mov rsi, 1
    mov rdx, 0
    syscall

    mov [socket_fd], rax

    mov rax, 42
    mov rdi, [socket_fd]
    mov rsi, address
    mov rdx, address_len
    syscall

    mov rax, 1
    mov rdi, [socket_fd]
    mov rsi, msg
    mov rdx, msg_len
    syscall

    mov rax, 60
    mov rdi, 0
    syscall