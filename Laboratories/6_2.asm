;Se da un sir de dublucuvinte. Sa se ordoneze crescator sirul cuvintelor superioare ale acestor dublucuvinte. Cuvintele inferioare raman neschimbate.
bits 32

global start        

extern exit
import exit msvcrt.dll


segment data use32 class=data
    s dd 12AB5678h, 1256ABCDh, 12344344h
    len equ ($-s)/4

segment code use32 class=code
    start:
        MOV ECX, len; ecx=lenght of s
        MOV ESI, s; esi=s
        CLD;DF=0
        JECXZ finish; jumps to finish if ecx=0
        loop_1:
            PUSH dword ECX;push ecx into the stack
            DEC ECX
            JECXZ end_loop; jumps to end_loop if ecx=0
            LODSW;AX=word from esi,esi=esi+2
            LODSW;AX= word from esi, esi=esi+2
            MOV EDX, ESI;edx=esi
            MOV BX, AX;bx=ax
            loop_2:;this loop sorts the words
                LODSW;AX=word from esi,esi=esi+2
                LODSW;AX=word from esi,esi=esi+2
                CMP BX, AX
                JNA skip;if BX<=AX skip
                MOV [ESI - 2], BX;move the word from bx to the offset from esi-2
                MOV [EDX - 2], AX;move the word from Ax to the offset from edx-2
                MOV BX, AX
                skip:
            LOOP loop_2
            end_loop:
            MOV ESI, EDX;esi=edx
            POP ECX;pop the value from the stack into ecx
        LOOP loop_1
        finish:
        PUSH dword 0
        CALL [exit]
        
       
