section .data
    output db 'Fibonacci Sequence: '

section .bss
    fib resd 10 ; Reserves space for 10 4-byte integers

section .text
    global _start

_start:
    mov dword [fib], 0
    mov dword [fib + 4], 1

    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, 21
    int 0x80

    mov ecx, 8 ; Counter variable
.next_fib:
    mov eax, [fib + ecx * 4 - 4]
    add eax, [fib + ecx * 4 - 8]
    mov [fib + ecx * 4], eax

    push ecx ; Save the counter variable on the stack
    push eax ; Save the number on the stack
    call print_num
    add esp, 8 ; Clean up the stack

    cmp ecx, 1
    je done
    mov eax, 4
    mov ebx, 1
    mov ecx, ', '
    mov edx, 2
    int 0x80

    dec ecx
    jmp .next_fib

done:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    mov eax, 1
    xor ebx, ebx
    int 0x80

print_num:
    push ebx ; Save the pointer to the string on the stack
    mov ebx, esp ; Set the pointer to the beginning of the buffer
    mov edx, 0 ; Initialize the character count

    cmp dword [esp], 0
    jge .not_negative
    mov byte [ebx], '-'
    inc ebx
    neg dword [esp]

.not_negative:
    .convert_loop:
        mov eax, dword [esp]
        cdq
        div dword [ten]
        add eax, '0'
        mov byte [ebx], al
        inc ebx
        inc edx
        cmp dword [esp], 0
        jne .convert_loop

    mov byte [ebx], 0

    dec ebx ; Back up one character from the null terminator
    .reverse_loop:
        cmp ebx, esp
        jle .done_reversing
        xchg byte [ebx], byte [esp]
        inc esp
        dec ebx
        jmp .reverse_loop

    .done_reversing:
        ; Print the string to stdout
        mov eax, 4
        mov ebx, 1
        mov ecx, esp
        mov edx, edx ; Use the character count as the length
        int 0x80

        pop ebx ; Restore the pointer to the string from the stack
        ret

section .data
    ten dd 10 ; For use in the print_num function
    newline db 10 ; Newline character for output formatting
