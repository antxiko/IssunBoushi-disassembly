# Secretos y fallos

Lo que se ha buscado en el c&oacute;digo y lo que se ha encontrado. Un fallo solo entra aqu&iacute; si est&aacute;
comprobado: ejecutando la propia rutina del juego (`tools/bios.py`) o contra las grabaciones de openMSX.

## Secretos

Contados en [Curiosidades](CURIOSIDADES.html):

- **TAB** al acabar la presentaci&oacute;n de CASIO (0x8066): el protagonista no muere nunca.
- **CAPS** en el mismo momento: cuando se acaban las vidas, vuelven a ser dos.
- **La demostraci&oacute;n juega el cartucho**: sus mandos son los bytes de la cabecera, desde 0x4000.

Fuera de esas teclas, los mandos se leen en la interrupci&oacute;n: STOP para la pausa (0x8A5C), la palanca de los
cursores y del mando 1, los botones del mando 1, la barra y GRAPH.

## Fallo: pasados los 9.999.990 puntos, el r&eacute;cord a cero

Cuando los puntos pasan de 999.999 por dentro (9.999.990 en pantalla, con el 0 fijo), `puntos_suma` (0x894D) copia al
r&eacute;cord los puntos **despu&eacute;s de dar la vuelta** (0x8977-0x8986). Ejecutando aqu&iacute; la suma del
juego:

| puntos (en pantalla) | r&eacute;cord | + | despu&eacute;s: puntos | r&eacute;cord |
|---|---|---|---|---|
| 123.450 | 100.000 | 100 | 123.550 | 123.550 |
| 9.999.900 | 9.999.900 | 100 | **0** | **0** |
| 9.999.500 | 9.999.500 | 900 | **400** | **400** |

## Fallo: los cursores y el mando a la vez

`palanca` (0x8A9F) junta los cursores y el mando 1 con un `or` (0x8AAF) de sus n&uacute;meros de direcci&oacute;n.
Con los dos a la vez, ejecut&aacute;ndolo aqu&iacute;, derecha y abajo dan **izquierda** (7), y arriba-derecha y
abajo-derecha, **abajo-izquierda** (6).

## Comprobado y correcto

- **La vida de los 10.000**: ejecutando la suma, de 9.900 a 10.000 en pantalla llama a `vida_suma` (0x899A) y apunta
  0xE02D para no darla dos veces.

## Lo que sobra, en [Curiosidades](CURIOSIDADES.html)

- **El oni corre dos veces por cuadro**: lo llaman el bucle y la rutina de los enemigos.
- **La m&uacute;sica 5**, que nadie pide, y un sprite del final que recibe su dibujo en el byte del color (0x83C9).
