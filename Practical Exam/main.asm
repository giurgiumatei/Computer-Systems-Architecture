bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit 
extern fscanf
extern fopen
extern fclose
extern fprintf
             
import exit msvcrt.dll   
import fscanf msvcrt.dll
import fopen msvcrt.dll
import fclose msvcrt.dll
import fprintf msvcrt.dll 
                          

; our data is declared here (the variables needed by our program)
segment data use32 class=data



n dd 0
counter1 dd 0
counter2 dd 1
sir db 'a','b','c','d','e','f','g','h','i','j'
modread dd 'r',0
modwrite dd 'a',0
readformat dd '%d',0
writeformat dd '%c',0
input_file dd 'input.txt',0
handle dd -1
handle1 dd -1
output_file db 'output-i.txt'
counter db '0'
misc resd 0
dot_txt db '.txt'

    ; ...

; our code starts here
segment code use32 class=code
    start:
        
        push dword  modread
        push dword input_file
        call [fopen] ;open input file
        
        add esp,4*2
        
        cmp eax,dword 0
        je final
        
        mov [handle],eax ;handle=input file
        
        push dword n
        push dword readformat
        push dword [handle]
        call [fscanf]
        add esp,4*3 ;read the number n from input file
        
        mov ebx,0
        mov ebx,[n];ebx=n
        
        mov esi,output_file
        add esi,7 ; esi= the position of i
        
        repeat:
            mov [counter1],dword 0 ;this counter shows how many characters to be written in this iteration
            mov edx,[counter]; counts the  number i in the file name
            mov [esi],edx
            add esi,1
            mov edx,[dot_txt]
            mov [esi],edx
            sub esi,1;now the file has the right name
        
            push dword modwrite
            push dword output_file
            call [fopen]
            add esp,4*2;create and open a new file
            
            cmp eax,dword 0
            je final
            
            mov [handle1],eax; handle1 is the output file
            
            
            
            inc byte [counter]
            
            mov edi,sir
            sub edi,1
            repeat1:
                add edi,1;shows which character must be written
            
                push dword [edi]
                push dword writeformat
                push dword [handle1]
                call [fprintf]
                add esp,4*3;prints a character
                
                inc dword [counter1]
                mov eax,[counter2]
               ; sub edi,[counter1]
                cmp eax,[counter1];checks if the number of characters required was written
                jne repeat1
                
            inc dword [counter2];increases the number of characters that need to be written
            push dword [handle];close the file
            call [fclose]
            add esp,4*1
            
            sub ebx, byte 1
            cmp ebx,0
            jne repeat;decrease ebx (n)
        
        
        
        
        
        
    final:
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

