;Universidad del Valle de Guatemala
;Nelson García Bravatti 22434
;Gabriel Paz 221087
;
;Laboratorio 8 ejercicio 1
;Descripción: calcular el ISR de las facturas de una empresa de junio 2022 a mayo 2023

.386
.model flat, stdcall, c
.stack 4096

.data

;variables que se van a utilizar

	msg1    db	"Mes : Junio 2022, Nombre: Jose Diaz, NIT: 384938-8, Monto Facturado: %d, ISR: %d", 0AH, 0           ;datos cliente 1
	msg2	db  "Mes : Julio 2022, Nombre: Carlos Valladares, NIT: 274822-8, Monto Facturado: %d, ISR: %d", 0AH, 0   ;datos cliente 2
	msg3	db	"Mes : Agosto 2022, Nombre: Carlos Sanchez, NIT: 384940-0, Monto Facturado: %d, ISR: %d", 0AH, 0     ;datos cliente 3
	msg4	db	"Mes : Septiembre 2022, Nombre: Ana Ramirez, NIT: 344841-4, Monto Facturado: %d, ISR: %d", 0AH, 0    ;datos cliente 4
	msg5	db	"Mes : Octubre 2022, Nombre: Juan Perez, NIT: 386742-2, Monto Facturado: %d, ISR: %d", 0AH, 0        ;datos cliente 5
	msg6	db	"Mes : Nomviembre 2022, Nombre: Sofia Torres, NIT: 734943-3, Monto Facturado: %d, ISR: %d", 0AH, 0   ;datos cliente 6
	msg7	db	"Mes : Diciembre 2022, Nombre: Pablo Gonzalez,NIT: 334544-4, Monto Facturado: %d, ISR: %d", 0AH, 0  ;datos cliente 7
	msg8	db	"Mes : Enero 2023, Nombre: Laura Hernandez, NIT: 384965-5, Monto Facturado: %d, ISR: %d", 0AH, 0     ;datos cliente 8
	msg9	db	"Mes : Febrero 2023, Nombre: Miguel Rodriguez, NIT: 784946-6, Monto Facturado: %d, ISR: %d", 0AH, 0  ;datos cliente 9
	msg10	db	"Mes : Marzo 2023, Nombre: Andrea Fernandez, NIT: 384947-7, Monto Facturado: %d, ISR: %d", 0AH, 0    ;datos cliente 10
	msg11	db	"Mes : Abril 2023, Nombre: David Garcia, NIT: 387998-8, Monto Facturado: %d, ISR: %d", 0AH, 0        ;datos cliente 11
	msg12	db	"Mes : Mayo 2023, Nombre: Julia Ruiz, NIT: 356949-9, Monto Facturado: %d, ISR: %d", 0AH, 0			 ;datos cliente 12
	msgmc	db	"Usted tiene que pasar a ser mediano contribuyente", 0AH, 0
	msgpc	db	"Usted continua siendo pequeño contribuyente", 0AH, 0
	format  db	"%d", 0

;isr

	isr1 dword 0
	isr2 dword 0
	isr3 dword 0
	isr4 dword 0
	isr5 dword 0
	isr6 dword 0
	isr7 dword 0
	isr8 dword 0
	isr9 dword 0
	isr10 dword 0
	isr11 dword 0
	isr12 dword 0

;montos

	monto1 dword 100d
	monto2 dword 1000d
	monto3 dword 3290d
	monto4 dword 15000d
	monto5 dword 500d
	monto6 dword 5049d
	monto7 dword 10000d
	monto8 dword 777d
	monto9 dword 2345d
	monto10 dword 4000d
	monto11 dword 900d
	monto12 dword 12000d

;otras variables

montototal dword 0

.code

    includelib libucrt.lib
    includelib legacy_stdio_definitions.lib
    includelib libcmt.lib
    includelib libvcruntime.lib

    extrn printf:near
    extrn scanf:near
    extrn exit:near

main PROC

    ;se calcula el isr1
    mov edx, 0
	sub eax, eax
	mov eax, monto1
	add montototal, eax
	mov ebx, 5
	mul ebx
	mov ebx, 100d
	div ebx
	mov isr1, eax

	push dword ptr [isr1]
	push dword ptr [monto1]
	push offset [msg1]
	call printf
	add esp, 12
	

;se calcula el isr2

	sub eax, eax
	mov eax, monto2
	add montototal, eax
	mov ebx, 5
	mul ebx
	mov ebx, 100d
	div ebx
	mov isr2, eax

	push dword ptr [isr2]
	push dword ptr [monto2]
	push offset msg2
	call printf
	add esp, 12

;se calcula el isr3

	sub eax, eax
	mov eax, monto3
	add montototal, eax
	mov ebx, 5
	mul ebx
	mov ebx, 100d
	div ebx
	mov isr3, eax

	push dword ptr [isr3]
	push dword ptr [monto3]
	push offset msg3
	call printf
	add esp, 12

;se calcula el isr4

	sub eax, eax
	mov eax, monto4
	add montototal, eax
	mov ebx, 5
	mul ebx
	mov ebx, 100d
	div ebx
	mov isr4, eax

	push dword ptr [isr4]
	push dword ptr [monto4]
	push offset msg4
	call printf
	add esp, 12

;se calcula el isr5

	sub eax, eax
	mov eax, monto5
	add montototal, eax
	mov ebx, 5
	mul ebx
	mov ebx, 100d
	div ebx
	mov isr5, eax

	push dword ptr [isr5]
	push dword ptr [monto5]
	push offset msg5
	call printf
	add esp, 12

;se calcula el isr6

	sub eax, eax
	mov eax, monto6
	add montototal, eax
	mov ebx, 5
	mul ebx
	mov ebx, 100d
	div ebx
	mov isr6, eax

	push dword ptr [isr6]
	push dword ptr [monto6]
	push offset msg6
	call printf
	add esp, 12

;se calcula el isr7

	sub eax, eax
	mov eax, monto7
	add montototal, eax
	mov ebx, 5
	mul ebx
	mov ebx, 100d
	div ebx
	mov isr7, eax

	push dword ptr [isr7]
	push dword ptr [monto7]
	push offset msg7
	call printf
	add esp, 12

;se calcula el isr8

	sub eax, eax
	mov eax, monto8
	add montototal, eax
	mov ebx, 5
	mul ebx
	mov ebx, 100d
	div ebx
	mov isr8, eax

	push dword ptr [isr8]
	push dword ptr [monto8]
	push offset msg8
	call printf
	add esp, 12

;se calcula el isr9

	sub eax, eax
	mov eax, monto9
	add montototal, eax
	mov ebx, 5
	mul ebx
	mov ebx, 100d
	div ebx
	mov isr9, eax

	push dword ptr [isr9]
	push dword ptr [monto9]
	push offset msg9
	call printf
	add esp, 12

;se calcula el isr10

	sub eax, eax
	mov eax, monto10
	add montototal, eax
	mov ebx, 5
	mul ebx
	mov ebx, 100d
	div ebx
	mov isr10, eax

	push dword ptr [isr10]
	push dword ptr [monto10]
	push offset msg10
	call printf
	add esp, 12

;se calcula el isr11

	sub eax, eax
	mov eax, monto11
	add montototal, eax
	mov ebx, 5
	mul ebx
	mov ebx, 100d
	div ebx
	mov isr11, eax

	push dword ptr [isr11]
	push dword ptr [monto11]
	push offset msg11
	call printf
	add esp, 12

;se calcula el isr12

	sub eax, eax
	mov eax, monto12
	add montototal, eax
	mov ebx, 5
	mul ebx
	mov ebx, 100d
	div ebx
	mov isr12, eax

	push dword ptr [isr12]
	push dword ptr [monto12]
	push offset msg12
	call printf
	add esp, 12


;verificar si el monto total supera los 150,000
	mov ecx, 150000d
	cmp montototal, ecx
	jg lp1
	jl lp2	

;es Mediano contribuyente
lp1:
	push offset msgmc
	call printf
	jmp fin
	
;sigue siendo pequeño contribuyente
lp2:
	push offset msgpc
	call printf
	jmp fin

fin:
	push 0
	call exit


main ENDP
END