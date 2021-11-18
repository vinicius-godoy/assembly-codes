[org 0x7c00]
mov ch, 0 ; defines counter

main:
    mov bx, welcomeString ; defines buffer to string
.print:
    mov ah, 0x0e ; sets up output mode
    mov al, [bx] ; puts welcomeString in the register
    cmp al, 0 ; compares if the string ended
    je prepareBufferInput ; if yes then jump to input getter
    int 0x10 ; otherwise print the char on the register
    inc bx ; increments the register's adress to continue printing
    jmp .print ; repeat loop

prepareBufferInput:
    mov bx, buffer ; sets up buffer to get string
    jmp getInput

getInput: 
    mov ah, 0 ; sets up input mode
    int 0x16 ; waits for input
    cmp ch, 10 ; compare counter to 10 (word limit)
    je printResult ; if yes then jump to print the results
    mov [bx], al ; otherwise puts char on buffer
    mov ah, 0x0e ; sets up output mode
    int 0x10 ; print the char inputted
    inc ch ; increment counter
    inc bx ; increment address
    jmp getInput ; repeat loop

printResult:
    mov bx, endingString
.printAgain:
    mov ah, 0x0e 
    mov al, [bx] 
    cmp al, 0 
    je prepareBufferOutput 
    int 0x10 
    inc bx 
    jmp .printAgain 

prepareBufferOutput:
    mov bx, buffer
    mov ch, 0
    jmp printString 

printString: 
    mov ah, 0x0e 
    mov al, [bx] 
    cmp ch, 10 
    je end 
    int 0x10 
    inc ch
    inc bx
    jmp printString

buffer:
    times 10 db 0

welcomeString:
    db "Type a 10 letter word: ", 0

endingString:
    db "| You typed: ", 0

end:
    jmp $

times 510-($-$$) db 0
dw 0xaa55