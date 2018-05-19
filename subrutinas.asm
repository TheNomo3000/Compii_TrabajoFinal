        .module subrutinas
        
        ; definicion de constantes
        fin     	.equ 	0xFF01
        teclado		.equ	0xFF02
        pantalla 	.equ 	0xFF00
        clearScreen:    .asciz  "\n\33[2J"
        titulo2:        .asciz  "\t\33[36m!A JUGAR!\n\n"
        divisor:        .asciz  "\33[35m\n==========================\n\n\33[0m\33[1m"
        barra:		    .asciz	"\33[35m=========\n\33[0m\33[1m"
        opcion:         .asciz  "Selecciona la letra que quieres mover: "

        Magenta:        .asciz  "\33[35m"
        Cyan:           .asciz  "\33[36m"

        cont:           .byte 0x00

        .globl  limpiar
        .globl  imprime_cadena
        .globl  cargar_tablero
        
        .globl  puzzle_lista
        .globl  puzzle_numero

cargar_tablero:
    jsr     limpiar
    jsr     imprimir_titulo

    ldb     puzzle_numero
    subb    #1
 
    lslb
    lslb    
    lslb
    lslb
    
    ldx     #puzzle_lista
    leay    b,x
    jsr     imprime_tablero
    ldx     #barra
    jsr     imprime_cadena
    
    jsr     imprimir_divisor
    ldx     #opcion
    jsr     imprime_cadena

    pausa:  lda teclado
    clr     puzzle_numero
    
    rts

limpiar:
    ldx     #clearScreen
    jsr	    imprime_cadena
    rts

imprimir_titulo:
    ldx     #titulo2
    jsr     imprime_cadena
    jsr     imprimir_divisor
    rts

imprimir_divisor:
    ldx     #divisor
    jsr     imprime_cadena
    rts
    
;Imprimir tablero

imprime_tablero:
    lda     #'\t
    sta     pantalla
    ldx     #barra
    jsr     imprime_cadena

    lda     #'\t
    sta     pantalla

    bucle:
        lda     #0x7C
        sta     pantalla
        lda     cont
        
        cmpa    #1
        blo     continuar
        lda     #'\n
        sta     pantalla
        
        lda     #'\t
        sta     pantalla

        lda     cont
        cmpa    #4
        bhs     continuar
        lda     #0x7C
        sta     pantalla

        continuar:
        
        ldx     #Cyan
        jsr     imprime_cadena
        inc     cont
        lda     cont
        clrb
        cmpa    #4
        bhi     acaba
        sgte_tab:
            cmpb    #4
            bhs     bucle
            lda     ,y+
            sta 	pantalla
            cmpb    #3
            bhs     saltar
            lda     #0x20
            sta     pantalla
            saltar:
            incb
            bra 	sgte_tab
acaba:
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
