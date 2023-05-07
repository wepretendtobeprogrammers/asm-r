section .data
    array db 6, 3, 8, 4, 2, 9, 1 ; Example array
    array_len equ $ - array       ; Length of the array

section .text
    global _start

_start:
    mov ebx, array

outer_loop:
    xor ecx, ecx ; Index variable i
    mov al, 255 ; Minimum element variable min_val
    mov edx, ecx ; Index of minimum element variable min_idx

inner_loop:
    cmp ecx, array_len
    jge swap
    mov bl, [ebx + ecx]
    cmp bl, al
    jge no_swap
    mov al, bl
    mov edx, ecx

no_swap:
    inc ecx
    jmp inner_loop

swap:
    mov al, [ebx + edx]
    xchg al, [ebx]
    mov [ebx + edx], al

    add ebx, 1

    cmp ebx, array + array_len
    jl outer_loop

    mov eax, 1
    xor ebx, ebx
    int 80h
