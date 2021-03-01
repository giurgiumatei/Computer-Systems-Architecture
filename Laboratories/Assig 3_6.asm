bits 32 

global start        


extern exit               
import exit msvcrt.dll    
    


segment data use32 class=data
 
 a dd 9
 b db 2
 e dw 3
 x dq 20
 
segment code use32 class=code

start:   

 ;x-b+8+(2*a-b)/(b*b)+e= 35


mov al,[b]
sub al,[b]
sub al,[b]
cbw
cwd;EAX=-b
add EAX,8;EAX=-b+8
mov EBX,EAX;EBX=-b+8                            EBX
mov EAX,0
mov EAX,[a]
add EAX,[a]
mov EDX,EAX;EDX=2*a                       
mov EAX,0
mov al,[b]
cbw
cwd;EAX=b                                   
sub EDX,EAX;EDX=2*a-b                        
mov ECX,EDX;ECX=2*a-b                        
mov EDX,0
imul EAX,[b];EAX=b*b                       
xchg EAX,ECX;EAX=(2*a-b)                 EAX;ECX
mov EDX,0
idiv ECX; EAX=(2*a-b)/(b*b)
add EBX,EAX;EBX=-b+8+(2*a-b)/(b*b)
mov EAX,[e]
cwd
add EBX,EAX; EBX=-b+8+(2*a-b)/(b*b)+e
mov EAX,[x]
mov EDX,[x+4];EDX:EAX=x
mov ECX,EAX;EDX:ECX=..
mov EAX,EBX;EAX=-b+8+(2*a-b)/(b*b)+e
mov EBX,ECX
mov ECX,EDX;ECX:EBX=x
cdq;EDX:EAX=-b+8+(2*a-b)/(b*b)+e
add EAX,EBX
adc EDX,ECX;EDX:EAX=x-b+8+(2*a-b)/(b*b)+e




push    dword 0      
call    [exit]  





































