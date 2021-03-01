;A character string S is given. Obtain the string D containing all small letters from the string S
bits 32 
global start        
extern exit,printf ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
; our data is declared here (the variables needed by our program)
segment data use32 class=data
	s db 'a', 'A', 'b', 'B', '2', '%', 'x'; declare the string of bytes
	lenS equ $-s ; compute the length of the string s in lenS
	d times lenS db 0 ; reserve l bytes for the destination string and initialize it
segment code use32 class=code
start:
    mov esi, 0
    mov edi, 0
    
   

    repeat:
        cmp esi, lenS
        jae finish
        mov al, [s+esi] ; AL <- the byte from the offset s+esi
        cmp al,'z' ;check if byte is below z
        jbe check1; jump to check1 if below z
        

        inc esi ; esi:=esi+1; move to the next index in string s
        cmp esi, lenS
        jb repeat ; IF (esi < lenS1) jump to repeat,
    ; otherwise continue below
    
        
    
    check1:
        cmp al,'a';check if byte is above a
        jae islower;jump to islower if above a
        inc esi;inc esi if jae is not made
        jmp repeat
        
    
    islower:
        mov [d+edi],al ;add byte in d
        inc edi ;  edi:=edi+1; move to the next index in string d
        inc esi;  esi:=esi+1; move to the next index in string s
        jmp repeat
       
	
    finish:
    push dword 0 ; push the parameter for exit onto the stack
    call [exit] ; call exit to terminate the program
    