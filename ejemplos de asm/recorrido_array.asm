; -----------------------------------------------
; UNIVERSIDAD DEL VALLE DE GUATEMALA 
; Organización de computadoras y Assembler
; Ciclo 1 - 2023
;
; Nombre: recorrido_array.asm
; Descripción: demostración de recorrido de array 
;		       para impresión de sus elementos, &
;      		   direccionamiento indirecto
;
; Autor:    KB, 2023
; ----------------------------------------------- */

.386
.model flat, stdcall, c
.stack 4096

ExitProcess proto,dwExitCode:dword

.data
	arr DWORD 5,4,3,2,1
	fmt db "%d ", 0AH, 0
	msg1 db "El array contiene los siguientes elementos:",0AH, 0
	msg2 db "Fin del array",0AH, 0

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
	push offset msg1	; Guarda en pila el valor de dirección inicial de msg1
	call printf			; Llamado a printf

	mov esi, offset arr
	mov ebx, sizeof	arr

label1:
	mov eax, [esi]		; DIRECCIONAM. INDIRECTO: Cargar el valor del i-esimo elem de array a eax 
	push eax			; Pasar valor a pila p/imprimir
	push offset fmt		; Pasar formato 
	call printf

	sub ebx, 4			; Decrementar "contador"
	add esi, 4			; Moverse al sig. elem. del array
	cmp ebx,0			; Aún hay elementos en el array?
	jne label1			; Sí, entonces repetir proceso desde label1

	push offset msg2	; Guarda en pila el valor de dirección inicial de msg2
	call printf			; Llamado a printf

	push 0
    call exit           ; salir del programa

main endp
end