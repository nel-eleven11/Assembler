;Universidad del Valle de Guatemala
;Nelson García Bravatti 22434
;Gabriel Paz 221087
;Oscar Fuentes
;Andy Fuentes 
;Org de computadoras y Assembler
;Proyecto 4
;Descripción: Juego fuga de letras

.386
.model flat, stdcall, c
.stack 4096

.data

;mensages y fmt
    msg_inicial db "Bienvenido al juego: Fuga de letras",0AH,0
    msg_punto db "El jugador obtuvo un punto",0AH,0
    msg_nopunto db "El jugador perdio un punto",0AH,0
    msg_puntos1 db "Puntos del jugador 1: %d",0AH,0
    msg_puntos2 db "Puntos del jugador 2: %d",0AH,0
    msg_intr db "Ingrese una letra para completar la palabra",0AH,0
    msg_pal BYTE "La palabra es: %s",0AH,0
    msg_m db "La letra ingresada es: %c",0AH,0
    fmt_char db "%c",0
    fmt_string db "%s",0
    msg_turno1 db "Turno del jugador 1",0AH,0
    msg_turno2 db "Turno del jugador 2",0AH,0
    msg_ganador1 BYTE "Gana el jugador 1", 0AH, 0
	msg_ganador2 BYTE "Gana el jugador 2", 0AH, 0
    msg_esperada BYTE "Letra esperada: %s",0AH,0

;varibles generales
    puntaje1 dword 0
    puntaje2 dword 0
    puntomas dword 5
    puntomenos dword 2
    char BYTE ?
    letra_i BYTE ?
    letra dword 0
    numero_random dword 0
    letra_l BYTE ?
    turno1 dword 0
    turno2 dword 0
    

;arrays

    ;arr_palabras BYTE "manzana", "perro", "gato", "sol", "luna", "casa", "arbol", "coche", "libro", "amigo", "playa", "ciudad", "alegría", "amor", "risa", "felicidad", "caminar", "correr", "saltar", "dormir", "comer", "beber", "jugar", "aprender", "cantar", "bailar", "viajar", "familia", "trabajo", "estudiar", "computadora", "teléfono", "televisión", "música", "deporte", "montaña", "mar", "vida", "tiempo", "espacio"
    ;arr_incompleta BYTE "man_ana",0, "per_o", "ga_o", "so_", "lu_a", "ca_a", "_rbol", "coc_e", "lib_o", "ami_o", "pla_a", "ciuda_", "alegrí_", "am_r", "ri_a", "felicida_", "cam_nar", "cor_er", "s ltar", "dormi_", "co_er", "be_er", "ju_ar", "aprende_", "can_ar", "baila_", " iajar", "f_milia", "traba_o", "es_udiar", "computa_ora", "telé_ono", "televi_ión", "músi_", "depor_e", "monta_a", "ma_", "vi_a", "tiem_o", "es_acio"
	;arr_letras BYTE "z",0, "r", "t", "l", "n", "s", "a", "h", "r", "g", "y", "d", "a", "o", "s", "d", "i", "r", "s", "r", "m", "b", "g", "r", "t", "r", "v", "a", "j", "t", "d", "f", "s", "c", "t", "ñ", "r", "d", "p", "p"

    arr_palabras BYTE "manzana",0, "perro",0, "gato",0, "sol",0, "luna",0, "casa",0, "arbol",0, "coche",0, "libro",0, "amigo",0
    arr_incompleta BYTE "man_ana",0, "per_o",0, "ga_o",0, "so_",0, "lu_a",0, "ca_a",0, "_rbol",0, "coc_e",0, "lib_o",0, "ami_o",0
    arr_letras BYTE "z",0, "r",0, "t",0, "l",0, "n",0, "s",0, "a",0, "h",0, "r",0, "g",0

.code

    includelib libucrt.lib
    includelib legacy_stdio_definitions.lib
    includelib libcmt.lib
    includelib libvcruntime.lib

    extrn printf:near
    extrn scanf:near
    extrn exit:near

main PROC

    push ebp
    mov ebp, esp
    jmp lb_turnos

lb_turnos:

    push puntaje1             
    push offset msg_puntos1   ; Pone la dirección de la cadena de formato en la pila
    call printf          ; Llama a la función printf para imprimir la letra ingresada
    add esp, 8 

    push puntaje2             
    push offset msg_puntos2   ; Pone la dirección de la cadena de formato en la pila
    call printf          ; Llama a la función printf para imprimir la letra ingresada
    add esp, 8 
    
    mov ecx, turno1
    mov edx, turno2
    
    .IF ecx > edx
        add turno2, 1
    .ELSE
        add turno1, 1
    .ENDIF

    mov ecx, turno1
    mov edx, turno2

    .IF ecx > 5
        jmp lb_verificar
    .ELSE 
        jmp lb_ingresarletra
    .ENDIF

lb_ingresarletra:
 
    push offset msg_intr
    call printf
    add esp, 4
    
    lea eax,[arr_incompleta]    ; se carga la dirección de la palabra
    push eax                        ; Pone la dirección en la pila
    push offset msg_pal
    call printf
    add esp, 8

    lea eax, letra_i     ; Obtiene la dirección de la variable local
    push eax             ; Pone la dirección en la pila
    push offset fmt_string    ; Pone la dirección de la cadena de formato en la pila
    call scanf           ; Llama a la función scanf para leer el número ingresado
    add esp, 8           ; Limpia la pila

    movzx eax, letra_i  		; IMPORTANTE: Extender el valor de char (originalmente 1 Bytr)
							; a una dword (2 Bytes) y almacenarlo en eax
    mov letra, eax
    
    push letra             ; Pone la letra en la pila
    push offset msg_m   ; Pone la dirección de la cadena de formato en la pila
    call printf          ; Llama a la función printf para imprimir la letra ingresada
    add esp, 8           ; Limpia la pila

    ;jmp fin
    jmp label_verificarletra  ;se verifica la letra 
    
label_verificarletra:
    
    lea ecx, [arr_letras]
    push ecx
    push offset msg_esperada
    call printf
    add esp, 8
    movzx eax, [arr_letras]
    movzx ebx, letra_i

    .IF ebx == eax
        mov eax, turno1
        mov ebx, turno2
        .IF eax > ebx
            add puntaje1, 5
        .ELSE
            add puntaje2, 5
        .ENDIF
        
        push offset msg_punto
        call printf
        add esp, 4

    .ELSE
        mov eax, turno1
        mov ebx, turno2
        .IF eax > ebx
            sub puntaje1, 2
            mov ecx, puntaje1
            mov edx, 0d
            .IF ecx < edx
                add puntaje1, 2
            .ENDIF
        .ELSE
            sub puntaje2, 2
            mov ecx, puntaje2
            mov edx, 0d
            .IF ecx < edx
                add puntaje2, 2
            .ENDIF
        .ENDIF

        push offset msg_nopunto
        call printf
        add esp, 4
    .ENDIF 

    ;jmp fin
    jmp lb_turnos

lb_verificar:

    mov eax, puntaje1
    mov ebx, puntaje2
    .IF eax > ebx
        ;gana el jugador 1
        push offset msg_ganador1
        call printf
        add esp, 4
        jmp fin

    .ELSE
        ;gana el jugador 2
        push offset msg_ganador2
        call printf
        add esp, 4
        jmp fin
    .ENDIF


fin:
	push 0
	call exit

main ENDP

END