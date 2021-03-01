%ifndef calcul.asm ; continuăm dacă _FACTORIAL_ASM_ este nedefinit
%define calcul.asm; și ne asigurăm că devine definit
                        ; astfel, %include permite doar o singură includere

calcule:
    mov ebx,0
    mov ebx,[esp+4]
    add ebx,[esp+8]
    sub ebx,[esp+12]

    ; now ebx will contain  a+b-c
    
    ret 12
    
    
%endif