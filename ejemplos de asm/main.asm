.386
.MODEL FLAT
.STACK 4096
.DATA
Xval DWORD 20
Yval DWORD 3
Zval DWORD 1
PUBLIC Xval, Yval, Zval ;para volver variables a tipo global
;ahora pueden ser accedidas desde otro archivo de assembler
.CODE 

PUBLIC _main
EXTERN  SUB1:near ;equivale a importar SUB1
EXTRN testing:DWORD ;para importar variable de SUB1
_main proc
	;mov AX, @DATA
	;mov DS, AX
	CALL SUB1 ;
	mov edx, testing
	RET
_main endp
end _main
