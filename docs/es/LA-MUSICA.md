# La m&uacute;sica

Las m&uacute;sicas, a tres voces. No son grabaciones hechas a mano: `tools/musica.py` **ejecuta el motor de sonido
de la propia ROM** con `tools/z80run.py` -la rutina del sonido (`sonido`, 0xB302), cuadro a cuadro, con el
n&uacute;mero que escribe el juego- y apunta lo que escribe en el PSG por la BIOS (WRTPSG).

**Cotejadas con openMSX las ocho**, en las grabaciones (`tools/guiones/`: la demostraci&oacute;n, la partida del
piloto y la forzada): **0 distintos** en todos los cuadros mirados.

## El motor

Es el de otros juegos de Casio: atiende tres **pedidos** -una m&uacute;sica (0xE2BE), un efecto del canal A (0xE2C0)
y otro de B y C (0xE2C2)- y gana el de n&uacute;mero menor. Las tablas: siete m&uacute;sicas en 0xB280 (la 0, nada),
once efectos del canal A en 0xB2AA, ocho de B y C en 0xB2C0 y catorce duraciones en 0xB5B3. Durante la partida el
fondo es un **efecto** de B y C que el bucle pide en cada pasada (`sonido_fondo`, 0x8271): el 7 en el r&iacute;o, el 5
en tierra.

| | qui&eacute;n la pide | dura |
|---|---|---:|
| la presentaci&oacute;n de CASIO | 0x8C6B | 1,1 s |
| el t&iacute;tulo | 0x80B9 | 25,6 s |
| una escena empieza | 0x815C | 4,3 s |
| GAME OVER | 0x8336 | 6,2 s |
| el oni vencido y el final | 0x9C14 y 0x84BF | 7,6 s |
| el r&iacute;o | el bucle (efecto 7) | 34,1 s, vuelve a empezar |
| en tierra | el bucle (efecto 5) | 8,6 s, vuelve a empezar |
| la ca&iacute;da | 0x82AE (efecto 2) | 4,0 s |

## La presentaci&oacute;n de CASIO

<audio controls src="../audio/musica_casio.mp3"></audio>

## El t&iacute;tulo

<audio controls src="../audio/musica_titulo.mp3"></audio>

## Una escena empieza

<audio controls src="../audio/musica_escena.mp3"></audio>

## GAME OVER

<audio controls src="../audio/musica_game_over.mp3"></audio>

## El oni vencido y el final

<audio controls src="../audio/musica_final.mp3"></audio>

## El r&iacute;o

<audio controls src="../audio/musica_rio.mp3"></audio>

## En tierra

<audio controls src="../audio/musica_tierra.mp3"></audio>

## La ca&iacute;da

<audio controls src="../audio/musica_caida.mp3"></audio>
