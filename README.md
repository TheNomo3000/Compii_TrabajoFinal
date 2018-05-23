# Compii_TrabajoFinal
Trabajo realizado para computadores II (2018) por Rodrigo Zavala Zevallos y Fiz Rey Armesto
<h2>Ensamblador</h2>

El trabajo consiste en un puzzle que hay que ordenar.Está realizado en ensamblador para el chip motorola 6809.
El programa está dividido en en 6 archivos:

programa.asm:
Núcleo del programa, desde aquí se inicializa y termina.

menu.asm:
Conjunto de bucles para la utilización del menú.

subrutinas.asm:
Subrutinas de uso común que se llaman en el resto de los archivos.

jugar.asm:
Código de iteneración de movimientos del puzzle.

texto.asm:
Contiene todos los .asciz que se utilizan en el programa a excepción de los tableros.

tableros.asm:
Tableros que se utilizan en el juego.
