        .module jugar

        teclado		    .equ	0xFF02

        .globl  jugar

jugar:
    lda     teclado
    rts