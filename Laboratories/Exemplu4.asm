bits 32 
;ex 22
global  start 

extern  exit 
import  exit msvcrt.dll
        
segment  data use32 class=data 
a db 5 
b dw 4
c dd 7
d dq 2
;c-(d+d+d)+(a-b)
	
segment  code use32 class=code 
start:   

mov EAX ,[c]
cdq;EDX:EAX=c
mov EBX,EAX
mov ECX,EDX;ECX:EBX = c

mov EAX,[d]
mov EDX,[d+4];EDX:EAX=d

sub EBX,EAX
sbb ECX,EDX;ECX:EBX=c-d
sub EBX,EAX
sbb ECX,EDX;ECX:EBX=c-d-d
sub EBX,EAX
sbb ECX,EDX;ECX:EBX=c-d-d-d sau ECX:EBX=c-(d+d+d)
mov EAX,0
mov al,[a]
cbw
sub AX,[b];AX=a-b
mov EDX,0
cwd
cdq;EDX:EAX=a-b
sub EBX,EAX
sbb ECX,EDX;ECX:EBX=c-(d+d+d) + (a-b)



push    dword 0      
call    [exit]