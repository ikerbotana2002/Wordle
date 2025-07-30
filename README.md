# Wordle
Este proyecto es una versión simplificada del juego Wordle implementada en lenguaje ensamblador para el microprocesador MC6809. El programa permite al usuario jugar adivinando una palabra de cinco letras en un entorno de terminal, con un sistema de colores para dar pistas, similar al juego original.

📁 Estructura del proyecto
El código está dividido en múltiples archivos .asm para mejorar su organización y legibilidad. El ensamblaje, enlace y ejecución del programa se realiza mediante el script c.sh.

Archivos principales y su función:
c.sh: script bash que ensambla, enlaza y ejecuta el programa.
👉 Para ejecutar:

bash
Copiar
Editar
cd wordle
./c.sh
wordle1.asm: archivo principal del programa. Presenta el menú inicial con tres opciones:

1: mostrar el diccionario.

2: comenzar una partida.

S o s: salir del programa.

mostrar_dic.asm: muestra el contenido del diccionario (diccionario.asm), presentando una palabra por línea para facilitar la lectura.

juego.asm: lógica del juego Wordle:

Muestra el tablero.

Registra los intentos del usuario.

Compara las letras y colorea las celdas según:

🟩 Verde: letra correcta en posición correcta.

🟨 Amarillo: letra correcta en posición incorrecta.

🟥 Rojo: letra incorrecta.

textos.asm: contiene todas las cadenas de texto utilizadas en el programa para centralizar su gestión.

utilidades.asm: incluye funciones reutilizables como:

print: imprime una cadena de texto.

print_number: imprime un número.

borra_pantalla: limpia el terminal.

Funciones para aplicar color a las letras según su estado.

🧠 Lógica del juego
Se registran hasta 6 intentos para adivinar la palabra.

Cada intento se guarda en una lista de palabras (array) y su estado de colores se guarda en array_estado_palabra.

Al adivinar correctamente (todo en verde) se gana.

Si se fallan los 6 intentos, el usuario puede volver a jugar o regresar al menú principal.

✅ Requisitos
Entorno compatible con simulación o emulación del MC6809.

Permisos de ejecución sobre el script c.sh.
