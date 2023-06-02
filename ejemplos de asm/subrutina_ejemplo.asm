; -----------------------------------------------
; UNIVERSIDAD DEL VALLE DE GUATEMALA 
; Organizaci�n de computadoras y Assembler
; Ciclo 1 - 2023
;
; ----------------------------------------------- 

.386
.model flat, stdcall, c
.stack 4096
;ExitProcess proto,dwExitCode:dword

.data
    
    char BYTE ?
	msg_in BYTE 'Ingrese un caracter: ',0
    msg_out BYTE 'El caracter ingresado es: %c', 0Ah, 0
    Xv DWORD 20
    Yv DWORD 10
    formaN db "%d",0Ah, 0
    fmt db "%c", 0
    arr DWORD 0, 0, 0, 0, 0, 0

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

    lea eax, char 			; Obtener direcci�n donde se guaradar� en char ingresado: memoria char
    push eax 				; Empujar direcci�n a la pila
    push offset fmt 		; Empujar formato a la pila
    call scanf 				; Leer caracter desde la entrada est�ndar

    movzx eax, char  		; IMPORTANTE: Extender el valor de char (originalmente 1 Bytr)
							; a una dword (2 Bytes) y almacenarlo en eax
    push eax         		; Empujar eax a la pila
    
	;push char ; Empujar char a la pila pero solo es un byte
    push offset msg_out 	; Empujar formato a la pila
    call printf 			; Imprimir resultado

    add esp, 8 				; Limpiar la pila

    mov eax, Xv
    mov ebx, Yv
    call subr1 ;llamado a subrutina
    push eax
    push offset formaN
    call printf
    add esp, 8

    call arrayPrint ;llamado a subrutina

    mov esp, ebp 			; hace (ESP) al valor actual de (EBP), la pila ahora est� en su 
							; estado original antes de la llamada a la funci�n
    pop ebp 				; extrae el valor de EBP de la pila y lo restaura en el registro 
							; EBP original, p/q cualquier otra funci�n que se llame despu�s de 
							; esta funci�n utilizar� su propio registro EBP.
    ret
main endp

subr1 proc   ;subrutina
    push ebp
    mov ebp, esp

    sub eax, ebx


    mov esp, ebp
	pop ebp
    ret
subr1 endp 

arrayPrint proc ;subrutina
    push ebp
    mov ebp, esp
    push esi
    
    mov esi, offset arr
    mov ebx, sizeof arr
label1:
	mov eax, [esi]		; DIRECCIONAM. INDIRECTO: Cargar el valor del i-esimo elem de array a eax 
	push eax			; Pasar valor a pila p/imprimir
	push offset formaN		; Pasar formato 
	call printf
    add esp, 8
	sub ebx, 4			; Decrementar "contador"
	add esi, 4			; Moverse al sig. elem. del array
	cmp ebx,0			; A�n hay elementos en el array?
	jne label1			; S�, entonces repetir proceso desde label1



    pop esi
    mov esp, ebp
	pop ebp
    ret
arrayPrint endp

end