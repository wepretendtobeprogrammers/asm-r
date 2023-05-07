section .data
    array db 6, 3, 8, 4, 2, 9, 1 ; Example array
    array_len equ $ - array       ; Length of the array

section .text
    global _start

_start:
    mov ebx, array

outer_loop:
    xor ecx, ecx       ; Index variable i
    mov dl, 1          ; Flag variable swapped

inner_loop:
    mov al, [ebx + ecx]
    cmp al, [ebx + ecx + 1]

    jle no_swap
    mov bl, [ebx + ecx + 1]
    xchg al, bl
    mov [ebx + ecx], al
    mov [ebx + ecx + 1], bl
    mov dl, 0          ; Set swapped flag to false

no_swap:
    inc ecx

    cmp ecx, array_len - 1
    jne inner_loop

    cmp dl, 1
    jne outer_loop

    mov eax, 1
    xor ebx, ebx
    int 80h
