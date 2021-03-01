bits 32 

global start        


extern exit               
import exit msvcrt.dll    
  
  
  
  
  
segment data use32 class=data
a dd 11223344h

 
segment code use32 class=code

start:   
mov al,[a]
mov bl,[a+1]
mov cl,[a+2]
mov dl,[a+3]


push    dword 0      
call    [exit]  