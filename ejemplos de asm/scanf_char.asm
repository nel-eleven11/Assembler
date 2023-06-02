; -----------------------------------------------
; UNIVERSIDAD DEL VALLE DE GUATEMALA 
; Organización de computadoras y Assembler
; Ciclo 1 - 2023
;
; Nombre: scanf_char.asm
; Descripción: ingreso de un número decimal 16 bits 
;              por medio de la funcion c/c++ scanf
; Autor: Mod. por KB
;
; EAX:   dirección donde se guarda el dato recibido 
;	     desde el teclado.
; STACK: formato de dato a recibir
; SCANF: lee dato con formato "char" y lo guarda 
;		 en dir de stack: &char
; ----------------------------------------------- 

.386
.model flat, stdcall, c
.stack 4096
;ExitProcess proto,dwExitCode:dword

.data
    
    char BYTE ?
	msg_in BYTE 'Ingrese un caracter: ',0
    msg_out BYTE 'El caracter ingresado es: %c', 0Ah, 0

    fmt db "%c",0

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

    push offset msg_in 		; Imprimir mensaje p/ingreso de char
    call printf

    lea eax, char 			; Obtener dirección donde se guaradará en char ingresado: memoria char
    push eax 				; Empujar dirección a la pila
    push offset fmt 		; Empujar formato a la pila
    call scanf 				; Leer caracter desde la entrada estándar

    movzx eax, char  		; IMPORTANTE: Extender el valor de char (originalmente 1 Bytr)
							; a una dword (2 Bytes) y almacenarlo en eax
    push eax         		; Empujar eax a la pila
    
	;push char ; Empujar char a la pila pero solo es un byte
    push offset msg_out 	; Empujar formato a la pila
    call printf 			; Imprimir resultado

    add esp, 8 				; Limpiar la pila

    mov esp, ebp 			; hace (ESP) al valor actual de (EBP), la pila ahora está en su 
							; estado original antes de la llamada a la función
    pop ebp 				; extrae el valor de EBP de la pila y lo restaura en el registro 
							; EBP original, p/q cualquier otra función que se llame después de 
							; esta función utilizará su propio registro EBP.
    push 0
    call exit ;
main endp

end