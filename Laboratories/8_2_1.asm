;Read numbers (in base 10) in a loop until the digit '0' is read from the keyboard. Determine and display the biggest number from those that have been read.
bits 32
global start
extern exit, printf, scanf 
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
nr dd 0
maxnr dd 0


format_read db '%d', 0
result_format db 'Maximum number = %d',0


segment code use32 class=code
start:
    push dword maxnr
    push dword format_read
    call [scanf]
    add esp,4*2 ;this sequence was used to set the max number as the first number given from the keyboard
    mov eax,[maxnr]
    mov [nr],eax;give to nr the value of maxnr
    



    read_numbers:
        
        mov ebx,[nr]
        cmp ebx, dword 0
        je found_zero  ; checks if the number is 0 and jumps to the end of the problem if it's the case
        
        push dword nr
        push dword format_read
        call [scanf]
        add esp,4*2
        mov ebx,  [nr] ; reads a new value for nr and moves it to ebx
        
        cmp ebx,[maxnr] 
        jg isgreater ; jumps if nr>maxnr
        bck:
        
        mov ecx,dword 2 ; give ecx 2 so the loop will repeat itself, the only way to get out is by giving 0
    loop read_numbers
    
    
    isgreater:
        mov [maxnr], ebx ; if nr>maxnr maxnr will take his value 
        jmp bck; jumps back in the loop
    
    



    found_zero:
        push dword [maxnr]
        push dword result_format
        call [printf] ; prints the result
        add esp,4*2;
        


push dword 0
call [exit];end program