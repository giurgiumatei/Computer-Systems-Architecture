%ifndef modul1.asm ; continuăm dacă _FACTORIAL_ASM_ este nedefinit
%define modul1.asm; și ne asigurăm că devine definit
                        ; astfel, %include permite doar o singură includere

dublare:
    mov ebx,0
    mov ebx,[esp+4]
    add ebx,[esp+4]
    
    ; ebx will contain 2*[esp]
    
    ret 4
    
    
%endif