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

;(a+c)-b+a +(d-c)=20

mov AL,[a]
cbw
cwd;EAX=a
mov EBX,[c]
add EBX,EAX;EBX=a+c in dword
mov EAX,[b]
cwd
sub EBX,EAX;EBX=(a+c)-b
mov EAX,[a]
cbw
cwd
add EBX,EAX;EBX=(a+c)-b+a in dword
mov EAX,EBX
cdq;EDX:EAX=(a+c)-b+a in qword
mov EBX,[d]
mov ECX,[d+4];ECX:EBX=d
sub EAX,EBX
sbb EDX,ECX;EDX:EAX=(a+c)-b+a +d
mov EBX,EAX;EDX:EBX=(a+c)-b+a +d
mov ECX,EDX;ECX:EBX=(a+c)-b+a +d
mov EAX,[c];EDX:EAX=c
sub EBX,EAX
sbb ECX,EDX;ECX:EBX=(a+c)-b+a +(d-c)



push    dword 0      
call    [exit]    