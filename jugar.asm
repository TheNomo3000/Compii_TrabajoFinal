        .module jugar

        teclado		    .equ	0xFF02
        pantalla 	    .equ 	0xFF00
        
        aciertos:       .byte   0x00
        movimientos:    .byte   0x00

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
        .globl  continuar
jugar:
    clr     aciertos
    clr     movimientos
    
mover:
    lda     teclado

opt_a:
    cmpa    #'a
    beq     left

opt_w:
    cmpa    #'w
    beq     up

opt_s:
    cmpa    #'s
    beq     down
    
opt_d:
    cmpa    #'d
    beq     right

opt_esc:
    cmpa    #0x1B
    beq     reiniciar
    bra     mover


left:
    
up:

down:

right:
    ldx     #solucion
    jsr     imprime_cadena
    lda     teclado
    rts

comprobar:
    clr     cont
    bucle:
        inc     cont
        lda     cont
        clrb
        cmpa    #4
        bhi     acaba
        sgte_tab:
            cmpb    #4
            bhs     bucle  

            ;comprobar

            incb
            bra 	sgte_tab
acaba:
    ;ganar
    rts

ganar:
    ldx     #ganar
    jsr     imprime_cadena
    ldx     #continuar
    jsr     imprime_cadena
    lda     teclado
reiniciar:
    jsr iniciar_menu