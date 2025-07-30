	.module textos
	.globl menu_principal
	.globl cadena_juego
	.globl cadena_salir
	.globl cadena_invalida
	.globl cadena_empieza_juego
	.globl cadena_dic
	.globl cadena_num_palabras
	.globl cadena_cabecera
	.globl cadena_tablero
	.globl cadena_salto
	.globl cadena_palabra
	.globl cadena_error
	.globl cadena_borrar
	.globl cadena_espacio	
	.globl cadena_final
	.globl cadena_vacia
	.globl cadena_acierto
	.globl cadena_tecla
	
menu_principal: 
	.asciz "\n\n--WORDLE--\n1) VER DICCIONARIO\n2) JUGAR\nS) SALIR\nQue opcion quieres?\n"

cadena_juego:
	.asciz "\nElegiste la opcion 2 (Jugar)\n"

cadena_salir:
	.asciz "\nElegiste la opcion S (Salir)\n"

cadena_invalida:
	.asciz "\nOpcion invalida\n"

cadena_empieza_juego:
	.asciz "\nDe acuerdo, pues empieza el juego.\n"

cadena_dic:
	.asciz "\nDiccionario: \n"
	
cadena_num_palabras:
	.asciz "\nPalabras: "

cadena_cabecera:
	.asciz "\n  | JUEGO |\n--|-------|\n  | 12345 |\n--|-------|\n"
	
cadena_tablero:
	.asciz " | "
	
cadena_salto:
	.asciz "\n"

cadena_espacio:
	.asciz " "

cadena_palabra:
	.asciz "\nPALABRA:  "

cadena_error:
	.asciz "\nCaracter invalido, introduzca otro"
	
cadena_borrar:
	.asciz "\nHA borrado una letra"

cadena_final:
	.asciz "\nNo has acertado.\nPulse r para volver a jugar; Pulse cualquier otra letra para salir al menu: "
	
cadena_vacia:
	.asciz " "
	
cadena_tecla:
	.asciz "\nPulse cualquier tecla para volver al menu: "
	
cadena_acierto:
	.asciz "\nFelicidades, has acertado la palabra\nPulse r para volver a jugar; Pulse cualquier otra tecla para salir al menu: "



