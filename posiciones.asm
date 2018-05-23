        .module posiciones

        .globl posiciones

        .globl  mover_ficha
        .globl  error_movimiento
        .globl  error
        .globl  fallo
        .globl  continuar_down
        

posiciones:
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