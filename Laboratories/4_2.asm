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
mov EBX,0;we compute the result in EBX
mov  al, [b] ; we isolate bits 5-8 of B
cbw
cwd
and  EAX, 00000000000000000000000111100000b
mov  cl, 5
ror  EAX, cl ; we rotate 5 positions to the right
or   EBX, EAX ; we put the bits into the result
or EBX,00000000000001111111100000000000b
mov EAX,0
mov al,[b]
cbw
cwd
and EAX,00000000000000111111111111111000b
mov cl,3
ror EAX,cl
or EBX,EAX
mov al,[b]
cbw
cwd
and EAX,00000000000000000000000001111111b




push    dword 0      
call    [exit]  