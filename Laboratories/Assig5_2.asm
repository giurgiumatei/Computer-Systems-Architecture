;Two byte strings A and B are given. Obtain the string R by concatenating the elements of B in reverse order and the negative elements of A
bits 32 
global start        
extern exit,printf ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
; our data is declared here (the variables needed by our program)
segment data use32 class=data
	a db 2, 1, -3, 3, -4, 2, 6; declare the string of bytes
    b db 4, 5, 7, 6, 2, 1
	lenA equ $-a ; compute the length of the string a in lenA
    lenB equ $-b ; compute the length of the string b in lenB
    lenZero equ $-b-6;compute the value 0 in lenZero
	r times lenA+lenB db 0 ; reserve l bytes for the destination string and initialize it
segment code use32 class=code
start:
    mov esi, lenA
    mov edi, 0

    repeat1:
        dec esi;esi-=1
        mov al, [b+esi] ; AL <- the byte from the offset b+esi
        
        mov [r+edi], al ; r <- the byte from al

        inc edi ; edi+=1
        
        cmp esi, lenZero
        ja repeat1 ; IF 0<esi repeat
        ; otherwise continue below
    
    repeat2:
        mov al,[a+esi]
        mov bl,0
        cmp bl,al;check if byte is less than 0
        jl isneg
        inc esi
        cmp esi,lenA
        jb repeat2;if esi<lenA do it again
        
        
    isneg:
        mov [r+edi],al ;add byte in r
        inc edi ;  edi:=edi+1; move to the next index in string r
        inc esi;  esi:=esi+1; move to the next index in string a
        jmp repeat2
        
        
        
	push dword 0 ; push the parameter for exit onto the stack
	call [exit] ; call exit to terminate the program