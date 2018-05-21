        .module jugar

        teclado		    .equ	0xFF02
        pantalla 	    .equ 	0xFF00

        aciertos:       .byte   0x00
        movimientos:    .byte   0x00

        .globl  aciertostxt
        .globl  movimientostxt
        .globl  clearScreen
        .globl  titulo_jugar
        .globl  divisor
        .globl  barra
        .globl  selecciona
        .globl  barra_pie
        .globl  magenta
        .globl  cyan
        .globl  solucion
        .globl  cont

        .globl  imprime_cadena
        .globl  limpiar
        .globl  iniciar_menu

        .globl  puzzle_numero
        .globl  puzzle_lista
       
        .globl  jugar





jugar:
    clr     aciertos
    clr     movimientos
    cargar_tablero2:

    ldb     puzzle_numero
    subb    #1
 
    lslb
    lslb    
    lslb
    lslb
    
    ldx     #puzzle_lista
    leay    b,x

    jugar2:
    clra
    pshs    a

    jsr     limpiar
    ldx     #titulo_jugar
    jsr     imprime_cadena
    ldx     #divisor
    jsr     imprime_cadena
    ldx     #aciertostxt
    jsr     imprime_cadena
    inc     aciertos
    lda     #aciertos
    sta     pantalla
    lda     #'\n
    sta     pantalla
    
    puls    a

    jsr     imprime_tablero2
    ldx     #barra
    jsr     imprime_cadena
    ldx     #movimientostxt
    jsr     imprime_cadena
    ldx     movimientostxt
    sta     pantalla
    ldx     #divisor
    jsr     imprime_cadena
    ldx     #selecciona
    jsr     imprime_cadena
    lda     teclado
    jsr     jugar2
    jsr     iniciar_menu

    lda     teclado

    imprime_tablero2:
    clr     cont
    lda     #'\t
    sta     pantalla
    ldx     #barra
    jsr     imprime_cadena

    lda     #'\t
    sta     pantalla

    bucle2:
        ldx     #barra_pie
        jsr     imprime_cadena
        lda     cont
        
        cmpa    #1
        blo     continuar2
        lda     #'\n
        sta     pantalla
        lda     #'\t
        sta     pantalla

        lda     cont
        cmpa    #4
        bhs     continuar2
        lda     #0x7C
        sta     pantalla


        continuar2:
        
        inc     cont
        lda     cont
        clrb
        cmpa    #4
        bhi     acaba
        sgte_tab:
            cmpb    #4
            bhs     bucle2
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
