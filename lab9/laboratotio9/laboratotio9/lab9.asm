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
	monto_1   db "%d", 0

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

;se pide el monto facturado

ingresar:

;se calcula el iva

calcular_iva:

	sub eax, eax
	sub ebx, ebx
	mov eax, monto
	add monto_total, eax
	mov ebx, 5
	mul ebx
	mov ebx, 100d
	div ebx
	mov iva_calculado, eax

;se imprimen los datos

imprimir_datos:

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
END main
