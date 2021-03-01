
;Se cere se se citeasca numerele a, b si c ; sa se calculeze si sa se afiseze a+b-c.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
            ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll
extern exit,printf,scanf
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
%include "calcul.asm"

segment data use32 class=data
    format1 db 'a=',0
    format2 db 'b=',0
    format3 db 'c=',0
    format4 db 'The result is %d ',0
    readformat db '%d',0
    a dd 0
    b dd 0
    c dd 0
    x dd 0
    ; ...

; our code starts here
segment code use32 class=code
start:
    push dword format1
    call [printf]
    add esp,4*1 ;print a=
    
    push dword a
    push dword readformat
    call [scanf]
    add esp ,4*2; read a and clear stack
    
    push dword format2
    call [printf]
    add esp,4*1;print b=
    
    push dword b
    push dword readformat
    call [scanf]; read b and clear stack
    add esp, 4*2
    
    push dword format3
    call [printf]
    add esp,4*1;print c=
    
    push dword c
    push dword readformat
    call [scanf]; read c and clear stack
    add esp ,4*2
    
    
    push dword [c]
    push dword [b]
    push dword [a]
    call calcule ; call the calcule 'function' from the calcul module
   
    
    mov [x],ebx ; the result from calcul is stored in ebx, so we have to move it in x
    push dword [x]
    push dword format4
    call [printf] ;print the result
    add esp,4*2
    
    
    
    
       
       
push    dword 0      ; push the parameter for exit onto the stack
call    [exit]       ; call exit to terminate the program
