        .module subrutinas
        
        fin     	    .equ 	0xFF01
        teclado		    .equ	0xFF02
        pantalla 	    .equ 	0xFF00

        cont:           .byte   0x00
        tablero:        .word   16
        pos:            .byte   0

        .globl  clearScreen
        .globl  titulo_jugar
        .globl  divisor
        .globl  barra
        .globl  selecciona
        .globl  barra_pie
        .globl  magenta
        .globl  cyan
        .globl  aciertostxt
        .globl  movimientostxt

        .globl  iniciar_menu
        
        .globl  limpiar
        .globl  imprime_cadena
        .globl  cargar_tablero
        .globl  cont
        .globl  imprimir_divisor
        .globl  imprimir_titulo

        .globl  jugar
        
        .globl  puzzle_lista
        .globl  puzzle_numero

        .globl  aciertos
        .globl  movimientos
        .globl  tablero
        .globl  pos
        .globl  obtener_pos
        .globl  imprime_tablero
        .globl  guardar_tablero
        .globl  reiniciar
        .globl  programa
        
cargar_tablero:
    jsr     limpiar
    
    ldb     puzzle_numero
    subb    #1
 
    lslb
    lslb    
    lslb
    lslb
    
    ldx     #puzzle_lista
    leay    b,x
    jsr     guardar_tablero
    ldy     #tablero

    jsr     imprime_tablero
    ldx     #tablero
    jsr     imprime_cadena
    jsr     jugar

guardar_tablero:
    clr     cont
    clr     tablero
    ldx     #tablero
    bucle_guardado:
        inc     cont
        lda     cont
        clrb
        cmpa    #4
        bhi     finalizar
        sgte_guardar:
            cmpb    #4
            bhs     bucle_guardado

            lda     ,y+
            sta 	,x+
            
            incb
            bra 	sgte_guardar
finalizar:
    lda     #'\0
    sta     ,x+
    rts

obtener_pos:
    clr     pos
    pshs	a
    sgte_pos:	
        lda 	,x+
        cmpa    #0x20
        beq     finalizar_pos
        inc     pos
        bra 	sgte_pos
finalizar_pos:
    puls    a
    rts

imprime_aciertos:
    ldx     #aciertostxt
    jsr     imprime_cadena
    ldx     #aciertos
    jsr     imprime_cadena

    lda     #'\n
    sta     pantalla
    rts

imprime_movimientos:
    ldx     #movimientostxt
    jsr     imprime_cadena
    lda     #movimientos
    sta     teclado
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
    jsr     imprimir_titulo
    jsr     imprime_aciertos
    clr     cont
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
    ldx     #barra
    jsr     imprime_cadena
    jsr     imprime_movimientos
    jsr     imprimir_divisor
    ldx     #selecciona
    jsr     imprime_cadena
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

reiniciar:
    clra
    clrb
    clr     tablero
    clr     puzzle_numero
    clr     pos
    clr     puzzle_lista
    jsr     programa