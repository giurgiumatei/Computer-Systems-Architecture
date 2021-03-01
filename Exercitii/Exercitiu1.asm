


bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit
extern fscanf
extern fopen
extern fclose
extern printf
import fscanf msvcrt.dll
import fopen msvcrt.dll
import printf msvcrt.dll     
import fclose msvcrt.dll         
import exit msvcrt.dll    

; our data is declared here (the variables needed by our program)
segment data use32 class=data

modread db 'r',0
inputfile db 'numere.txt',0
handle dd -1
print_format dd '%d',0
read_format dd '%d',0
space equ ' '
a dd 0
cont dd 0



  
  
  
segment code use32 class=code
    start:
        
        push dword modread
        push dword inputfile
        call [fopen]
        add esp, 4*2
        
        cmp eax,0
        je final
        
        mov [handle],eax
        
        repeat:
        
            
            push dword a
            push dword read_format
            push dword [handle]
            call [fscanf]
            add esp,4*3
            
            cmp eax,-1
            je final
            
            mov eax,[a]
            cmp eax,space
            je repeat
            
            mov bl,2
            div bl
            cmp AH,0
            je is_odd
            jmp repeat
            
           
            
            
            
        is_odd:
            inc dword [cont]
            jmp repeat
            
            
            
        
            
            
        final:
        
            push dword [handle]
            call [fclose]
            add esp,4
            
            push dword [cont]
            push dword print_format
            call [printf]
            add esp,4*2
        
        
        
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program
