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
        .globl  reiniciar
jugar:
    ldx     #tablero
    jsr     obtener_pos
    
mover:
    lda     teclado
    jsr     opt_esc
    ldb     pos
    pos_0:
        cmpb    #0x00
        bne     pos_1
        cmpa    #'s
        beq     saltar_dwn
        cmpa    #'d
        beq     saltar_rgh
    pos_1:
        cmpb    #0x01
        bne     pos_2
        cmpa    #'s
        beq     saltar_dwn
        cmpa    #'a
        beq     saltar_lft
        cmpa    #'d
        beq     saltar_rgh
    pos_2:
        cmpb    #0x02
        bne     pos_3
        cmpa    #'s
        beq     saltar_dwn
        cmpa    #'a
        beq     saltar_lft
        cmpa    #'d
        beq     saltar_rgh
    pos_3:
        cmpb    #0x03
        bne     pos_4
        cmpa    #'s
        beq     saltar_dwn
        cmpa    #'a
        beq     saltar_lft
    pos_4:
        cmpb    #0x04
        bne     pos_5
        cmpa    #'w
        beq     saltar_up
        cmpa    #'s
        beq     saltar_dwn
        cmpa    #'d
        beq     saltar_rgh
        jsr     pos_5

    saltar_dwn:
        jsr     down
    saltar_rgh:
        jsr     right
    saltar_up:
        jsr     up
    saltar_lft:
        jsr     left

    pos_5:
        cmpb    #0x05
        bne     pos_6
        cmpa    #'s
        beq     saltar_dwn
        cmpa    #'d
        beq     saltar_rgh
        cmpa    #'w
        beq     saltar_up
        cmpa    #'a
        beq     saltar_lft
    pos_6:
        cmpb    #0x06
        bne     pos_7
        cmpa    #'s
        beq     saltar_dwn
        cmpa    #'d
        beq     saltar_rgh
        cmpa    #'w
        beq     saltar_up
        cmpa    #'a
        beq     saltar_lft
    pos_7:
        cmpb    #0x07
        bne     pos_8
        cmpa    #'s
        beq     saltar_dwn
        cmpa    #'w
        beq     saltar_up
        cmpa    #'a
        beq     saltar_lft
    pos_8:
        cmpb    #0x08
        bne     pos_9
        cmpa    #'w
        beq     saltar_up
        cmpa    #'s
        beq     saltar_dwn
        cmpa    #'d
        beq     saltar_rgh
    pos_9:
        cmpb    #0x09
        bne     pos_10
        cmpa    #'s
        beq     saltar_dwn
        cmpa    #'d
        beq    saltar_rgh
        cmpa    #'w
        beq     saltar_up
        cmpa    #'a
        beq     saltar_lft
    pos_10:
        cmpb    #0x0A
        bne     pos_11
        cmpa    #'s
        beq     saltar_dwn
        cmpa    #'d
        beq     saltar_rgh
        cmpa    #'w
        beq     saltar_up
        cmpa    #'a
        beq     saltar_lft
        jsr     pos_11

        saltar_dwn2:
        jsr     down
    saltar_rgh2:
        jsr     right
    saltar_up2:
        jsr     up
    saltar_lft2:
        jsr     left

    pos_11:
        cmpb    #0x0B
        bne     pos_12
        cmpa    #'s
        beq     saltar_dwn2
        cmpa    #'w
        beq     saltar_up2
        cmpa    #'a
        beq     saltar_lft2
    pos_12:
        cmpb    #0x0C
        bne     pos_13
        cmpa    #'w
        beq     saltar_up2
        cmpa    #'d
        beq     saltar_rgh2
    pos_13:
        cmpb    #0x0D
        bne     pos_14
        cmpa    #'w
        beq     saltar_up2
        cmpa    #'d
        beq     saltar_rgh2
        cmpa    #'a
        beq     saltar_lft2
    pos_14:
        cmpb    #0x0E
        bne     pos_15
        cmpa    #'w
        beq     saltar_up2
        cmpa    #'d
        beq     saltar_rgh2
        cmpa    #'a
        beq     saltar_lft2
    pos_15:
        cmpb    #0x0F
        bne     pos_centro
        cmpa    #'w
        beq     saltar_up2
        cmpa    #'a
        beq     saltar_lft2
    pos_centro: 
        jsr fallo

left:
    parar:
    clr     tablero_temp
    ldy     #tablero
    ldx     #tablero_temp
    clr     cont
    lda     pos
    suba    #0x01
    sta     pos
    clra
    pshs    a
    bucle_left:
        inc     cont
        lda     cont
        clrb
        cmpa    #4
        bhi     seguir_jugando_aux
        sgte_left:
            cmpb    #4
            bhs     bucle_left
            puls    a
            pshs    b

            pshs    a
            ldb 	,y+

            cmpa    pos
            bne     salta_left
            ldb     #0x20
            stb     ,x+
            ldb     ,y+

            salta_left:
            jsr     corregir_c
            stb     ,x+
            
            puls    a
            inca
            puls    b
            incb
            pshs    a
            bra 	sgte_left
up:

seguir_jugando_aux:
    jsr seguir_jugando

down:
    clr     tablero_temp
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

right:
    clr     tablero_temp
    ldy     #tablero
    ldx     #tablero_temp
    clr     cont
    clra
    pshs    a
    bucle_right:
        inc     cont
        lda     cont
        clrb
        cmpa    #4
        bhi     seguir_jugando
        sgte_right:
            cmpb    #4
            bhs     bucle_right
            puls    a
            pshs    b

            pshs    a
            ldb 	,y+

            cmpa    pos
            bne     salta_rigth
            ldb     ,y+
            stb     ,x+
            ldb     #0x20

            salta_rigth:
            ;
            cmpb    #0x08
            bne     salta_rigth_2
            ldb     #0x43
            salta_rigth_2:
            ;
            stb     ,x+
            
            puls    a
            inca
            puls    b
            incb
            pshs    a
            bra 	sgte_right

seguir_jugando:
    lda     #'\0
    sta     ,x
    ldy     #tablero_temp
    jsr     guardar_tablero
    ldy     #tablero
    jsr     imprime_tablero
    break:
    ldx     #tablero
    jsr     obtener_pos
    jsr     mover

corregir_c:
    cmpb    #0x00
    beq     corrige
    cmpb    #0x03
    bhi     corrige
    cmpb    #0x08
    bhi     corrige    
    rts
    corrige:
    ldb     #0x43
    rts

opt_esc:
    cmpa    #0x1B
    bne     back
    jsr     reiniciar
    back:
    rts

otros:
    lda     #'\n
    sta     pantalla
    ldx     #error
    jsr     imprime_cadena
    jsr     jugar

ganar:
    ldx     #ganar
    jsr     imprime_cadena
    ldx     #continuartxt
    jsr     imprime_cadena
    lda     teclado

fallo:
    ldx     #error_movimiento
    jsr     imprime_cadena
    ldx     #mover_ficha
    jsr     imprime_cadena
    lda     teclado
    jsr     mover



