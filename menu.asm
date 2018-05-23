        .module menu

        fin     	.equ 	0xFF01
        teclado		.equ	0xFF02

        .globl 	iniciar_menu

        .globl  titulo1_1
        .globl  titulo1_2
        .globl  titulo1_3
        .globl  opciones
        .globl  introducir1
        .globl  introducir2
        .globl  tutorial
        .globl  continuartxt
        .globl  escoger

        .globl  cargar_tablero
        .globl  puzzle_numero
        
        .globl  acabar
        .globl 	limpiar
        .globl	imprime_cadena
        

iniciar_menu:
    jsr     limpiar

    ldx	    #titulo1_1
	jsr	    imprime_cadena
    ldx	    #titulo1_2
	jsr	    imprime_cadena
    ldx	    #titulo1_3
	jsr	    imprime_cadena
    ldx     #opciones
    jsr     imprime_cadena
    ldx     #escoger
    jsr     imprime_cadena
    lda     teclado


opt_1:
    cmpa    #'1
    bne     opt_2
    jsr     pedir_numero
    bra     iniciar_menu

opt_2:
    cmpa    #'2
    bne     opt_3
    jsr     instrucciones
    bra     iniciar_menu

opt_3:
    cmpa    #'3
    bne     iniciar_menu
    jsr     acabar

instrucciones:
    jsr     limpiar
    ldx     #tutorial
    jsr	    imprime_cadena
    ldx     #continuartxt
    jsr	    imprime_cadena
    lda     teclado
    bra     iniciar_menu

pedir_numero:
    clra
    jsr     limpiar
    ldx	    #introducir1
	jsr	    imprime_cadena
    lda     teclado
    cmpa    #'1
    blo     cn
    cmpa    #'8
    bhi     cn
    suba    #'0
    sta     puzzle_numero
    jsr     cargar_tablero
cn: jsr     limpiar
    ldx     #introducir2
    jsr     imprime_cadena
    lda     teclado
    cmpa    #'1
    blo     cn
    cmpa    #'8
    bhi     cn
    suba    #'0
    sta     puzzle_numero
    jsr     cargar_tablero
    

