.386
.model flat, stdcall

.data 
num1 word	3d
comparador word 0d
num2 word   5d
num3 word   10d

.code 
start PROC
	mov ax, 0  ;change the value of ax and bx 
	mov bx, 0
	.IF ax < comparador ; if (ax < comparador): ax = 3 + 5 = 8
		mov cx, num1
		add cx, num2
	.ENDIF
	.IF bx > comparador ; if (bx > comparador): bx = 5 - 3 = 2
		MOV bx, num2
		sub bx, num1
	.ELSEIF bx == comparador ; if (comparador == bx): bx = 10 - 5 = 5
		MOV bx, num3
		sub bx, num2
	.ELSE   ;if (comparador > bx): bx = 10 * 5
		MOV AX, 10
		MOV bx, num2
		MUL BX
	.ENDIF 
	RET

start ENDP 
END start