;se da in segmentul de date un numar, un sir de numere pozitive si un nume de fisier. Sa se creeze fisierul cu acel nume. Sa se scrie in fisier numerele din sirul dat care apar exact de n ori.



bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               
extern fopen
extern fprintf
extern fclose 
import exit msvcrt.dll    
import fopen msvcrt.dll
import fclose msvcrt.dll    
import fprintf msvcrt.dll          

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    space equ ' '
    dot equ '.'
    n dw 2
    sir db 10,2,3,2,10,10,5,5
    endsir db 0
    modread dd 'r',0
    modwrite dd 'a',0
    file dd 'exercitiu4.txt',0
    handle dd -1
    printformat dd '%d ',0
    cont db 1
    

; our code starts here
segment code use32 class=code
    start:
        push dword modwrite
        push dword file
        call [fopen]
        add esp,4*2
        
        cmp eax,0
        je ext
        
        mov [handle],eax
        
        mov esi,sir
        
        repeat:
            
            
            mov [cont],byte 1
            mov edx,0
            mov dl,[esi]
            cmp dl,-1
            je repeat
            mov edi,esi
            mov ecx,endsir
            
            cmp edi,ecx
            je back1
            repeat1:
            
                inc edi
                cmp dl,[edi]
                je increment
                back:
                cmp edi,ecx
                jne repeat1
                
            mov ecx,0
            mov cl,[cont]
            cmp cx,[n]
            je scriere
            back1:
            inc esi
            mov ecx,endsir
            cmp esi,ecx
            jne repeat
                
            
            
            
        jmp final    
            
            
        increment:
            inc byte [cont]
            mov [esi],byte -1
            jmp back
            
        scriere:
            push dword edx
            push dword printformat
            push dword [handle]
            call [fprintf]
            add esp,4*3
            jmp back1
            
            
        final:
        
            push dword [handle]
            call [fclose]
            add esp,4*1
            
        
        
        ext:
        
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program
