bits 32 


global start        


extern exit               
import exit msvcrt.dll    
                          


segment data use32 class=data
    a db 1
    b db 2
    c db 3
    d db 4
    e dq 11223344

; our code starts here
segment code use32 class=code
    start:
       mov ax,22
       mov [b],ax
       mov dl,[c]
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
