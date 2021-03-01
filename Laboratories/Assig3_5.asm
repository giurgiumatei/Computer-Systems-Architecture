bits 32 

global start        


extern exit               
import exit msvcrt.dll    
    


segment data use32 class=data
 
 a dd 1
 b db 9
 c dw 3
 x dq 20
 
segment code use32 class=code

start:   

; (a+b/c -1)/(b+1)-x = -18

mov dx, 0; dx: 3,ax: 9=30009/c 
mov al,[b]
cbw;AX=b
idiv word [c];AX=b/c
cwd
add EAX,[a];EAX=a+b/c
sub EAX,1;EAX=a+b/c-1
mov EBX,EAX;EBX=a+b/c-1
mov al,[b]
cbw
cwd;EAX=b
add EAX,1;EAX=b+1
xchg EAX,EBX;EAX and EBX swap values
mov EDX,0
idiv EBX;EAX=(a+b/c-1)/(b+1)
cdq;EDX:EAX=(a+b/c-1)/(b+1)
sub EAX,[x]
sbb EDX,[x+4];EAX=(a+b/c-1)/(b+1) -x








push    dword 0      
call    [exit]  