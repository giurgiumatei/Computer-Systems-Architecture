bits 32 ; assembling for the 32 bits architecture
 
; declare the EntryPoint (a label defining the very first instruction of the program)
global start        
 
; declare external functions needed by our program
extern exit   ,fopen, fread, isdigit, fprintf  ,printf,fclose          ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import fread msvcrt.dll
import isdigit msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll
import fclose msvcrt.dll
 
                         
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...A text file is given. Read the content of the file, determine the digit with the highest frequency and display the digit along ;with its frequency on the screen. The name of text file is defined in the data segment.
    handle dd -1
    frecv resb 128
    modwrite db 'w', 0
    filename db 'txt.in', 0
    printformat db 'digit with highest frequency is: %c', 0
    modread db 'r', 0
    c db 0
    max db 0
    cnt db 0
; our code starts here
segment code use32 class=code
    start:
        ;opening the file
        push dword modread
        push dword filename
        call [fopen]
        add esp, 4*2
       
       
        cmp eax, 0
        je .FileNotFound
       
        mov [handle], eax
       
       
        mov ecx, 0
        .repeat1:
       
       
        ;read 1 byte - 1 character at a time
        push dword [handle]
        push dword 1
        push dword 1
        push dword c
        call [fread]
        add esp, 4*4
       
       
       
        ;check if end of file
        cmp eax, 0
        je .End
   
        ;check if it s digit
       
        xor eax, eax
        mov al, [c]
        push eax
        call [isdigit] ;returns 0 if its not digit 1 if it is
        add esp, 4
       
        cmp eax, dword 0
       
        je .Notdigit
       
        ;if it s a digit increase it s frequency
        ;frecv[c] += 1
        xor ebx, ebx
        mov bl,[c]
        mov esi, frecv
        inc byte [esi+ebx]
       
        ;we check if it s maximum we keep max in ecx
        xor eax, eax
        mov al, byte [esi+ebx]
        xor ecx, ecx
        mov cl, [cnt]
        cmp eax, ecx
        jle .Smaller
        mov bl ,[c]
        mov [max], bl
        mov [cnt], eax
       
       
        .Smaller:
        .Notdigit:
        jmp .repeat1
        .End:
       
        ;printing result
       
        push dword [max]
        push dword printformat
        call [printf]
        add esp, 4*3
       
       
        ;close file
        push dword [handle]
        call [fclose]
        add esp, 4
       
        ;open file for writing
        push dword modwrite
        push dword filename
        call [fopen]
        add esp, 8
        mov [handle], eax
        ;fprintf(..handle)
       
       
        push dword [max]
        push dword printformat
        push dword [handle]
        call [fprintf]
        add esp, 4*3
        .FileNotFound:
       
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program