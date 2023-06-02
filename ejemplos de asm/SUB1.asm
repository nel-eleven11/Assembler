.MODEL FLAT
;Importacion de variables
extrn Xval:DWORD, Yval:DWORD, Zval:DWORD
.DATA
testing DWORD 100
;Exportacion de variable testing
PUBLIC testing

.CODE
PUBLIC SUB1 ;Volvemos el procedmiento global
SUB1 PROC near ;Inicializamos el procedimiento como near
	MOV EAX, Xval
	MOV EBX, Yval
	MOV ECX, Zval
	SUB EBX, ECX
	SUB EAX, EBX
	mov EBX, Xval
	RET  ;pretornamos a la instruccion que sigue en main
SUB1 ENDP 
END