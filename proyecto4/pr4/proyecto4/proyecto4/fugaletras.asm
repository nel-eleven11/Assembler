;Universidad del Valle de Guatemala
;Nelson García Bravatti 22434
;Gabriel Paz 221087
;Oscar Fuentes
;Andy Fuentes 
;Org de computadoras y Assembler
;Proyecto 4
;Descripción: Juego fuga de letras

.386
.model flat, stdcall, c
.stack 4096

.data

;mensages y fmt
    msg_inicial db "Bienvenido al juego: Fuga de letras",0AH,0
    fmt_letra db "%s",0AH,0

;varibles generales
    puntaje1 dword 0
    puntaje2 dword 0

;arrays

    arr db "manzana", "perro", "gato", "sol", "luna", "casa", "árbol", "coche", "libro", "amigo", "playa", "ciudad", "alegría", "amor", "risa", "felicidad", "caminar", "correr", "saltar", "dormir", "comer", "beber", "jugar", "aprender", "cantar", "bailar", "viajar", "familia", "trabajo", "estudiar", "computadora", "teléfono", "televisión", "música", "deporte", "montaña", "mar", "vida", "tiempo", "espacio"

	
.code

    includelib libucrt.lib
    includelib legacy_stdio_definitions.lib
    includelib libcmt.lib
    includelib libvcruntime.lib

    extrn printf:near
    extrn scanf:near
    extrn exit:near

main PROC





main ENDP

END