;Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de caractere speciale si sa se afiseze aceasta valoare.
; Numele fisierului text este definit in segmentul de date.

bits 32
global start
; declare external functions needed by our program
extern exit, perror, fopen, fclose, fread, fwrite, rename, remove,fprintf
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fwrite msvcrt.dll
import fclose msvcrt.dll
import rename msvcrt.dll
import remove msvcrt.dll
import perror msvcrt.dll
import fprintf msvcrt.dll

segment data use32 class=data
    inputfile db '8_3_in.txt', 0 ;input file
    outputfile db '8_3_out.txt', 0;output file
    modread db 'r', 0; file reading mode
    modwrite db 'w', 0; file writing mode
    c db 0; each character will be stored here
    handle1 dd -1; handle for the input file
    handle2 dd -1; handle for the output file
    result_format db '%d',0
    cont db 0;counter for special characters 

segment code use32 class=code
start:  
    
    
    push dword modread
    push dword inputfile
    call [fopen];open the input file
    add esp,4*2;clear stack
    mov [handle1],eax; stores the file handle in handle 1
    
    cmp eax,0
    je error;check for errors and end the program if jump is made
    
    push dword modwrite
    push dword outputfile
    call [fopen];open output file
    add esp,4*2
    mov [handle2],eax; stores the file handle in handle 2
    
    cmp eax,0
    je error
    
    repeat: ;we read the file in this loop
        push dword [handle1]
        push dword 1
        push dword 1
        push dword c
        call [fread];read the byte from the file and store it in c
        add esp,4*4
        
        cmp eax,0
        je error; jump to the error label when file handle will be 0 meaning that we're done reading the file
        
        mov al,[c]; al= value of c
        
        check_small_letter: ; check if its a small letter
        cmp al,'z'
        jbe check1
        
        check_big_letter:; check if is a capital letter
        cmp al,'Z'
        jbe check2
        
        check_is_number:; check it is a number
        cmp al,'9'
        jbe check3
        
        is_special:
        add byte [cont],1; if it is a special character increment cont
        
        not_the_case:
        jmp repeat ;repeat the loop untill an error will occur
        
        
        
        
        
        
    check1:
    cmp al,'a'
    jb check_big_letter
    jmp not_the_case
    
    check2:
    cmp al,'A'
    jb check_is_number
    jmp not_the_case
    
    check3:
    cmp al,'0'
    jb is_special; here all checks are passed and can be considered a special character
    jmp not_the_case
    
    
    error:
    
    
    push dword [cont]
    push dword result_format
    push dword [handle2]
    call [fprintf] ; write the result in the output file
    add esp,4*3
    
    push dword [handle1]
    call [fclose];close the first file
    add esp,4*1
    
    push dword [handle2];close the second file
    call [fclose]
    add esp,4*1
    
    push dword 0 ; push the parameter for exit onto the stack
    call [exit]; terminate program
    
        
        
        
        
    
    
    
    
    
    

    
    
