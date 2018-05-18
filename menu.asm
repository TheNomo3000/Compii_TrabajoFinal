        	.module menu

        fin     	.equ 	0xFF01
        teclado		.equ	0xFF02
        
        titulo:             .asciz  "Puzzle"
        opciones:           .asciz  "\n 1) Jugar \n 2) Instrucciones \n 3) Salir\n"
        opcion_11:          .asciz  "\n Introduce el numero de puzzle (1 al 8):"
        tutorial:           .ascii  "\n Instrucciones:\n\n\t-Mueve las fichas para completar el tablero"
                            .asciz  "\n\t-Mueve la ficha presionando su letra\n\n"
        continuar:          .asciz  "\nPresiona una tecla para continuar...   "

        .globl 	iniciar_menu

        .globl  cargar_tablero
        .globl  puzzle_numero
        
        .globl  acabar
        .globl 	limpiar
        .globl	imprime_cadena
        
iniciar_menu:
    jsr     limpiar
    ldx	    #titulo
	jsr	    imprime_cadena
    ldx     #opciones
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
    jsr     Instrucciones
    bra     iniciar_menu

opt_3:
    cmpa    #'3
    bne     iniciar_menu
    jsr     acabar

Instrucciones:
    jsr     limpiar
    ldx     #tutorial
    jsr	    imprime_cadena
    ldx     #continuar
    jsr	    imprime_cadena
    lda     teclado
    bra     iniciar_menu

pedir_numero:
    parada:
    jsr     limpiar
    ldx	    #opcion_11
	jsr	    imprime_cadena
    lda     teclado
    cmpa    #'1
    blo     pedir_numero
    cmpa    #'8
    bhi     pedir_numero
    suba    #'0
    sta     puzzle_numero
    jsr     cargar_tablero
    rts


