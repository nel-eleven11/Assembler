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

;varibles generales
    puntaje1 dword 0
    puntaje2 dword 0
    puntomas dword 5
    puntomenos dword 2
    char BYTE ?
    letra_i BYTE ?
    letra dword 0
    numero_random dword 0
    letra_l BYTE "a"
    turno1 dword 0
    turno2 dword 0
    

;arrays

    arr_palabras BYTE "manzana", "perro", "gato", "sol", "luna", "casa", "arbol", "coche", "libro", "amigo", "playa", "ciudad", "alegría", "amor", "risa", "felicidad", "caminar", "correr", "saltar", "dormir", "comer", "beber", "jugar", "aprender", "cantar", "bailar", "viajar", "familia", "trabajo", "estudiar", "computadora", "teléfono", "televisión", "música", "deporte", "montaña", "mar", "vida", "tiempo", "espacio"
    arr_incompleta BYTE "man_ana", "per_o", "ga_o", "so_", "lu_a", "ca_a", "_rbol", "coc_e", "lib_o", "ami_o", "pla_a", "ciuda_", "alegrí_", "am_r", "ri_a", "felicida_", "cam_nar", "cor_er", "s ltar", "dormi_", "co_er", "be_er", "ju_ar", "aprende_", "can_ar", "baila_", " iajar", "f_milia", "traba_o", "es_udiar", "computa_ora", "telé_ono", "televi_ión", "músi_", "depor_e", "monta_a", "ma_", "vi_a", "tiem_o", "es_acio"
	arr_letras BYTE "z", "r", "t", "l", "n", "s", "a", "h", "r", "g", "y", "d", "a", "o", "s", "d", "i", "r", "s", "r", "m", "b", "g", "r", "t", "r", "v", "a", "j", "t", "d", "f", "s", "c", "t", "ñ", "r", "d", "p", "p"


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

lb_turnos:
    
    mov ecx, turno1
    mov edx, turno2
    
    .IF ecx > edx
        add turno2, 1
    .ELSE
        add turno1, 1
    .ENDIF

    mov ecx, turno1
    mov edx, turno2

    .IF edx == 10
        jmp lb_verificar
    .ELSE 
        jmp lb_ingresarletra
    .ENDIF

lb_ingresarletra:
 
    push offset msg_intr
    call printf
    add esp, 4
    
    lea eax, [arr_incompleta] ; se carga la dirección de la palabra
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

    jmp fin
   ;jmp label_verificarletra  ;se verifica la letra 
    
label_verificarletra:

    mov numero_random, 1d
    sub ebx, ebx
    sub eax, eax
    mov eax, numero_random
    mov ebx, 4
    mul ebx
    mov numero_random, eax
    lea ecx, [arr_letras]
    ;mov 
    .IF ecx == letra
        ;add puntaje1, 5
        push offset msg_punto
        call printf
        add esp, 4

    .ELSE
        ;sub puntaje1, 2
        push offset msg_nopunto
        call printf
        add esp, 4
    .ENDIF 
        

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