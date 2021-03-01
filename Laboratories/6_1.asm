;Two byte strings s1 and s2 are given. Build the byte string d such that, for every byte s2[i] in s2, 
;d[i] contains either the position of byte s2[i] in s1, either the value of 0.
;parcurg s2,caut fiecare byte 
bits 32 
global start        
extern exit,printf ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
; our data is declared here (the variables needed by our program)
segment data use32 class=data
	s1 db 7, 33, 55, 19, 46; declare the strings of bytes
    lenS1 equ $- s1; compute the length of the string s1 in lenS1
    
    s2 db 33, 21, 7, 13, 27, 19, 55, 1, 46   
    
	
    lenS2 equ $-s2 ; compute the length of the string s2 in lenS2
    

    
	d times lenS2 db 0 ; reserve l bytes for the destination string and initialize it
segment code use32 class=code
start:
   ; mov ecx,lenB
    ;mov dh,0
    mov esi, s2; esi contains the offset of s2
   ; mov ecx,byte lenS2; edx contains the lenght of s2
    mov ebx,d; ebx contains the offset of d 
    
    
       
    
    search:
        mov ah,0
        
        lodsb;al=esi,increments esi (s2)
        mov edi, s1; edi contains the offset of s1 
        mov ecx,dword lenS1; ecx contains lenght of s1
        
        
        lookins1:
            inc ah
            
            
            scasb; search for the byte stored in al in edi (s1)
            je found
            
            
         
        loop lookins1
        found:
            
          
        cmp ecx,0
        je notins1; jump to notins1 if the element is not in s1
        retrn:
        
        mov  [ebx],byte ah; move to the offset from ebx the index  computed by the address from edi - address of s2
        inc ebx
    
    
    cmp esi,d
    jne search
    
    jmp finish;jump to the end of the program
    
    
    
    notins1:
    
        mov ah,byte 0;move to the offset from ebx the value 0
        
        jmp retrn
        
        
        
        
    

    
    finish:
    
        push dword 0 ; push the parameter for exit onto the stack
        call [exit] ; call exit to terminate the program