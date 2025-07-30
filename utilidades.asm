
	.module utilidades	
	.globl print                     
	.globl palabras
	.globl print_number
	.globl borra_pantalla
	.globl cadena_juego
	.globl print
	.globl mostrar_dic
	.globl juego
	.globl palabras
	.globl cadena_dic
	.globl cadena_num_palabras
	.globl print_number
	.globl set_blanco
	.globl set_verde
	.globl set_amarillo
	.globl set_rojo
	.globl set_negrita
	.globl set_normal
	
	;definimos constantes
screen  .equ 0xFF00

;print: Imprime el valor gaurdado en el registro a

print:
	pshs a
_print_loop:  
	lda ,x+
        beq _print_end
        sta screen
        bra _print_loop	

_print_end:
	puls a
	rts
	

; print_number: imprime el valor (numerico) guardado en el registro a

print_number_aux: 
	.byte 0

print_number:
	ldb #'0
	cmpa #100
	blo less_100
	suba #100
	incb 
	cmpa #100
	blo less_100
	incb
	suba #100

less_100:
	stb 0xff00

	ldb #80
	stb print_number_aux
	clrb

print_number_loop:
	lslb
	cmpa print_number_aux
	blo print_number_less
	incb
	suba print_number_aux

print_number_less:
	tfr d,x
	lda print_number_aux
	lsra
	sta print_number_aux
	cmpa #10
	tfr x,d
	bhs print_number_loop

	addb #'0
	stb 0xff00
	adda #'0
	sta 0xff00
	ldb #'\n
	stb 0xff00
	rts
	
_borra_mensaje_pantalla:
	.asciz "\33[2J"

_mueve_cursor:
	.asciz "\33[1;1H"
				

_color_blanco:
	.asciz "\33[37m"
	
_color_rojo:
	.asciz "\33[31m"

_color_verde:
	.asciz "\33[32m"
	
_color_amarillo:
	.asciz "\33[33m"

_negrita:
	.asciz "\33[1m"
	
_normal:
	.asciz "\33[0m"

set_blanco:
	pshs x
	ldx #_color_blanco
	jsr print
	puls x
	rts	

set_rojo:
	pshs x
	ldx #_color_rojo
	jsr print
	puls x
	rts

set_verde:
	pshs x
	ldx #_color_verde
	jsr print
	puls x
	rts

set_amarillo:
	pshs x
	ldx #_color_amarillo
	jsr print
	puls x
	rts

set_negrita:
	pshs x
	ldx #_negrita
	jsr print
	puls x
	rts

set_normal:
	pshs x
	ldx #_normal
	jsr print
	puls x
	rts
	
borra_pantalla:				;borra el terminal para una mejor estetica
	ldx #_borra_mensaje_pantalla
	jsr print
	ldx #_mueve_cursor
	jsr print
	rts


