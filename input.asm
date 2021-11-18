[org 0x7c00]
mov ah, 0x0e
mov bx, string

printString: 
    mov al, [bx]
    cmp al, 0
    je label
    int 0x10
    inc bx
    jmp printString

label:
    mov ah, 0
    int 0x16          ; wait for key press and put character on al

    mov [char], al    ; saves character to variable

    mov ah, 0x0e
    int 0x10          ; prints character

    jmp label

char:
    db 0

string:
    db "Type something: ", 0

times 510-($-$$) db 0
dw 0xaa55