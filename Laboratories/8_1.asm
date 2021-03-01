;Two natural numbers a and b (a, b: dword, defined in the data segment) are given. Calculate a/b and display the quotient and the remainder in the following format: "Quotient = <quotient>, remainder = ;<remainder>".

bits 32
global start
extern exit, printf, scanf 
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
a dw 23
b dw 10
quotient dd 0
remainder dd 0
result_format db 'Quotient = %d, remainder = %d',0


segment code use32 class=code
start:

    mov ax,[a];ax has the value of a
    cwd;DX:AX=a
    idiv word [b];AX=a/b, DX=a%b 
    mov [quotient],ax
    mov [quotient+2],word 0
    mov [remainder],dx
    mov [remainder+2],word 0
    push dword [remainder];push the remainder into the stack
    push dword [quotient];push the quotient into the stack
    push dword result_format;push the result format into the stack
    call [printf];print the result
    add esp,4*3;clear stack






push dword 0
call [exit];end program