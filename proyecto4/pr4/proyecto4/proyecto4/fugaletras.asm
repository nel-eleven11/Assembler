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

    arr_palabras db "manzana", "perro", "gato", "sol", "luna", "casa", "arbol", "coche", "libro", "amigo", "playa", "ciudad", "alegría", "amor", "risa", "felicidad", "caminar", "correr", "saltar", "dormir", "comer", "beber", "jugar", "aprender", "cantar", "bailar", "viajar", "familia", "trabajo", "estudiar", "computadora", "teléfono", "televisión", "música", "deporte", "montaña", "mar", "vida", "tiempo", "espacio"
    arr_incompleta db "man ana", "per o", "ga o", "so", "lu a", "ca a", " rbol", "coc e", "lib o", "ami o", "pla a", "ciuda ", "alegrí ", "am r", "ri a", "felicida ", "cam nar", "cor er", "s ltar", "dormi ", "co er", "be er", "ju ar", "aprende ", "can ar", "baila ", " iajar", "f milia", "traba o", "es udiar", "computa ora", "telé ono", "televi ión", "músi a", "depor e", "monta a", "ma ", "vi a", "tiem o", "es acio"
	arr_letras db "z", "r", "t", "l", "n", "s", "a", "h", "r", "g", "y", "d", "a", "o", "s", "d", "i", "r", "s", "r", "m", "b", "g", "r", "t", "r", "v", "a", "j", "t", "d", "f", "s", "c", "t", "ñ", "r", "d", "p", "p"

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