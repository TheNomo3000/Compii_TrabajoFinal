        .module subrutinas
        
        ; definicion de constantes
        fin     	.equ 	0xFF01
        teclado		.equ	0xFF02
        pantalla 	.equ 	0xFF00
        clearScreen:		.asciz  "\n\33[2J"               ;añadido un retorno de carro para que el menú no salga con espacios
        titulo1:       .asciz  "Cargando Tablero....\n"

        contador:   .byte 1

        .globl  limpiar
        .globl  imprime_cadena
        .globl  cargar_tablero
        
        .globl  puzzle_lista
        .globl  puzzle_numero

cargar_tablero:
    ldb     puzzle_numero
    subb    #1

    lslb
    lslb    
    lslb
    lslb
    
    ldy     #puzzle_lista
    leax    b,y
    jsr     imprime_cadena
    parada:
    rts

limpiar:
    ldx     #clearScreen
    jsr	    imprime_cadena
    rts


;Imprimir tablero


;contador hasta 16 y retorno de carro cada 4

imprime_cadena:
	pshs	a
sgte:	lda 	,x+
	beq	ret_imprime_cadena
	sta 	pantalla
	bra 	sgte
ret_imprime_cadena:
	puls	a
	rts


