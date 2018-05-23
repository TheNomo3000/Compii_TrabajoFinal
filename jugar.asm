        .module jugar

        teclado		    .equ	0xFF02
        pantalla 	    .equ 	0xFF00
        
        aciertos:       .byte   0x00
        movimientos:    .byte   0x00
        tablero_temp:   .word   16

        .globl  solucion

        .globl  imprime_cadena
        .globl  limpiar
        .globl  iniciar_menu
        .globl  cont

        .globl  puzzle_numero
        .globl  puzzle_lista
       
        .globl  jugar
        .globl  aciertos
        .globl  movimientos
        
        .globl  ganar
        .globl  continuartxt
        .globl  tablero
        .globl  pos
        .globl  obtener_pos
        .globl  error_movimiento
        .globl  error
        .globl  mover_ficha
        .globl  imprime_tablero
        .globl  guardar_tablero
        .globl  down
        .globl  up
        .globl  left
        .globl  right

seguir_jugando:
    lda     #'\0
    sta     ,x+

    ldy     #tablero_temp
    ;jsr     imprime_cadena
    jsr     guardar_tablero
    ldy     #tablero
    jsr     imprime_tablero
    jsr     jugar
    rts

cambiar:
    clrb
    bucle_cambiar:
        incb
        lda 	,y+
        cmpb    #0x04
        blo     bucle_cambiar
        sta     ,x+
    puls    y
    lda     ,y+
    bra     continuar_down

left:
up:
down:
    ldy     #tablero
    ldx     #tablero_temp
    clrb
    clr     cont
    bucle_down:
        lda 	,y+
        beq     seguir_jugando

        pshs    b
        pshs    y

        cmpb    pos
        beq     cambiar
        puls    y
        continuar_down:
        cmpb    pos
        bls     salta
        inc     cont

        salta:
        ldb     cont
        
        parada:

        cmpb    #0x04
        bne     salta_2
        lda     #0x20
        salta_2:

        ;
        cmpa    #0x03
        bne     salta_3
        lda     #0x43
        ;

        salta_3:
        puls    b
        sta     ,x+
        incb
        bra 	bucle_down
right:
    

jugar:
    clr     movimientos
    clr     tablero_temp
    clra
    clrb
    ldx     #tablero
    jsr     obtener_pos
    
mover:
    lda     teclado
    ldb     pos
    pos_0:
        cmpb    #0x00
        bne     pos_1
        cmpa    #'s
        beq     down
        cmpa    #'d
        beq     right
    pos_1:
        cmpb    #0x01
        bne     pos_2
        cmpa    #'s
        beq     down
        cmpa    #'a
        beq     left
        cmpa    #'d
        beq     right
    pos_2:
        cmpb    #0x02
        bne     pos_3
        cmpa    #'s
        beq     down
        cmpa    #'a
        beq     left
        cmpa    #'d
        beq     right
    pos_3:
        cmpb    #0x03
        bne     pos_4
        cmpa    #'s
        beq     down
        cmpa    #'a
        beq     left
    pos_4:
        cmpb    #0x04
        bne     pos_5
        cmpa    #'w
        beq     up
        cmpa    #'s
        beq     down
        cmpa    #'d
        beq     right
    pos_5:
        cmpb    #0x05
        bne     pos_6
        cmpa    #'s
        beq     down
        cmpa    #'d
        beq     right
        cmpa    #'w
        beq     up
        cmpa    #'a
        beq     left
    pos_6:
        cmpb    #0x06
        bne     pos_7
        cmpa    #'s
        beq     down
        cmpa    #'d
        beq     right
        cmpa    #'w
        beq     up
        cmpa    #'a
        beq     left
    pos_7:
        cmpb    #0x07
        bne     pos_8
        cmpa    #'s
        beq     down
        cmpa    #'w
        beq     up
        cmpa    #'a
        beq     left
    pos_8:
        cmpb    #0x08
        bne     pos_9
        cmpa    #'w
        beq     up
        cmpa    #'s
        beq     down
        cmpa    #'d
        beq     right
    pos_9:
        cmpb    #0x09
        bne     pos_10
        cmpa    #'s
        beq     down
        cmpa    #'d
        beq     right
        cmpa    #'w
        beq     up
        cmpa    #'a
        beq     left
    pos_10:
        cmpb    #0x0A
        bne     pos_11
        cmpa    #'s
        beq     down
        cmpa    #'d
        beq     right
        cmpa    #'w
        beq     up
        cmpa    #'a
        beq     left
    pos_11:
        cmpb    #0x0B
        bne     pos_12
        cmpa    #'s
        beq     down
        cmpa    #'w
        beq     up
        cmpa    #'a
        beq     left
    pos_12:
        cmpb    #0x0C
        bne     pos_13
        cmpa    #'w
        beq     up
        cmpa    #'d
        beq     right
    pos_13:
        cmpb    #0x0D
        bne     pos_14
        cmpa    #'w
        beq     up
        cmpa    #'d
        beq     right
        cmpa    #'a
        beq     left
    pos_14:
        cmpb    #0x0E
        bne     pos_15
        cmpa    #'w
        beq     up
        cmpa    #'d
        beq     right
        cmpa    #'a
        beq     left
    pos_15:
        cmpb    #0x0F
        bne     pos_centro
        cmpa    #'w
        beq     up
        cmpa    #'a
        beq     left
    pos_centro: 
        jsr fallo
opt_esc:
    cmpa    #0x1B
    beq     reiniciar

otros:
    lda     #'\n
    sta     pantalla
    ldx     #error
    jsr     imprime_cadena
    bra     jugar

ganar:
    ldx     #ganar
    jsr     imprime_cadena
    ldx     #continuartxt
    jsr     imprime_cadena
    lda     teclado
reiniciar:
    jsr iniciar_menu

fallo:
    ldx     #error_movimiento
    jsr     imprime_cadena
    ldx     #mover_ficha
    jsr     imprime_cadena
    lda     teclado
    jsr     mover

