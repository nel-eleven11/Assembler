;Universidad del Valle de Guatemala
;Nelson García Bravatti 22434
;Gabriel Paz 221087
;Org de computadoras y Assembler
;Laboratorio 9
;Descripción: Evaluador de régimen apropiado en SAT y obligaciones fiscales

.386
.model flat, stdcall, c
.stack 4096

.data

	;variables generales

    monto_total dword 0
	iva_calculado dword 0
	monto dword 0

;arreglos

    arr_IVA dword 0,0,0,0,0,0,0,0,0,0,0,0
    arr_meses db "enero 2022","febrero 2022","marzo 2022","abril 2022","mayo 2022","junio 2022","julio 2022","agosto 2022","septiembre 2022","octubre 2022","noviembre 2022","diciembre 2022"
    arr_nit dword 9812456,7548123,6325891,1456237,8765432,9876543,3698521,5214789,2365418,6541238,7896541,1236987
    arr_montos dword 0,0,0,0,0,0,0,0,0,0,0,0

;mensajes

    fmt db "%d ", 0AH, 0
	msg_iva db "Debe actualizar su regime tributario a IVA General",0AH, 0
    msg_pc db "Puede continuar como pequeño contribuyente",0AH, 0
    msg_resumen db "%d , NIT: %d , Facturado: %d , IVA: %d ",0AH, 0
	msg_monto db "Ingrese el monto facturado",0AH, 0
	monto_1 db "%d", 0



.code

    includelib libucrt.lib
    includelib legacy_stdio_definitions.lib
    includelib libcmt.lib
    includelib libvcruntime.lib

    extrn printf:near
    extrn scanf:near
    extrn exit:near

main PROC

;se pide el monto facturado

	call ingresar ;se llama subrutina

;se calcula el iva
 
	call calcular_iva ;se llama subrutina



;se imprimen los datos

;imprimir_datos:

;se analiza el monto de facturacion anual

	mov ecx, 150000d
	cmp monto_total, ecx
	jg lp1
	jl lp2	

;es IVA general
lp1:
	push offset msg_iva
	call printf
	jmp fin
	
;sigue siendo pequeño contribuyente
lp2:
	push offset msg_pc
	call printf
	jmp fin

fin:
	push 0
	call exit



main ENDP


ingresar PROC

    mov esi, offset arr_montos
	mov ebx, sizeof	arr_montos

label1:

	push offset msg_monto  ;coloca la dirección del mensage en la pila
    call printf				;se imprime el mensage
    add esp, 4				;limpiar pila
	lea eax, [ebp-4]		; Obtiene la dirección de la variable local

	push eax             ; Pone la dirección en la pila
    push offset monto_1  ; Pone la dirección de la cadena de formato en la pila
    call scanf			;llamar la funcion scanf

	add esp, 8           ; Limpia la pila
    mov eax, [ebp-4]	; Mueve el número ingresado a eax

	mov [esi], eax      ; DIRECCIONAM. INDIRECTO: guarda el valor ingresado en el i-esimo elemento del array de montos

	sub ebx, 4			; Decrementar "contador"
	add esi, 4			; Moverse al sig. elem. del array
	cmp ebx,0			; Aún faltan ingresar elementos en el array?
	jne label1		; Sí, entonces repetir proceso desde label1

ingresar ENDP


calcular_iva PROC

	mov esi, offset arr_montos
	mov ebx, sizeof	arr_montos
	mov edi, offset arr_IVA

label2:

	sub eax, eax
	sub ecx, ecx
	
	mov eax, [esi]   ; DIRECCIONAM. INDIRECTO: Cargar el valor del i-esimo elem de array de montos a eax 

	add monto_total, eax    ;se agrega el monto al monto total
	mov ecx, 5				
	mul ecx					;se multiplica por 5
	mov ecx, 100d
	div ecx					;se divide el monto por 100

	mov [edi], eax  ; DIRECCIONAM. INDIRECTO: guarda el valor ingresado en el i-esimo elemento del array del iva


	sub ebx, 4			; Decrementar "contador"
	add esi, 4			; Moverse al sig. elem. del array de montos
	add edi, 4			; Moverse al sig. elem. del array de iva
	cmp ebx,0			; Aún hay elementos en el array?
	jne label2			; Sí, entonces repetir proceso desde label2

calcular_iva ENDP

END