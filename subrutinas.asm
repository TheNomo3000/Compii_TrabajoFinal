        .module subrutinas
        
        ; definicion de constantes
        fin     	.equ 	0xFF01
        teclado		.equ	0xFF02
        pantalla 	.equ 	0xFF00
        clearScreen:		.asciz  "\33[2J"
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

imprime:
	pshs	a
    cmpb    4
    bhi     acabar

    sgte_letra:
        cmp contador
        lda 	,x+
        beq	    imprimir_letra
        sta 	pantalla
        bra 	sgte
    aumentar:
    incb
imprimir_letra:
	puls	a
	rts


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


