section .data
    kmer_length db 0

section .bss
    chars resb 20

section .text
global _start

_start:
    ; flags
    %ifdef FEATURE_1KMERS
        mov byte [kmer_length], 1
    %elifdef FEATURE_2KMERS
        mov byte [kmer_length], 2
    %elifdef FEATURE_3KMERS
        mov byte [kmer_length], 3
    %elifdef FEATURE_4KMERS
        mov byte [kmer_length], 4
    %elifdef FEATURE_5KMERS
        mov byte [kmer_length], 5
    %elifdef FEATURE_6KMERS
        mov byte [kmer_length], 6
    %elifdef FEATURE_7KMERS
        mov byte [kmer_length], 7
    %elifdef FEATURE_8KMERS
        mov byte [kmer_length], 8
    %elifdef FEATURE_9KMERS
        mov byte [kmer_length], 9
    %elifdef FEATURE_10KMERS
        mov byte [kmer_length], 10
    %elifdef FEATURE_11KMERS
        mov byte [kmer_length], 11
    %elifdef FEATURE_12KMERS
        mov byte [kmer_length], 12
    %elifdef FEATURE_13KMERS
        mov byte [kmer_length], 13
    %elifdef FEATURE_14KMERS
        mov byte [kmer_length], 14
    %elifdef FEATURE_15KMERS
        mov byte [kmer_length], 15
    %elifdef FEATURE_16KMERS
        mov byte [kmer_length], 16
    %elifdef FEATURE_17KMERS
        mov byte [kmer_length], 17
    %elifdef FEATURE_18KMERS
        mov byte [kmer_length], 18
    %elifdef FEATURE_19KMERS
        mov byte [kmer_length], 19
    %else
        mov byte [kmer_length], 15
    %endif
    
    mov ecx, dword [kmer_length]
    mov esi, chars
    mov eax, 'A'
    rep stosb

loop_start:
    inc dword [edi]
    cmp dword [chars + edi - 1], 'T'
    jne inner_loop

    mov ecx, dword [kmer_length]
    mov esi, chars
    mov eax, 'A'
    rep stosb

inner_loop:
    cmp ebx, dword [kmer_length]
    jge loop_start

    mov al, byte [chars + ebx]
    call convert

    mov byte [chars + ebx], al

    cmp al, 'T'
    jne inner_loop

    jmp loop_start


convert:
    cmp al, 'A'
    je .convert_a
    cmp al, 'C'
    je .convert_c
    cmp al, 'G'
    je .convert_g
    cmp al, 'T'
    je .convert_t

.invalid_char:
    mov al, ' '
    ret

.convert_a:
    mov al, 'C'
    ret

.convert_c:
    mov al, 'G'
    ret

.convert_g:
    mov al, 'T'
    ret

.convert_t:
    mov al, 'A'
    ret
