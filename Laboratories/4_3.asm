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
mov EBX,0
mov al,[a]
cbw
cwd
not EAX
and EAX,00000001111100000000000000000000
mov cl,20
ror EAX,cl
or EBX,EAX
or EBX,00000000000000000000001111000000
mov EAX,0
mov al,[b]
cbw
cwd
and EAX,00000000000000011110000000000000
mov cl,3
ror EAX,cl
or EBX,EAX
mov al,[a]
cbw
cwd
and EAX,00000001111100000000011100000000
mov cl,6
rol EAX,cl
or EBX,EAX





push    dword 0      
call    [exit]  