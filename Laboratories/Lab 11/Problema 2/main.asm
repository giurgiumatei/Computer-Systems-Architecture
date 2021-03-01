;Se citeste din fisierul numere.txt un sir de numere.
; Sa se determine sirul destinatie D care contine numerele din sirul initial cu valorile dublate dar in ordine inversa din sirul initial. 
;Sa se afiseze sirul obtinut pe ecran.
;Ex: s: 12, 2, 4, 5, 0, 7 => 14, 0, 10, 8, 4, 24

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
            ; tell nasm that exit exists even if we won't be defining it

            
extern exit,printf,fread,fclose,fopen            
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import fopen msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
%include "modul1.asm"

segment data use32 class=data
    
    space equ ' '
    cont db 0
    inputfile db 'numere_lab11.txt', 0 ;input file
    modread db 'r', 0; file reading mode
    handle1 dd -1; handle for the input file
    format db '%d', 0
    
    sir times 100 dd 0
    nr db 0
    
    
    ; ...

; our code starts here
segment code use32 class=code
start:

    push dword modread
    push dword inputfile
    call [fopen];open the input file
    add esp,4*2;clear stack
    mov [handle1],eax; stores the file handle in handle 1
    
    cmp eax,0
    je error;check for errors and end the program if jump is made
    
    mov esi,sir;esi now has the offset of sir
    
    repeat: ;we read the file in this loop
        push dword [handle1]
        push dword 2
        push dword 1
        push dword nr
        call [fread];read the byte from the file and store it in nr
        add esp,4*4
        
        cmp eax,0
        je error; jump to the error label when file handle will be 0 meaning that we're done reading the file
        inc byte  [cont]
        
        mov eax,0
        mov al,[nr]
        cmp al, space;check if the character is a space
        je is_space
        
        
        push dword [nr]
        call dublare ; call the dublare 'function' from modul1.asm
   
    
        mov [esi],ebx ; the result from dublare is stored in ebx, so we have to move it in nr
        add esi,4
    jmp repeat;do it again
    
    
    is_space:
    mov [esi],al
    add esi,4
    jmp repeat
        
    
        
        
    error:
    
        push dword [handle1]
        call [fclose];close the file
        add esp,4*1
        sub esi,4;we have to decrement esi in order to be at the offset of it's last element
        
    mov ecx,0
    mov cl,[cont];ECX=cont
    std;DF=1
    
    
    display:
        lodsd;EAX=ESI,ESI=ESI-4
        push dword eax
        push dword format
        call [printf];print the number
        add esp,4*2
    loop display
    
    
    
    
    
;push    dword 0      ; push the parameter for exit onto the stack
;call    [exit]       ; call exit to terminate the program