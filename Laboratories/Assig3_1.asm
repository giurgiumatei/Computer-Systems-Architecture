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

;(c-a-d)+(c-b)-a = 276

mov EBX,[c]
mov AL,[a]
cbw
cwd
sub EBX,EAX
mov EAX,EBX;EAX=c-a in dword
cdq;EDX:EAX=c-a in quadword
mov ECX,EDX;ECX:EAX=c-a
mov EDX,0
mov EBX,[d];EDX:EBX=d
sub EAX,EBX
sbb ECX,EDX;ECX:EAX=c-a-d
mov EBX,EAX;ECX:EBX=c-a-d
mov AX,[b]
cwd;EAX=b
mov EDX,[c];EDX=c
sub EDX,EAX;EDX=c-b
mov EAX,EDX
mov EDX,0
cdq;EDX:EAX=c-b
add EBX,EAX
adc ECX,EDX;ECX:EBX=(c-a-d)+(c-b)
mov EDX,0
mov AL,[a]
cbw
cwd
cdq
sub EBX,EAX
sbb ECX,EDX;ECX:EBX=(c-a-d)+(c-b)-a













push    dword 0      
call    [exit]       
