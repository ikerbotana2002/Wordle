	.module mostrar_dic
	.globl mostrar_dic
	.globl print
	.globl palabras
	.globl cadena_dic
	.globl cadena_num_palabras
	.globl print_number
	.globl cadena_tecla
	.globl borra_pantalla

;cuando el loop lea cada letra hasta llegar a una palabra completa, irá dirigido aquí para que imprima un salto de linea

num_words:
	.byte 0
	

mostrar_dic:
	jsr borra_pantalla
	clr num_words
	ldx #cadena_dic
	jsr print
	ldx #palabras
	ldb #6
_mostrar_dic_loop:
	decb
	beq _mostrar_dic_espacios	
	lda ,x+
	beq _mostrar_dic_fin
	sta 0xFF00
	bra _mostrar_dic_loop
	
_mostrar_dic_espacios:		
	inc num_words
	lda #'\n
	sta 0xFF00
	ldb #6
	bra _mostrar_dic_loop
	
_mostrar_dic_fin:
	ldx #cadena_num_palabras
	jsr print
	lda num_words
	jsr print_number
	ldx #cadena_tecla
	jsr print
	lda 0xff02
	rts
	


