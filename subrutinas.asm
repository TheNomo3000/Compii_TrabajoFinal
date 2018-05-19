        .module subrutinas
        
        fin     	    .equ 	0xFF01
        teclado		    .equ	0xFF02
        pantalla 	    .equ 	0xFF00

        cont:           .byte 0x00

        .globl  clearScreen
        .globl  titulo_jugar
        .globl  divisor
        .globl  barra
        .globl  selecciona
        .globl  barra_pie
        .globl  magenta
        .globl  cyan
        
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
    ldx     #selecciona
    jsr     imprime_cadena

    pausa:  lda teclado
    clr     puzzle_numero
    
    rts

limpiar:
    ldx     #clearScreen
    jsr	    imprime_cadena
    rts

imprimir_titulo:
    ldx     #titulo_jugar
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
        ldx     #barra_pie
        jsr     imprime_cadena
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
        
        inc     cont
        lda     cont
        clrb
        cmpa    #4
        bhi     acaba
        sgte_tab:
            cmpb    #4
            bhs     bucle  
            ldx     #cyan
            jsr     imprime_cadena

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

imprime_cadena:
	pshs	a
sgte:	lda 	,x+
	beq	ret_imprime_cadena
	sta 	pantalla
	bra 	sgte
ret_imprime_cadena:
	puls	a
	rts
