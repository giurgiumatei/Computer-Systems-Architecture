bits 32 

global start        


extern exit               
import exit msvcrt.dll    
    


segment data use32 class=data
 
 a db 1
 b dw 2
 c dd 150
 d dq 20
 


 


segment code use32 class=code

start:   



mov EAX,[d]
mov EDX,[d+4];EDX:EAX=d
add EAX,[c]
add EDX,0;EDX:EAX=d
mov EBX,EAX
mov ECX,EDX;ECX:EBX=d+c
mov EAX,0
mov AX,[b]
cwd
add EAX,[c];EAX=b+c
mov EDX,0
cdq;EDX:EAX=b+c
sub EBX,EAX
sbb ECX,EDX;ECX:EBX=(d+c)-(c+b)
mov EAX,0
mov al,[a]
cbw
add AX,[b];AX=b+a
cwd
cdq;EDX:EAX=b+a
sub EBX,EAX
sbb ECX,EDX;ECX:EBX=(d+c)-(c+b)-(b+a)



push    dword 0      
call    [exit]       