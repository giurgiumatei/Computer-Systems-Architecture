;Se da un fisier text care contine litere, spatii si puncte. Sa se citeasca continutul fisierului, 
;sa se determine numarul de cuvinte si sa se afiseze pe ecran aceasta valoare. (Se considera cuvant orice secventa de litere separate prin spatiu sau punct)

bits 32

global start

extern exit, fopen, fread, fclose, printf
import exit msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    file_name db '8_4.txt', 0
    access_mode db 'r', 0
    file_descriptor dd -1
    buffer_size equ 100
    word_flag db 1
    space equ ' '
    point equ '.'
    buffer resb buffer_size
    counter dd 0
    format db '%d', 0
    
    
    
segment code use32 class=code
    start:
        push dword access_mode
        push dword file_name
        call [fopen]; open the imput file
        add esp, 4*2;clear stack
        cmp eax, 0
        je finish; jump to the end of the program in case of error
        mov [file_descriptor], eax; file handle is stored in file_descriptor
        
        file_loop:
            push dword [file_descriptor]
            push dword buffer_size
            push dword 1
            push dword buffer
            call [fread]; read one byte from the text file
            add esp, 4*4
            cmp eax, 0
            je after; if file content is done jump after
            
            mov ecx, eax; ecx=eax meaning the lenght of the text
            cld; clear directional flag
            mov esi, buffer; esi now contains the text
            buffer_loop:;loop trough the text
                lodsb;Al=esi,increment esi
                cmp al, space;check if the character is a space
                je punctuation; jump to punctuation if it is space
                cmp al, point; check if the character is a dot
                je punctuation; jump to punctuation if it is a dot
                
                cmp byte [word_flag], 1; check if we found a word
                jne skip;jump to skip if not the case
                inc dword [counter]; word counter is incremented
                mov byte [word_flag], 0; word flag is reseted
                jmp skip
                
                punctuation:
                mov byte [word_flag], 1; if it is punctuation word flag is set to 1
                
                skip:
            loop buffer_loop;
        jmp file_loop
        after:
        
        push dword [counter]
        push dword format
        call [printf]; print the counter
        add ESP, 4*2
        
        push dword [file_descriptor]
        call [fclose]; close file
        add ESP, 4
        
        finish:
        push dword 0
        call [exit]