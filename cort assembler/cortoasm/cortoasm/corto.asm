;Universidad del Valle de Guatemala
;Nelson Garc�a Bravatti 22434
;Gabriel Paz 221087
;Org de computadoras y Assembler
;Laboratorio 9
;Descripci�n: Realiza un cobro, da vuelto si el pago excede el cobro

.386
.model flat, stdcall, c
.stack 4096

.data

	fmt db "%d ", 0AH, 0
	msg_inicial db "Bienvenido al programa de cobros",0AH, 0
	msg_cobrar db "Ingrese el monto a cobrar",0AH, 0
	msg_valor db "Ingrese el billete con el cual pagara",0AH, 0
    monto1   db "%d", 0
    pago1   db "%d", 0
    msg_m db "El monto a cobrar es : %d", 0ah, 0
    msg_pago db "El pago hecho es de : %d", 0ah, 0
    msg_cambio db "Su cambio es de : %d", 0ah, 0

;variables generales

    monto dword 0
    pago dword 0 
    cambio dword 0

.code

    includelib libucrt.lib
    includelib legacy_stdio_definitions.lib
    includelib libcmt.lib
    includelib libvcruntime.lib

    extrn printf:near
    extrn scanf:near
    extrn exit:near

main PROC

    push offset msg_inicial  ;coloca la direcci�n del mensage en la pila, mensaje de bienvenida
    call printf				;se imprime el mensage
    add esp, 4				;limpiar pila

;se hace el cobro

    push offset msg_cobrar  ;coloca la direcci�n del mensage en la pila, mensage para cobrar
    call printf				;se imprime el mensage
    add esp, 4				;limpiar pila

    lea eax, [ebp-4]     ; Obtiene la direcci�n de la variable local
    push eax             ; Pone la direcci�n en la pila
    push offset monto1    ; Pone la direcci�n de la cadena de formato en la pila
    call scanf           ; Llama a la funci�n scanf para leer el n�mero ingresado
    add esp, 8           ; Limpia la pila

    mov eax, [ebp-4]     ; Mueve el n�mero ingresado a eax
    mov monto, eax       ;se guarda el monto
    push eax             ; Pone el n�mero en la pila
    push offset msg_m   ; Pone la direcci�n de la cadena de formato en la pila
    call printf          ; Llama a la funci�n printf para imprimir el cobro realizado
    add esp, 8           ; Limpia la pila

;se hace el pago

    push offset msg_valor  ;coloca la direcci�n del mensage en la pila, mensage para pagar
    call printf				;se imprime el mensage
    add esp, 4				;limpiar pila

    lea eax, [ebp-4]     ; Obtiene la direcci�n de la variable local
    push eax             ; Pone la direcci�n en la pila
    push offset pago1    ; Pone la direcci�n de la cadena de formato en la pila
    call scanf           ; Llama a la funci�n scanf para leer el n�mero ingresado, se toma el dinero
    add esp, 8           ; Limpia la pila

    mov eax, [ebp-4]     ; Mueve el n�mero ingresado a eax
    mov pago, eax          ; se guarda el pago
    push eax             ; Pone el n�mero en la pila
    push offset msg_pago ; Pone la direcci�n de la cadena de formato en la pila
    call printf          ; Llama a la funci�n printf para imprimir el dinero que se dio
    add esp, 8           ; Limpia la pila

;se calcula el vuelto

    call cal_vuelto


main ENDP


cal_vuelto PROC

    sub eax, eax
    sub ebx, ebx
    mov ebx, monto
    mov eax, pago
    sub eax, ebx
    mov cambio, eax
    mov eax, cambio

    push eax
    push offset msg_cambio  ;coloca la direcci�n del mensage en la pila, mensage para pagar
    call printf				;se imprime el mensage
    add esp, 8				;limpiar pila


cal_vuelto ENDP

END