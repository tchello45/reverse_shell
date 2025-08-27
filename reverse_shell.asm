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
    response_buffer resb 1024

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

    mov rax, 0
    mov rdi, [socket_fd]
    mov rsi, response_buffer
    mov rdx, 1024
    syscall

    mov r10, rax

    mov rcx, rax
    mov rdi, response_buffer
    mov al, 0xa 

    repne scasb

    dec rdi
    mov byte [rdi], 0 


    mov rax, 1
    mov rdi, 1
    mov rsi, response_buffer
    mov rdx, r10
    syscall

    mov rax, 60
    mov rdi, 0
    syscall