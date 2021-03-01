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

;(c+b+b)-(c+a+d) = -17

mov EBX,[c];EBX=c
mov AX,[b]
cwd;EAX=b
add EBX,EAX;EBX=c+b
add EBX,EAX;EBX=c+b+b
mov EAX,[c]
cdq;EDX:EAX=c
add EAX,[d]
add EDX,[d+4];EDX:EAX=c+d
mov ECX,EAX;EDX:ECX=c+d
mov EAX,0
mov EAX,EBX;EAX=c+b+b
mov EBX,EDX;EBX:ECX=c+d
mov EDX,0
cdq;EDX:EAX=c+b+b
sub EAX,ECX
sbb EDX,EBX;EDX:EAX=c+b+b -(c+d)
mov EBX,EAX
mov ECX,EDX;ECX:EBX=c+b+b -(c+d)
mov EAX,0
mov al,[a]
cbw
cwd
cdq;EDX:EAX=a
sub EBX,EAX
sbb ECX,EDX;ECX:EBX=c+b+b -(c+a+d)






push    dword 0      
call    [exit]  