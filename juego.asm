	.module juego
	.globl cadena_juego
	.globl print
	.globl mostrar_dic
	.globl juego
	.globl palabras
	.globl cadena_dic
	.globl cadena_num_palabras
	.globl print_number
	.globl cadena_cabecera
	.globl cadena_tablero
	.globl cadena_salto
	.globl cadena_palabra
	.globl cadena_error
	.globl cadena_borrar
	.globl cadena_espacio
	.globl cadena_final
	.globl borra_pantalla
	.globl cadena_acierto
	.globl set_blanco
	.globl set_verde
	.globl set_amarillo
	.globl set_rojo
	.globl set_negrita
	.globl set_normal


palabra_a_adivinar:		;guardará la palabra del diccionario correspondiente
	.asciz "     "

palabra_a_adivinar_idx:	;incrementará para que cada letra de la palabra del diccionario esté en la 					posicion correcta
	.byte 0


palabra:			;la guardamos en 6 bits porque hay que tener en cuenta el 0 final
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	
palabra_idx:			;su valor se corresponde con la posicion de cada letra de la palabra
	.byte 0

array_palabras:		;guarda las 6 palabras
	.asciz "     "
	.asciz "     "
	.asciz "     "
	.asciz "     "
	.asciz "     "
	.asciz "     "
	
num_palabras_metidas:		;su valor se corresponde con la posicion en la cadena de cada palabra
	.byte 0

array_estado_palabras:		;guarda en cada posición el estado de la letra que está en esa posición
	.ascii "     "
	.ascii "     "
	.ascii "     "
	.ascii "     "
	.ascii "     "
	.ascii "     "
	
estado_juego:
	.byte 0		;0 es jugando; 1 ha ganado; 2 ha perdido
	
	
	
juego:
	lbra _juego_reinicio

_juego_ini:			;imprime la cabecera
	jsr borra_pantalla
	ldx #cadena_cabecera
	jsr print
	clrb

_juego_loop:			;imprime el tablero
	jsr set_blanco
	jsr set_normal
	cmpb #6
	beq loopi
	tfr b,a
	adda #49
	sta 0xFF00
	ldx #cadena_tablero
	jsr print
	ldx #array_palabras
	ldy #array_estado_palabras
	pshs b
	tfr b,a
	tsta
	
_juego_loop_posicion:			;incrementa x e y para que avancen a la siguiente palabra
	beq _imprimir_palabra
	ldb ,x++
	ldb ,x++
	ldb ,x++
	ldb ,y++
	ldb ,y++
	ldb ,y+
	deca
	bra _juego_loop_posicion

_imprimir_palabra:			;imprimer las palabras del tablero en negrita para que resalten
	jsr set_negrita
	
_imprimir_palabra_loop:		;guarda el estado de cada letra
	lda ,y+
	ldb ,x+
	beq _imprimir_palabra_loop_fin
	cmpa #32
	beq _imprimir_espacio_blanco
	cmpa #118		;verde
	beq _verde
	cmpa #97		;amarillo
	beq _amarillo
	jsr set_rojo
	stb 0xff00
	bra _imprimir_palabra_loop

_imprimir_espacio_blanco:
	sta 0xff00
	bra _imprimir_palabra_loop

_verde:
	jsr set_verde
	stb 0xff00
	bra _imprimir_palabra_loop

_amarillo:
	jsr set_amarillo
	stb 0xff00
	bra _imprimir_palabra_loop

;acaba de imprimir las letras del tablero y sigue con el resto del tablero (ya en color blanco y sin 
;negrita)

_imprimir_palabra_loop_fin:			
	puls b
	jsr set_blanco
	jsr set_normal
	ldx #cadena_tablero
	jsr print
	ldx #cadena_salto
	jsr print
	incb
	bra _juego_loop

loopi:						;vamos a comprobar si se ha acabado la partida
	lda estado_juego
	cmpa #1
	lbeq _ha_ganado
	cmpa #2
	lbeq _ha_perdido
				
	ldx #cadena_palabra			;se mete por pantalla cada letra
	jsr print
	ldx #palabra
	jsr print
	lda 0xFF02
	ldx #palabra
	ldb palabra_idx
	
	cmpa #114				;depende el caracter que metas, tiene diferentes funciones
	lbeq _juego_reinicio
	cmpa #118
	lbeq _juego_fin
	cmpa #32
	lbeq _juego_espacio
	cmpa #65
	lblo _juego_error
	cmpa #90
	lbhi _juego_error
	
	
	sta b, x				;guarda que hay una nueva letra en la palabra
	inc palabra_idx
	cmpb #4
	beq _palabra_metida
	bra loopi
	
_palabra_metida:				
	
	ldx #array_palabras
	lda num_palabras_metidas
		

_palabra_metida_posiciona:			;posiciona cada palabra en una posicion de la cadena
	beq _palabra_metida_cont
	ldb ,x++
	ldb ,x++
	ldb ,x++
	deca
	bra _palabra_metida_posiciona
	
_palabra_metida_cont:
	ldy #palabra

_palabra_metida_loop:
	lda ,y+
	beq _palabra_metida_cont2
	sta ,x+
	bra _palabra_metida_loop
	
_palabra_metida_cont2:				;compara x e y (palabra introducida y la que hay que 						adivinar)
	ldx #palabra
	ldy #palabra_a_adivinar
	lda ,x+
	
_juego_comparacion_loop:					
	beq _juego_palabras_iguales		;como la palabra metida es asciz, acaba en 0
	cmpa ,y+
	bne _juego_palabras_diferentes
	lda ,x+
	bra _juego_comparacion_loop
	
_juego_palabras_iguales:			;si todas sus letras coinciden, son iguales
	lda #1
	sta estado_juego
	lda #'v
	pshs a
	pshs a
	pshs a
	pshs a
	pshs a
	pshs a
	lbra _juego_estado_loop_fin
	
_juego_palabras_diferentes:		
	;vamos a calcular el estado de cada letra (verde, amarillo o rojo)
	ldy #palabra_a_adivinar
	ldx #palabra
	
_juego_estado_loop:
	beq _juego_estado_loop_fin
	lda ,x
	cmpa ,y
	beq _letras_iguales
	pshs y
	ldy #palabra_a_adivinar

_juego_compara_letras_loop:
	lda ,y+
	beq _letras_no_existen
	cmpa ,x
	beq _letras_existen
	bra _juego_compara_letras_loop
	
_letras_iguales:		;si coinciden su estado será v (verde)
	lda #'v		
	pshs a
	lda ,y+
	lda ,x+
	bra _juego_estado_loop
	
;si una letra de la palabra introducida existe en la palabra a adivinar, pero no coinciden sus posiciones 
;será a (amarillo)

_letras_existen:		
	lda #'a
	puls y
	pshs a
	lda ,y+
	lda ,x+
	bra _juego_estado_loop

_letras_no_existen:		;si una letra de la palabra introducida no existe en la palabra a adivinar 					será r (rojo)
	lda #'r
	puls y
	pshs a
	lda ,y+
	lda ,x+
	bra _juego_estado_loop
	
	
_juego_estado_loop_fin:	
	ldx #array_estado_palabras
	lda num_palabras_metidas

_juego_estado_loop_fin2:
	beq _juego_estado_fin
	ldb ,x++
	ldb ,x++
	ldb ,x+
	deca
	bra _juego_estado_loop_fin2
	
	;carga en el array de palabras la palabra en curso ya terminada
	
	
	;----------------------------------------
	;linea de separación para empezar a trabajar con los estados de las letras
				
_juego_estado_fin:		

;se sacan de la pila los estados de la palabra en curso, y, como en una pila lo último que entra es lo 
;primero que sale, y en este queremos que lo primero que salga sea lo primero que se ha introducido al 
;hacer sta ,x le añadimos un 4 delante para que lo primero que saque sea lo primero que metimos

	puls a
	puls a
	sta 4,x
	puls a
	sta 3,x
	puls a
	sta 2,x
	puls a
	sta 1,x
	puls a
	sta ,x
	
	ldx #palabra
	clrb
	stb ,x+
	stb ,x+
	stb ,x+
	stb ,x+
	stb ,x+
	stb palabra_idx
	;si las palabras son diferentes, continua metiendo más hasta 6
	inc num_palabras_metidas
	lda num_palabras_metidas
	cmpa #6
	beq _juego_acabando			
	lbra _juego_ini

_juego_error:					;aparece cuando se introduce un caracter que no esta en A-Z
	ldx #cadena_error
	jsr print
	deca
	lbra loopi
	
_juego_espacio:				;borra la ultima letra introducida
	lda palabra_idx
	lbeq loopi
	dec palabra_idx
	deca
	clrb
	ldx #palabra
	stb a, x
	lbra loopi
	
_juego_acabando:
	lda estado_juego
	cmpa #1
	lbeq _juego_ini			;si ya ha ganado no hacemos nada
	lda #2
	sta estado_juego
	lbra _juego_ini
	
	
_juego_reinicio:
						;calculamos la palabra a acertar
	ldx #palabras
	lda palabra_a_adivinar_idx
	
_posicionar_palabra_loop:
	beq _posicionar_palabra_loop_fin
	ldb ,x++
	ldb ,x++
	ldb ,x+
	deca
	bra _posicionar_palabra_loop
	
_posicionar_palabra_loop_fin:	
	inc palabra_a_adivinar_idx
	lda palabra_a_adivinar_idx
	cmpa #18		;lo suyo sería calcular el número de palabras reales que hay
	bne _reinicio_continuar
	clra
	sta palabra_a_adivinar_idx
	
;a continuación, los reinicios pondrán todas las variables iniciales a 0 para que el tablero salga vacío, 
;y las posiciones de las palabras y de cada una de sus letras al volver a jugar
		
_reinicio_continuar:
	ldy #palabra_a_adivinar
	lda ,x+
	sta ,y+
	lda ,x+
	sta ,y+
	lda ,x+
	sta ,y+
	lda ,x+
	sta ,y+
	lda ,x+
	sta ,y+
	clra
	sta palabra_idx
	sta estado_juego
	ldx #palabra
	sta ,x+
	sta ,x+
	sta ,x+
	sta ,x+
	sta ,x+
	sta num_palabras_metidas
	ldx #array_palabras
	lda #32
	ldb #6
	
	
	
_juego_reinicio_loop:
	beq _reinicio_array_estados
	sta ,x+
	sta ,x+
	sta ,x+
	sta ,x+
	sta ,x++
	decb
	bra _juego_reinicio_loop

_reinicio_array_estados:
	ldx #array_estado_palabras
	ldb #32
	lda #30

_reinicio_array_loop:
	beq _juego_reinicio_fin
	stb ,x+
	deca
	
_juego_reinicio_fin:
	lbra _juego_ini

_ha_ganado:
	ldx #cadena_acierto
	jsr print
	lda 0xff02
	cmpa #114			;numero ascii de la r, si pulsas reiniciará
	lbeq _juego_reinicio
	lbra _juego_fin

_ha_perdido:
	ldx #cadena_final
	jsr print
	lda 0xFF02
	cmpa #114			;reiniciar
	lbeq _juego_reinicio
	lbra _juego_fin



_juego_fin:
	rts
