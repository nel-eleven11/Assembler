; -----------------------------------------------
; UNIVERSIDAD DEL VALLE DE GUATEMALA 
; Organización de computadoras y Assembler
; Ciclo 1 - 2023
;
; Nombre: scanf_decimal.asm
; Descripción: ingreso de un número decimal 16 bits 
;              por medio de la funcion c/c++ scanf
; Autor: Mod. por KB
;
; EAX:   dirección donde se guarda el dato recibido 
;	     desde el teclado.
; STACK: formato de dato a recibir
; SCANF: lee dato con formato "dato1" y lo guarda 
;		 en dir de stack:[ebp-4]
; ----------------------------------------------- 
.386
.model flat, stdcall, c
.stack 4096

includelib libucrt.lib
includelib legacy_stdio_definitions.lib
includelib libcmt.lib
includelib libvcruntime.lib

extrn printf:near
extrn scanf:near
extrn exit:near

.data

dato1   db "%d", 0
msg_in  db "Ingrese un numero entero: ", 0
msg_out db "El numero ingresado es: %d", 0ah, 0

.code

public main
main proc
    push offset msg_in   ; Coloca la direc. de la cadena de caracteres en la pila
    call printf          ; Imprimir mensaje para ingreso de dato
    add esp, 4           ; Limpia la pila
    lea eax, [ebp-4]     ; Obtiene la dirección de la variable local

    push eax             ; Pone la dirección en la pila
    push offset dato1    ; Pone la dirección de la cadena de formato en la pila
    call scanf           ; Llama a la función scanf para leer el número ingresado
   
    add esp, 8           ; Limpia la pila
    mov eax, [ebp-4]     ; Mueve el número ingresado a eax
    push eax             ; Pone el número en la pila
    push offset msg_out  ; Pone la dirección de la cadena de formato en la pila
    call printf          ; Llama a la función printf para imprimir el número ingresado
   
    add esp, 8           ; Limpia la pila
    
    push 0
    call exit ;
main endp
end

