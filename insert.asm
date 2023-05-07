section .data
    array db 6, 3, 8, 4, 2, 9, 1 ; Example array
    array_len equ $ - array       ; Length of the array

section .text
    global _start

_start:
    mov ebx, array

outer_loop:
    xor ecx, ecx ; Index variable i

inner_loop:
    cmp ecx, 0
    jle done_inner

    mov al, [ebx + ecx]
    mov bl, [ebx + ecx - 1]
    cmp al, bl

    jge done_inner
    xchg al, bl
    mov [ebx + ecx], al
    mov [ebx + ecx - 1], bl

    dec ecx
    jmp inner_loop

done_inner:
    add ebx, 1

    cmp ebx, array + array_len
    jl outer_loop

    mov eax, 1
    xor ebx, ebx
    int 80h
