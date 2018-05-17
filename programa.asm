    .module programa

    ; definicion de constantes
    fin     	.equ 	0xFF01
    teclado		.equ	0xFF02
    pantalla 	.equ 	0xFF00

    .globl  programa
    .globl  iniciar_menu

    
    .globl  puzzle_numero
    .globl  acabar
    .globl  cargar_tablero

programa:
    jsr   iniciar_menu

acabar: 	
    clra
	sta 	fin

.area   FIJA (ABS)
.org 	0xFFFE	; vector de RESET
.word 	programa

