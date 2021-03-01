bits 32 
global start        
extern exit,printf ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
; our data is declared here (the variables needed by our program)
segment data use32 class=data
	a dw 1,2,3,4
    b dw 1234h,0055h
    
segment code use32 class=code
start:


xor ah,ah
cwde
add ebx,eax
mov al,[ebx]
mov [a], ebx
mov [a], [ebx]



push dword 0 ; push the parameter for exit onto the stack
call [exit] ; call exit to terminate the program