; -----------------------------------------------
; UNIVERSIDAD DEL VALLE DE GUATEMALA 
; Organización de computadoras y Assembler
; Ciclo 1 - 2023
;
; Nombre: scanf_strings.asm
; Descripción: ingreso de un número decimal 16 bits 
;              por medio de la funcion c/c++ scanf
; Autor: Mod. por KB
; SCANF: lee dato con formato "%s" de tipo str y lo guarda 
;		 en dir de stack: &fmt
; ----------------------------------------------- 
.386
.model flat, stdcall, c
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
    msg BYTE 'Ingrese una cadena de caracteres: ',0
    strBuff BYTE 255 DUP(?) ; Buffer para almacenar la cadena ingresada, máx 255 caracteres
    resultMsg BYTE 'La cadena ingresada es: %s', 0Ah, 0

    fmt db "%s",0

.code
    includelib libucrt.lib
    includelib legacy_stdio_definitions.lib
    includelib libcmt.lib
    includelib libvcruntime.lib

    extrn printf:near
    extrn scanf:near
    extrn exit:near

public main
main proc
    push ebp
    mov ebp, esp

    push offset msg 		; Imprimir mensaje
    call printf

    lea  eax, strBuff 		; Obtener dirección del buffer
    push eax 				; Empujar dirección a la pila
    push offset fmt 		; Empujar formato a la pila
    call scanf 				; Leer cadena desde la entrada estándar

    push offset strBuff 	; Empujar cadena a la pila
    push offset resultMsg 	; Empujar formato a la pila
    call printf 			; Imprimir resultado

    add esp, 8 				; Limpiar la pila

    mov esp, ebp
    pop ebp
    
	push 0
    call exit ;
main endp

end