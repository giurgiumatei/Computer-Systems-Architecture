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

;a-b-(c-d)+d = -151

mov al,[a]
cbw;AX=a
sub AX,[b];AX=a-b
cwd
cdq;EDX:EAX=a-b
add EAX,[d]
adc EDX,[d+4];EDX:EAX=a-b+d
mov EBX,EAX
mov ECX:EDX;ECX:EBX=a-b+d
mov EAX,[c]
mov EDX,0
cdq
sub EAX,[d]
sbb EDX,[d+4];EDX:EAX=c-d
sub EBX,EAX
sbb ECX,EDX;ECX:EBX=a-b-(c-d)+d








push    dword 0      
call    [exit]  