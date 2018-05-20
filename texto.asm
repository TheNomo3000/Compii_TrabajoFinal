    .module texto

    .globl 	iniciar_menu
    .globl  titulo1_1
    .globl  titulo1_2
    .globl  titulo1_3
    .globl  opciones
    .globl  introducir1
    .globl  introducir2
    .globl  tutorial
    .globl  continuar
    .globl  clearScreen
    .globl  titulo_jugar
    .globl  divisor
    .globl  barra
    .globl  selecciona
    .globl  barra_pie
    .globl  magenta
    .globl  cyan
    .globl  escoger
    

    titulo1_1:      .asciz  "    \33[1m\33[35m==========\n   |   \t      |   \n"
    titulo1_2:      .asciz  "   |  \33[31mP\33[33mU\33[32mZ\33[36mZ\33[34mL\33[35mE\33[0m\33[35m\33[1m  |\n"
    titulo1_3:      .asciz  "   |   \t      |   \n    \33[35m==========\n\n"

    opciones:       .asciz  "\33[0m\33[1m\n 1) Jugar \n 2) Instrucciones \n 3) Salir\n"
    introducir1:    .asciz "Introduce el numero de puzzle (1 al 8):"
    introducir2:    .asciz "\33[33mCaracter invalido.\n\33[0m\33[1mIntroduce el numero de puzzle (1 al 8):"
    tutorial:       .ascii  "\n Instrucciones:\n\n\t-Mueve las fichas para completar el tablero"
                    .asciz  "\n\t-Mueve la ficha presionando su letra\n\n"
    continuar:      .asciz  "\nPresiona una tecla para continuar...   "

    clearScreen:    .asciz  "\n\33[2J"
    titulo_jugar:   .asciz  "\t\33[36m!A JUGAR!\n"
    divisor:        .asciz  "\33[35m\n==========================\n\n\33[0m\33[1m"
    barra:		    .asciz	"\33[35m=========\n\33[0m\33[1m"
    selecciona:     .asciz  "\33[32m(Presiona Esc para salir)\n\33[37mSelecciona la letra que quieres mover: "
    escoger:        .asciz  "\nSelecciona la opcion que deseas : "

    barra_pie:      .asciz  "\33[35m|"
    magenta:        .asciz  "\33[35m"
    cyan:           .asciz  "\33[36m"
        

    ;Red:                .asciz  "\33[31m"
    ;Yellow:             .asciz  "\33[33m"
    ;Green:              .asciz  "\33[32m"
    ;Cyan:               .asciz  "\33[36m"
    ;Blue:               .asciz  "\33[34m"
    ;Magenta:            .asciz  "\33[35m"
    ;White:              .asciz  "\33[37m"