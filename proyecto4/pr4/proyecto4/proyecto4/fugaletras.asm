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
    msg_ins1 db "Este juego consiste en completar las letras que faltan en la palabra que se muestra en la pantalla. Se tienen dos jugadores que van jugando por turnos y empiezan con un puntaje de 0.",0AH,0
    msg_ins2 db "Si el jugador acierta con las letras que forman la palabra, ganara 5 puntos.",0AH,0
    msg_ins3 db "Si no cierta, se le restaran 2 puntos. Gana el jugador que haya obtenido mas puntos.",0AH,0
    msg_menu db "1. JUGAR 2. INSTRUCCIONES 3. SALIR",0AH,0
    msg_op db "Ingrese una opcion del menu",0AH,0
    msg_res db "Opcion ingresada: %d",0AH,0
    msg_alert db "Ingrese un numero del 1 al 3 por favor.",0AH,0
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
    msg_empate BYTE "Hay un empate",0AH,0
    fmt_num db "%d",0
    espacio BYTE " ",0Ah, 0

;varibles generales
    puntaje1 dword 0
    puntaje2 dword 0
    char BYTE ?
    letra_i BYTE ?
    letra dword 0
    letra_l BYTE 2
    turno1 dword 0
    turno2 dword 0
    opcion dword 0
    contador1 dword 0
    contador2 dword 0
    sel_palabra dword 0
    sel_letra dword 0
    comparador dword 0
    turno_palabra dword 0

;arrays

    ;arr_palabras BYTE "manzana", "perro", "gato", "sol", "luna", "casa", "arbol", "coche", "libro", "amigo", "playa", "ciudad", "alegría", "amor", "risa", "felicidad", "caminar", "correr", "saltar", "dormir", "comer", "beber", "jugar", "aprender", "cantar", "bailar", "viajar", "familia", "trabajo", "estudiar", "computadora", "teléfono", "televisión", "música", "deporte", "montaña", "mar", "vida", "tiempo", "espacio"
    ;arr_incompleta BYTE "man_ana",0, "per_o", "ga_o", "so_", "lu_a", "ca_a", "_rbol", "coc_e", "lib_o", "ami_o", "pla_a", "ciuda_", "alegrí_", "am_r", "ri_a", "felicida_", "cam_nar", "cor_er", "s ltar", "dormi_", "co_er", "be_er", "ju_ar", "aprende_", "can_ar", "baila_", " iajar", "f_milia", "traba_o", "es_udiar", "computa_ora", "telé_ono", "televi_ión", "músi_", "depor_e", "monta_a", "ma_", "vi_a", "tiem_o", "es_acio"
	;arr_letras BYTE "z",0, "r", "t", "l", "n", "s", "a", "h", "r", "g", "y", "d", "a", "o", "s", "d", "i", "r", "s", "r", "m", "b", "g", "r", "t", "r", "v", "a", "j", "t", "d", "f", "s", "c", "t", "ñ", "r", "d", "p", "p"

    arr_palabras BYTE "manzana",0, "perro",0, "gato",0, "sol",0, "luna",0, "casa",0, "arbol",0, "coche",0, "libro",0, "amigo",0
    arr_incompleta BYTE "man_ana",0, "per_o",0, "ga_o",0, "so_",0, "lu_a",0, "ca_a",0, "_rbol",0, "coc_e",0, "lib_o",0, "ami_o",0
    arr_letras BYTE "z",0, "r",0, "t",0, "l",0, "n",0, "s",0, "a",0, "h",0, "r",0, "g",0
    arr_num BYTE 8

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

    push offset msg_inicial
    call printf 
    add esp, 4
    push offset espacio                    ; espacio
    call printf
    add esp, 4

    jmp lb_menu

    ;introducción del juego y menú

lb_menu: 

    push offset msg_op
    call printf 
    add esp, 4

    push offset msg_menu
    call printf 
    add esp, 4

    push offset espacio                    ; espacio
    call printf
    add esp, 4

    lea eax, [ebp-4]     ; Obtiene la dirección de la variable local
    push eax             ; Pone la dirección en la pila
    push offset fmt_num    ; Pone la dirección de la cadena de formato en la pila
    call scanf           ; Llama a la función scanf para leer el número ingresado
    add esp, 8           ; Limpia la pila
    

    
    mov eax, [ebp-4]     ; Mueve el número ingresado a eax
    mov opcion, eax       ;se guarda 
    push eax             ; Pone el número en la pila
    push offset msg_res   ; Pone la dirección de la cadena de formato en la pila
    call printf          ; Llama a la función printf para imprimir la opcion ingresada
    add esp, 8           ; Limpia la pila
    push offset espacio                    ; espacio
    call printf
    add esp, 4

    ;se reinician las varibles

    mov eax, puntaje1
    sub eax, eax
    mov puntaje1, eax

    mov eax, puntaje2
    sub eax, eax
    mov puntaje2, eax

    mov eax, turno1
    sub eax, eax
    mov turno1, eax

    mov eax, turno2
    sub eax, eax
    mov turno2, eax

    mov eax, turno_palabra
    sub eax, eax
    mov turno_palabra, eax

    mov eax, contador1
    sub eax, eax
    mov contador1, eax

    mov eax, contador2
    sub eax, eax
    mov contador2, eax
    
    mov ecx, opcion

    .IF ecx == 1
    ;jugar seleccionado
        jmp lb_turnos
    .ELSEIF ecx == 2
    ;instrucciones
        push offset msg_ins1
        call printf 
        add esp, 4
        push offset msg_ins2
        call printf 
        add esp, 4
        push offset msg_ins3
        call printf 
        add esp, 4
        push offset espacio                    ; espacio
        call printf
        add esp, 4
        jmp lb_menu
    .ELSEIF ecx == 3
    ;salir
        jmp fin
    .ELSE
    ;otro numero diferente
        push offset msg_alert
        call printf 
        add esp, 4
        push offset espacio                    ; espacio
        call printf
        add esp, 4
        jmp lb_menu
    .ENDIF
    

lb_turnos:

    ;verificar si algún puntaje es menor a 0

    mov eax, puntaje1
    mov ebx, puntaje2

    .IF eax < comparador
        mov eax, comparador
    .ENDIF

    .IF ebx < comparador
        mov ebx, comparador
    .ENDIF

    mov puntaje1, eax
    mov puntaje2, ebx

    push puntaje1            
    push offset msg_puntos1   ; Pone la dirección de la cadena de formato en la pila
    call printf          ; Llama a la función printf para imprimir la letra ingresada
    add esp, 8
    push offset espacio                    ; espacio
    call printf
    add esp, 4

    push puntaje2             
    push offset msg_puntos2   ; Pone la dirección de la cadena de formato en la pila
    call printf          ; Llama a la función printf para imprimir la letra ingresada
    add esp, 8 
    push offset espacio                    ; espacio
    call printf
    add esp, 4
    
    mov ecx, turno1
    mov edx, turno2
    
    .IF ecx > edx
        add turno2, 1
        push offset msg_turno2
        call printf 
        push offset espacio                    ; espacio
        call printf
        add esp, 4
        add esp, 4
    .ELSE
        add turno1, 1
        push offset msg_turno1
        call printf 
        push offset espacio                    ; espacio
        call printf
        add esp, 4
        add esp, 4
    .ENDIF

    mov ecx, turno1
    mov edx, turno2

    .IF ecx == 1
        mov eax, turno_palabra
        mov eax, 0d
        mov turno_palabra, eax
    .ELSE
        mov eax, turno_palabra
        add eax, 1d
        mov turno_palabra, eax
    .ENDIF  

    .IF ecx > 5
        jmp lb_verificar
    .ELSE 
        jmp lb_contarletra
    .ENDIF

lb_contarletra:

    mov ebx, contador1
    mov ecx, sel_letra
    mov eax, turno_palabra
    .IF ebx == eax
        mov sel_letra, ecx
        jmp lb_ingresarletra
    .ELSE
        add ecx, 2d
        inc ebx
        mov contador1, ebx
        mov sel_letra, ecx
        jmp lb_contarletra
    .ENDIF


lb_contarpalabra:

    mov ebx, contador2
    movzx eax, [arr_incompleta]
    
    .IF ebx == turno_palabra
        jmp lb_ingresarletra
    .ENDIF

    .If eax == 0
        add ebx, 1d
    .ELSE
        jmp lb_contarpalabra
    .ENDIF
    mov contador2, ebx
    mov sel_palabra, ebx
    

lb_ingresarletra:
 
    push offset msg_intr
    call printf
    add esp, 4
    push offset espacio                    ; espacio
    call printf
    add esp, 4

    mov ebx, sel_palabra
    lea eax,[arr_incompleta]    ; se carga la dirección de la palabra
    push eax                        ; Pone la dirección en la pila
    push offset msg_pal
    call printf
    add esp, 8
    push offset espacio                    ; espacio
    call printf
    add esp, 4

    lea eax, letra_i     ; Obtiene la dirección de la variable local
    push eax             ; Pone la dirección en la pila
    push offset fmt_string    ; Pone la dirección de la cadena de formato en la pila
    call scanf           ; Llama a la función scanf para leer la letra ingresado
    add esp, 8           ; Limpia la pila

    movzx eax, letra_i  		; IMPORTANTE: Extender el valor de char (originalmente 1 Bytr)
							; a una dword (2 Bytes) y almacenarlo en eax
    mov letra, eax

    push offset espacio                    ; espacio
    call printf
    add esp, 4

    push letra             ; Pone la letra en la pila
    push offset msg_m   ; Pone la dirección de la cadena de formato en la pila
    call printf          ; Llama a la función printf para imprimir la letra ingresada
    add esp, 8           ; Limpia la pila
    push offset espacio                    ; espacio
    call printf
    add esp, 4

    ;jmp fin
    jmp label_verificarletra  ;se verifica la letra 
    
label_verificarletra:

    mov ebx, sel_letra    
    
    lea ecx, [arr_letras + ebx]
    push ecx
    push offset msg_esperada
    call printf
    push offset espacio                    ; espacio
    call printf
    add esp, 4
    add esp, 8
    sub ebx, ebx
    movzx eax, [arr_letras + ebx]
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
        push offset espacio                    ; espacio
        call printf
        add esp, 4
        add esp, 4

    .ELSE
        mov eax, turno1
        mov ebx, turno2
        mov edx, puntaje1
        mov ecx, puntaje2
        .IF eax > ebx
            sub edx, 2
        .ELSE
            sub ecx, 2
        .ENDIF

        mov puntaje1, edx
        mov puntaje2, ecx

        push offset msg_nopunto
        push offset espacio                    ; espacio
        call printf
        add esp, 4
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
        jmp lb_menu
        push offset espacio                    ; espacio
        call printf
        add esp, 4

    .ELSEIF ebx > eax
        ;gana el jugador 2
        push offset msg_ganador2
        call printf
        add esp, 4
        push offset espacio                    ; espacio
        call printf
        add esp, 4
        jmp lb_menu
    .ELSE
        ;empate
        push offset msg_empate
        call printf
        add esp, 4
        push offset espacio                    ; espacio
        call printf
        add esp, 4
        jmp lb_menu
    .ENDIF


fin:
	push 0
	call exit

main ENDP

END