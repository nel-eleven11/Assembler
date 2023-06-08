;Universidad del Valle de Guatemala
;Nelson Garc�a Bravatti 22434
;Org de computadoras y Assembler
;lab de reposicion
;Descripci�n: maquina dispensadora de dulces


.386
.model flat, stdcall, c
.stack 4096

.data


    ;mensajes
    msg_inicial db "Bienvenido a la maquina de dulces",0AH,0
    msg_menu db "1. COMPRAR DULCE 2. VER INVENTARIO 3. SALIR",0AH,0
    msg_op db "Ingrese una opcion del menu",0AH,0
    msg_res db "Opcion ingresada: %d",0AH,0
    msg_alert db "Ingrese un numero del 1 al 3 por favor.",0AH,0
    fmt_num db "%d",0
    espacio BYTE " ",0Ah, 0


    ;variables generales
    opcion dword 0


    ;arreglos
    arr_dulces dword 4,12,1



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

    push offset msg_inicial         ;mensaje inicial 
    call printf 
    add esp, 4
    push offset espacio                    ; espacio
    call printf
    add esp, 4

    jmp lb_menu

lb_menu: 

    push offset msg_menu ;se muestran las opciones del men�
    call printf 
    add esp, 4

    push offset espacio                    ; espacio
    call printf
    add esp, 4

    push offset msg_op                    ; se pide que ingrese una opcion del menu
    call printf
    add esp, 4

    push offset espacio                    ; espacio
    call printf
    add esp, 4


    ;el usuario elige una opci�n del men�

    lea eax, [ebp-4]     ; Obtiene la direcci�n de la variable local
    push eax             ; Pone la direcci�n en la pila
    push offset fmt_num  ; Pone la direcci�n de la cadena de formato en la pila
    call scanf           ; Llama a la funci�n scanf para leer el n�mero ingresado
    add esp, 8           ; Limpia la pila
    
    mov eax, [ebp-4]     ; Mueve el n�mero ingresado a eax
    mov opcion, eax      ;se guarda 
    push eax             ; Pone el n�mero en la pila
    push offset msg_res   ; Pone la direcci�n de la cadena de formato en la pila
    call printf          ; Llama a la funci�n printf para imprimir la opcion ingresada
    add esp, 8           ; Limpia la pila

    push offset espacio                    ; espacio
    call printf
    add esp, 4

     mov ecx, opcion

    .IF ecx == 1

    .ELSEIF ecx == 2

    .ELSEIF ecx == 3
    ;salir
        jmp fin 

    .ELSE
    ;otro numero diferente
        push offset msg_alert           ;si se ingresa un n�mero no v�lido, imprime una alerta
        call printf 
        add esp, 4
        push offset espacio                    ; espacio
        call printf
        add esp, 4
        jmp lb_menu                     ;se regresa al men�
    .ENDIF

fin:
	push 0                      ;se finaliza el programa
	call exit

main ENDP

END