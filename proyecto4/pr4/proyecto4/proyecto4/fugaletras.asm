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
    msg_puntos db "Puntos del jugador: %d",0AH,0
    msg_intr db "Ingrese una letra para completar la palabra",0AH,0
    msg_pal BYTE "La palabra es: %s",0AH,0
    msg_m db "La letra ingresada es: %c",0AH,0
    fmt_letra db "%c",0
    fmt_string db "%s",0
    strBuff BYTE 255 DUP(?) ; Buffer para almacenar la cadena ingresada, máx 255 caracteres

;varibles generales
    puntaje1 dword 0
    puntaje2 dword 0
    puntomas dword 5
    puntomenos dword 2
    char BYTE ?
    letra dword 0
    numero_random dword 0
    letra_l BYTE "a"
    

;arrays

    arr_palabras BYTE "manzana", "perro", "gato", "sol", "luna", "casa", "arbol", "coche", "libro", "amigo", "playa", "ciudad", "alegría", "amor", "risa", "felicidad", "caminar", "correr", "saltar", "dormir", "comer", "beber", "jugar", "aprender", "cantar", "bailar", "viajar", "familia", "trabajo", "estudiar", "computadora", "teléfono", "televisión", "música", "deporte", "montaña", "mar", "vida", "tiempo", "espacio"
    arr_incompleta BYTE "man ana", "per o", "ga o", "so", "lu a", "ca a", " rbol", "coc e", "lib o", "ami o", "pla a", "ciuda ", "alegrí ", "am r", "ri a", "felicida ", "cam nar", "cor er", "s ltar", "dormi ", "co er", "be er", "ju ar", "aprende ", "can ar", "baila ", " iajar", "f milia", "traba o", "es udiar", "computa ora", "telé ono", "televi ión", "músi a", "depor e", "monta a", "ma ", "vi a", "tiem o", "es acio"
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

    jmp lb_ingresarletra

lb_ingresarletra:
 
    push offset msg_intr
    call printf
    add esp, 4

    mov esi, offset arr_incompleta
    mov eax, [esi]		; DIRECCIONAM. INDIRECTO: Cargar el valor del i-esimo elem de array a eax
    lea  ebx, strBuff 		; Obtener dirección del buffer
    push ebx 
    push eax			; Pasar valor a pila p/imprimir
    push offset strBuff
    push offset  msg_pal
    call printf
    add esp, 16

    lea eax, char     ; Obtiene la dirección de la variable local
    push eax             ; Pone la dirección en la pila
    push offset fmt_letra    ; Pone la dirección de la cadena de formato en la pila
    call scanf           ; Llama a la función scanf para leer el número ingresado
    add esp, 8           ; Limpia la pila

    movzx eax, char  		; IMPORTANTE: Extender el valor de char (originalmente 1 Bytr)
							; a una dword (2 Bytes) y almacenarlo en eax
    mov letra, eax
    
    push letra             ; Pone la letra en la pila
    push offset msg_m   ; Pone la dirección de la cadena de formato en la pila
    call printf          ; Llama a la función printf para imprimir la letra ingresada
    add esp, 8           ; Limpia la pila

    ;jmp label_verificarletra  ;se verifica la letra
    
label_verificarletra:

    mov esi, offset arr_letras
    mov numero_random, 1d
    sub ebx, ebx
    sub eax, eax
    mov eax, numero_random
    mov ebx, 4
    mul ebx
    mov numero_random, eax
    add esi, eax
    mov eax, [esi]		;DIRECCIONAM. INDIRECTO: Cargar el valor del i-esimo elem de array a eax
    movzx ebx, letra_l
    .IF  eax == letra
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
        




    push 0
    call exit ;
main ENDP

END