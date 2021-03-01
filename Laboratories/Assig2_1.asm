bits 32
global start
extern exit
import exit msvcrt.dll

segment data use32 class=data

a dd "256"
b db 255


segment code use32 class=code
start:
mov eax,b
mov [eax],dword a