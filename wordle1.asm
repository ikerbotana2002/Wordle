	.module wordle
        .globl menu_principal
	.globl cadena_juego
	.globl cadena_salir
	.globl cadena_invalida
	.globl cadena_empieza_juego
	.globl print
	.globl mostrar_dic
	.globl juego
	.globl cadena_salto
	.globl borra_pantalla
	
        ;definimos constantes

screen   .equ 0xFF00
fin	 .equ 0xFF01
teclad	 .equ 0xFF02
	
programa:
	jsr borra_pantalla			;para una mejor estética en el terminal
        ldx #menu_principal
        jsr print

cont:						;se elige ir al diccionario, jugar o salir
	lda teclad
        cmpa #49
        beq _ha_metido_1
        
        cmpa #50
        beq _ha_metido_2
              
        cmpa #83
        beq _ha_metido_3

	cmpa #115
        beq _ha_metido_3
        
        ldx #cadena_invalida			;si se introduce algo que no sea "1", "2" o "S"
        jsr print
        bra programa
        
_ha_metido_1:
	jsr mostrar_dic
	bra programa
	
_ha_metido_2:
	jsr juego
	bra programa
	


_ha_metido_3:
	ldx #cadena_salir
	jsr print
	bra _salir

_salir:
	clra
	sta fin
	.area FIJA (ABS)
        .org 0xFFFE
        .word programa
        
