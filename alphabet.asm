mov ah, 0x0e
mov al, 'A'
int 0x10

loop:
    inc al
    ; Compares to enforce end on alphabet
    cmp al, 'Z' + 1 
    je exit
    cmp al, 'z' + 1
    je exit
    ; Compares to alternate cases
    cmp al, 'a'
    jl lowercase
    jg capital

continue:
    int 0x10
    jmp loop

lowercase:
    ; Adds to make lowercase
    add al, 32
    jmp continue

capital:
    ; Subtracts to make capital
    sub al, 32
    jmp continue

exit:
    jmp $

times 510-($-$$) db 0
db 0x55, 0xaa