; UNIVERSIDAD DEL VALLE DE GUATEMALA 
; Organizacion de computadoras y Assembler
;Autor: Gabriel Albeerto Paz Gonzalez 221087
;		Nelson Eduardo Garcia Bravatti 22434
;Descripcion: Pre-calificador de préstamos bancarios

.386
.model flat, stdcall, c
.stack 4096

.data

	;FORMULARIO DE CLIENTE, SE DEBE LLENAR CON LOS DATOS DEL CLIENTE

	;NOMBRE Y APELLIDO
	msgName BYTE "Juan Perez",0Ah,0

	;EDAD
	edad DWORD 25d

	;MONTO SOLICITADO
	montoSolicitado DWORD 80000d

	;INGRESOS MENSUALES
	ingresoMensual DWORD 20000d

	;ESTABILIDAD LABORAL EN MESES
	estabilidadLaboral DWORD 16d

	;CALIFICACION EN SUPER INTENDENCIA DE BANCOS
	sib DWORD 000Ah

	;Servira para almacenar el resultado de la division de los 12 mewses
	year DWORD 0

	;MENSAJES

	msgLinea BYTE "-----------------------------------------------------------------",0Ah,0
	;Este segundo mensaje es para la ultima linea de la tabla y tiene dos "0Ah" porque quiero que el mensaje de si el prestamo se le otorgara o no quiero que tenga un espacio de por medio
	msgLinea2 BYTE "-----------------------------------------------------------------",0Ah,0Ah,0
	msgTitulos BYTE "|Datos					    |Valor     |Aprobado|",0Ah,0
	msgNomyApe BYTE "|Nombre y Apellido			    |%s|	|", 0Ah,0
	msgEdad BYTE "|Edad					    |%d	       |%s      |",0Ah,0
	msgMonto BYTE "|Monto Solicitado			    |Q %d.00|	|",0Ah,0
	msgIngresos BYTE "|Ingresos mensuales			    |Q %d.00|%s	|",0Ah,0
	msgMesesEst BYTE "|Meses de estabilidad laboral		    |%d        |%s	|",0Ah,0
	msgCalifica BYTE "|Calificacion en Super interdencia de Bancos|%X	       |%s	|",0Ah,0
	msgAprobacion BYTE "OK",0


	msgVacio BYTE "  ",0
	msgOtorgar BYTE "El prestamo se puede otorgar",0Ah,0
	msgNoOtorgar1 BYTE "El prestamo no se puede otorgar porque hace falta un requisito",0Ah,0
	msgNoOtorgar2 BYTE "El prestamo no se puede otorgar porque hacen falta dos requisitos",0Ah,0
	msgNoOtorgar3 BYTE "El prestamo no se puede otorgar porque hacen falta tres requisitos",0Ah,0
	msgNoOtorgar4 BYTE "El prestamo no se puede otorgar porque hacen todos los requisitos",0Ah,0

	;Contador de requisitos
	sumaRequisistos DWORD 0



.code

    includelib libucrt.lib
    includelib legacy_stdio_definitions.lib
    includelib libcmt.lib
    includelib libvcruntime.lib

    extrn printf:near
    extrn scanf:near
    extrn exit:near

main PROC

	mov edx, 0
	;Muestra la division del formulario
	push offset [msgLinea]
	call printf
	add esp, 4

	;Muestra los titulos del formulario
	push offset [msgTitulos]
	call printf
	add esp, 4

	;Muestra el nombre del cliente
	push offset msgName
	push offset msgNomyApe
	call printf
	add esp, 8

	;Comprueba que el cliente tenga mas de 18 años, si es asi, se imprime el mensaje de que cumple con el requisito
	.IF edad >= 18
		push offset msgAprobacion
		push DWORD ptr [edad]
		push offset msgEdad
		call printf
		add esp, 12

		mov eax, sumaRequisistos
		add eax, 1
		mov sumaRequisistos, eax
	;Si no cumple con el requisito, se imprime el mensaje de que no cumple con el requisito de edad
	.ELSE
		push offset msgVacio
		push DWORD ptr [edad]
		push offset msgEdad
		call printf
		add esp, 12
	.ENDIF

	;Muestra el monto solicitado
	push DWORD ptr [montoSolicitado]
	push offset msgMonto
	call printf
	add esp, 8

	;Realiza el calculo de los ingresos mensuales por 4, para ver si es menor al 400% del ingreso mensual
	mov eax, ingresoMensual
	imul eax, 4

	;Comprueba que el monto solicitado sea menor o igual al 400% del ingreso mensual, si es asi, se imprime el mensaje de que cumple con el requisito
	.IF eax <= montoSolicitado
		
		push offset msgAprobacion
		push DWORD ptr [ingresoMensual]
		push offset msgIngresos
		call printf
		add esp, 12

		mov eax, sumaRequisistos
		add eax, 1
		mov sumaRequisistos, eax
	.ELSE
		push offset msgVacio
		push DWORD ptr [ingresoMensual]
		push offset msgIngresos
		call printf
		add esp, 12
	.ENDIF

	;Calculo de años de estabilidad laboral
	mov edx, 0
	mov eax, estabilidadLaboral
	mov ebx, 12
	div ebx
	mov year, eax

	;Si el año es mayor o igual a 1, se imprime el mensaje de que cumple con el requisito de estabilidad laboral
	.IF year >= 1
		push offset msgAprobacion
		push DWORD ptr [estabilidadLaboral]
		push offset msgMesesEst
		call printf
		add esp, 12

		mov eax, sumaRequisistos
		add eax, 1
		mov sumaRequisistos, eax
	;Si no cumple con el requisito, se imprime el mensaje de que no cumple con el requisito de estabilidad laboral
	.ELSE
		push offset msgVacio
		push DWORD ptr [estabilidadLaboral]
		push offset msgMesesEst
		call printf
		add esp, 12
	.ENDIF

	;Muestra la calificacion de la superintendencia de bancos
		push offset msgAprobacion
		push DWORD ptr [sib]
		push offset msgCalifica
		call printf
		add esp, 12

		mov eax, sumaRequisistos
		add eax, 1
		mov sumaRequisistos, eax
	.ELSE
		push offset msgVacio
		push DWORD ptr [sib]
		push offset msgCalifica
		call printf
		add esp, 12
	.ENDIF

	;Muestra la division final de la tabla
	push offset [msgLinea2]
	call printf
	add esp, 4

	;Se comprueba que el cliente cumpla con todos los requisitos, si es asi, se imprime el mensaje de que se le puede otorgar el prestamo
	.IF sumaRequisistos == 4
		push offset msgOtorgar
		call printf
		add esp, 4
	.ELSEIF sumaRequisistos == 3
		push offset msgNoOtorgar1
		call printf
		add esp, 4
	.ELSEIF sumaRequisistos == 2
		push offset msgNoOtorgar2
		call printf
		add esp, 4
	.ELSEIF sumaRequisistos == 1
		push offset msgNoOtorgar3
		call printf
		add esp, 4
	.ELSE
		push offset msgNoOtorgar4
		call printf
		add esp, 4
	.ENDIF


	RET

main ENDP
END