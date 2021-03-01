bits 32 

global start        


extern exit               
import exit msvcrt.dll    
    


segment data use32 class=data
a db 01110111b
b db 10011011b
c dd 0
 

 
segment code use32 class=code

start:   
mov EBX,0; we compute the result in EBX
mov EBX,1111111111111111000001100000000b;bits 16-31 of C have 1
mov al,[b]
cbw
cwd;EAX=b
and EAX,0000000000000000000000000001111b
mov cl,3
ror EAX,cl
or EBX,EAX
mov EAX,0
mov al,[a]
cbw
cwd;EAX=a
and EAX,0000000000000000000000000011111b
mov cl,11
rol EAX,cl
or EBX,EAX
and EBX,1111111111111111111111100001111b



push    dword 0      
call    [exit]  