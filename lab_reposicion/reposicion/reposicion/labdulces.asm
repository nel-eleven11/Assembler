;Universidad del Valle de Guatemala
;Nelson García Bravatti 22434
;Org de computadoras y Assembler
;lab de reposicion
;Descripción: maquina dispensadora de dulces


.386
.model flat, stdcall, c
.stack 4096

.data


    ;mensajes
    msg_inicial db "Bienvenido a la maquina de dulces",0AH,0
    msg_menu db "1. COMPRAR DULCE 2. VER INVENTARIO 3. SALIR",0AH,0
    msg_op db "Ingrese una opcion del menu",0AH,0
    msg_res db "Opcion ingresada: %d",0AH,0
    msg_alert db "Ingrese un numero del 1 al 3 por favor.",0AH,0
    msg_alert2 db "Ingrese un numero del 1 al 4 por favor.",0AH,0
    fmt_num db "%d",0
    espacio BYTE " ",0Ah, 0
    msg_despedida db "Gracias por usar el programa",0AH,0
    msg_com db "Comprar dulces",0AH,0
    msg_inv db "Ver inventario",0AH,0
    msg_dul db " ¿ Que dulce desea comprar ?",0AH,0
    msg_menu2 db "1. Snickers 2. Nerds Melon-cherry 3. Nerds wildberry-peach 4. REGRESAR ",0AH,0
    msg_nodulce db "El dulce que desea no esta disponible",0AH,0
    msg_m db "El monto a cobrar es : %d", 0ah, 0
    msg_pago db "El pago hecho es de : %d", 0ah, 0
    msg_cambio db "Su cambio es de : %d", 0ah, 0
    msg_valor db "Ingrese el billete con el cual pagara",0AH, 0
    pago1   db "%d", 0
    msg_din db "No es suficiente dinero, vuelva a escoger su dulce",0AH, 0



    ;variables generales
    opcion dword 0
    opcion2 dword 0
    monto dword 300d
    contador dword 0
    pago dword 0 
    cobro dword 0
    cambio dword 0



    ;arreglos
    arr_dulces dword 4,12,1
    arr_costos dword 8,10


    ;inventario
   ;msg_inve5 db "|------------------------|-------------------|--------|",0AH,0
    msg_inve1 db "| Producto               | Cantidad en stock | Precio |",0AH,0
   ;msg_inve5 db "|------------------------|-------------------|--------|",0AH,0
    msg_inve2 db "| Snickers               |  %d                | Q8.00  |",0AH,0
   ;msg_inve5 db "|------------------------|-------------------|--------|",0AH,0
    msg_inve3 db "| Nerds Melon-cherry     |  %d               | Q10.00 |",0AH,0
   ;msg_inve5 db "|------------------------|-------------------|--------|",0AH,0
    msg_inve4 db "| Nerds wildberry-peach  |  %d                | Q10.00 |",0AH,0
    msg_inve5 db "|------------------------|-------------------|--------|",0AH,0



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

    push offset msg_inicial         ;mensaje inicial 
    call printf 
    add esp, 4
    push offset espacio                    ; espacio
    call printf
    add esp, 4

    jmp lb_menu

lb_menu: 

    push offset msg_menu ;se muestran las opciones del menú
    call printf 
    add esp, 4

    push offset espacio                    ; espacio
    call printf
    add esp, 4

    push offset msg_op                    ; se pide que ingrese una opcion del menu
    call printf
    add esp, 4

    push offset espacio                    ; espacio
    call printf
    add esp, 4


    ;el usuario elige una opción del menú

    lea eax, [ebp-4]     ; Obtiene la dirección de la variable local
    push eax             ; Pone la dirección en la pila
    push offset fmt_num  ; Pone la dirección de la cadena de formato en la pila
    call scanf           ; Llama a la función scanf para leer el número ingresado
    add esp, 8           ; Limpia la pila
    
    mov eax, [ebp-4]     ; Mueve el número ingresado a eax
    mov opcion, eax      ;se guarda 
    push eax             ; Pone el número en la pila
    push offset msg_res   ; Pone la dirección de la cadena de formato en la pila
    call printf          ; Llama a la función printf para imprimir la opcion ingresada
    add esp, 8           ; Limpia la pila

    push offset espacio                    ; espacio
    call printf
    add esp, 4

    mov ecx, opcion

    .IF ecx == 1
        
        push offset msg_com      ;comprar dulces
        call printf
        add esp, 4

        jmp comprar ;llamado a subrutina

    .ELSEIF ecx == 2

        push offset msg_inv      ;inventario
        call printf
        add esp, 4

        call inventario    ;se llama subrutina
        jmp lb_menu                     ;se regresa al menú

    .ELSEIF ecx == 3
    ;salir
 
        push offset msg_despedida      ;despedida del programa 
        call printf
        add esp, 4
        jmp fin 

    .ELSE
    ;otro numero diferente
        push offset msg_alert           ;si se ingresa un número no válido, imprime una alerta
        call printf 
        add esp, 4
        push offset espacio                    ; espacio
        call printf
        add esp, 4
        jmp lb_menu                     ;se regresa al menú
    .ENDIF

comprar:

    push offset msg_menu2           ;se muestran las opciones del segundo menú, el de los dulces
    call printf 
    add esp, 4

    push offset espacio                    ; espacio
    call printf
    add esp, 4

    push offset msg_dul                    ; se pide que ingrese una opcion del menu
    call printf
    add esp, 4

    push offset espacio                    ; espacio
    call printf
    add esp, 4

    ;el usuario elige una opción del menú

    lea eax, [ebp-4]     ; Obtiene la dirección de la variable local
    push eax             ; Pone la dirección en la pila
    push offset fmt_num  ; Pone la dirección de la cadena de formato en la pila
    call scanf           ; Llama a la función scanf para leer el número ingresado
    add esp, 8           ; Limpia la pila
    
    mov eax, [ebp-4]     ; Mueve el número ingresado a eax
    mov opcion2, eax      ;se guarda 
    push eax             ; Pone el número en la pila
    push offset msg_res   ; Pone la dirección de la cadena de formato en la pila
    call printf          ; Llama a la función printf para imprimir la opcion ingresada
    add esp, 8           ; Limpia la pila

    push offset espacio                    ; espacio
    call printf
    add esp, 4

    mov ecx, opcion2

    .IF ecx == 1     
    ;dulce 1
        mov ecx, arr_costos
        mov cobro, ecx
        mov edx, arr_dulces
        .IF edx > 0                             ;verificar que el dulce esté disponible
            sub edx, 1
            mov arr_dulces, edx
            jmp cobro_dulce
        .ELSE
            push offset msg_nodulce                  ;se dice que el dulce no está disponible
            call printf
            add esp, 4
            push offset espacio                    ; espacio
            call printf
            add esp, 4
            jmp comprar
        .ENDIF

    .ELSEIF ecx == 2
    ;dulce 2
        mov ecx, arr_costos + 4
        mov cobro, ecx
        mov edx, arr_dulces + 4
        .IF edx > 0                          ;verificar que el dulce esté disponible
            sub edx, 1
            mov arr_dulces + 4, edx
            jmp cobro_dulce
        .ELSE
            push offset msg_nodulce                    ;se dice que el dulce no está disponible
            call printf
            add esp, 4
            push offset espacio                    ; espacio
            call printf
            add esp, 4
            jmp comprar
        .ENDIF
    .ELSEIF ecx == 3
    ;dulce 3
        mov ecx, arr_costos + 4
        mov cobro, ecx
        mov edx, arr_dulces + 8
        .IF edx > 0                              ;verificar que el dulce esté disponible
            sub edx, 1
            mov arr_dulces + 8, edx
            jmp cobro_dulce
        .ELSE
            push offset msg_nodulce                    ;se dice que el dulce no está disponible
            call printf
            add esp, 4
            push offset espacio                    ; espacio
            call printf
            add esp, 4
            jmp comprar
        .ENDIF
    .ELSEIF ecx == 4
    ;regresar al menú principal
 
       jmp lb_menu                     ;se regresa al menú

    .ELSE
    ;otro numero diferente
        push offset msg_alert2           ;si se ingresa un número no válido, imprime una alerta
        call printf 
        add esp, 4
        push offset espacio                    ; espacio
        call printf
        add esp, 4
        jmp comprar                     ;se regresa al menú de comprar dulces
    .ENDIF

    jmp lb_menu                     ;se regresa al menú

cobro_dulce:

    push cobro
    push offset msg_m           ;se muestran el cobro
    call printf 
    add esp, 4

    push offset msg_valor  ;coloca la dirección del mensage en la pila, mensage para pagar
    call printf				;se imprime el mensage
    add esp, 4				;limpiar pila

    lea eax, [ebp-4]     ; Obtiene la dirección de la variable local
    push eax             ; Pone la dirección en la pila
    push offset pago1    ; Pone la dirección de la cadena de formato en la pila
    call scanf           ; Llama a la función scanf para leer el número ingresado, se toma el dinero
    add esp, 8           ; Limpia la pila

    mov eax, [ebp-4]     ; Mueve el número ingresado a eax
    mov pago, eax          ; se guarda el pago
    push eax             ; Pone el número en la pila
    push offset msg_pago ; Pone la dirección de la cadena de formato en la pila
    call printf          ; Llama a la función printf para imprimir el dinero que se dio
    add esp, 8           ; Limpia la pila

    mov eax, pago
    mov ebx, cobro
    mov edx, monto

    .IF eax == ebx
    ;es la misma cantidad no hay problema
        add edx, eax 
        jmp comprar
    .ELSEIF eax > ebx
    ;hay que devolver vuelto
        add edx, eax 
        jmp vuelto
    .ELSE
    ;no tiene suficiente dinero
        push offset msg_din  
        call printf				;se imprime el mensage
        add esp, 4				;limpiar pila
        jmp comprar
    .ENDIF

    mov monto, edx

vuelto:

    sub eax, eax
    sub ebx, ebx        ;se limpian los registros
    mov ebx, cobro      ;se calcula el cambio
    mov eax, pago
    sub eax, ebx
    mov cambio, eax     
    mov eax, cambio
    mov edx, monto
    sub edx, eax

    push eax
    push offset msg_cambio  ;coloca la dirección del mensage en la pila, mensage para pagar
    call printf				;se imprime el mensage
    add esp, 8				;limpiar pila

    mov monto, edx

    jmp comprar


fin:
	push 0                      ;se finaliza el programa
	call exit

main ENDP

inventario PROC
    
    push offset espacio                    ; espacio
    call printf
    add esp, 4

    mov esi, offset arr_dulces
	mov ebx, sizeof	arr_dulces
    
    push offset msg_inve5                    ; linea de la tabla
    call printf
    add esp, 4

	push offset msg_inve1		; Pasar formato 
	call printf
    add esp, 4

    push offset msg_inve5                    ; linea de la tabla
    call printf
    add esp, 4

    mov eax, [esi]		; DIRECCIONAM. INDIRECTO: Cargar el valor del i-esimo elem de array a eax 
	push eax			; Pasar valor a pila p/imprimir
	push offset msg_inve2		; Pasar formato 
	call printf
    add esp, 4

	sub ebx, 4			; Decrementar "contador"
	add esi, 4			; Moverse al sig. elem. del array

    push offset msg_inve5                    ; linea de la tabla
    call printf
    add esp, 4

    mov eax, [esi]		; DIRECCIONAM. INDIRECTO: Cargar el valor del i-esimo elem de array a eax 
	push eax			; Pasar valor a pila p/imprimir
	push offset msg_inve3		; Pasar formato 
	call printf
    add esp, 4

    sub ebx, 4			; Decrementar "contador"
	add esi, 4			; Moverse al sig. elem. del array

    push offset msg_inve5                    ; linea de la tabla
    call printf
    add esp, 4

    mov eax, [esi]		; DIRECCIONAM. INDIRECTO: Cargar el valor del i-esimo elem de array a eax 
	push eax			; Pasar valor a pila p/imprimir
	push offset msg_inve4		; Pasar formato 
	call printf
    add esp, 4

    sub ebx, 4			; Decrementar "contador"
	add esi, 4			; Moverse al sig. elem. del array
	
    push offset msg_inve5                    ; linea de la tabla
    call printf
    add esp, 4

    pop esi
    mov esp, ebp
	pop ebp 

inventario ENDP

END