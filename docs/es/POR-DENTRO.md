# Por dentro

## Rehacer la ROM

`make verify` ensambla `src/issun.asm` con pasmo y sale la ROM de 32 KB **byte a byte**. `make sanity` comprueba lo
que el reensamblado no cubre: que ning&uacute;n byte declarado como datos se lea como c&oacute;digo, que ning&uacute;n
punto de entrada caiga en datos y que los 32.768 bytes est&eacute;n explicados. `make test` pasa los tests. La ROM no
est&aacute; en el repositorio: hay que ponerla en la ra&iacute;z como `issun.rom` (el volcado de GoodMSX, `[!]`, sha1
`02a2fafc...`).

| | bytes |
|---|---|
| c&oacute;digo trazado | 8.488 |
| datos con nombre | 24.280 |
| sin explicar | 0 |

El listado tiene 2.323 comentarios en 3.834 instrucciones (60,6 %), 483 rutinas y etiquetas, ninguna por debajo del
10 % comentado, y ninguna rutina llamada sin nombre.

## El cartucho

32 KB en 0x4000-0xBFFF, con la cabecera en 0x4000. INIT (0x4010) pone el cartucho tambi&eacute;n en la p&aacute;gina
2 y salta a 0x8000: 16 `nop` y el arranque. La p&aacute;gina 1 son datos: los decorados de tierra (0x4038) y los mapas
del r&iacute;o (0x4460) con sus dibujos, la orilla, el oni de la escena 2, las letras (0x4B80), las casillas del
t&iacute;tulo y de la partida con sus colores (0x4D00-0x5FFF) y las del decorado (0x6000-0x7FFF). En la p&aacute;gina
2, el c&oacute;digo (0x8000-0xA27F, con tablas en medio, los otros oni en 0x9F23), las casillas de las escenas 4 y 5 y
los sprites (0xA280-0xB27F), las tablas del sonido (0xB280), el motor (0xB2E0) y sus piezas (0xB6BC-0xBFFF).

## La BIOS que usa

RSLREG y ENASLT para el slot; SETGRP, CHGCLR, WRTVDP, DISSCR y ENASCR; FILVRM, LDIRVM y WRTVRM; GTSTCK y GTTRIG para
los mandos y SNSMAT para la barra, GRAPH, STOP, TAB y CAPS; WRTPSG para el sonido. Las letras son las suyas, no las de
la BIOS.

## La interrupci&oacute;n y el bucle

El arranque pone un salto a 0x8A26 en el gancho H.TIMI. La interrupci&oacute;n hace el silencio pedido, reparte los
sprites (abajo), corre el sonido, cuenta cuadros y lee STOP, los botones y la palanca (en la demostraci&oacute;n, su
lista). La partida corre en el **bucle** (`bucle`, 0x817E): una vez por cuadro, el sonido de fondo y, si no hay pausa,
el agua y el avance del r&iacute;o, el protegido, lo que baja, los enemigos y el oni, el protagonista con la palanca,
el arma, el salto y los puntos.

**El protagonista** son dos sprites (0xE320 y 0xE330, IX) y su cuenco otros dos (0xE300 y 0xE310); el arma, 0xE340.
Lo que baja por el r&iacute;o son 16 bloques de 16 bytes desde 0xE380, por parejas de sprites, cada tipo con su
rutina (la tabla de 0x947F).

**Los sprites parpadean a prop&oacute;sito**: el MSX solo pinta cuatro por l&iacute;nea, y la interrupci&oacute;n
(`sprites_rota`, 0x8B59) copia cada cuadro los que est&aacute;n en pantalla a la tabla de atributos empezando por uno
distinto, para que con cinco en la misma altura parpadeen en vez de desaparecer siempre el mismo.

## C&oacute;mo se ha hecho

El trazado sigue el c&oacute;digo desde INIT, la interrupci&oacute;n y la tabla de saltos de los tipos (0x947F),
declaradas en `src/issun.entries`. Lo dem&aacute;s se **midi&oacute; en openMSX** (`tools/omsx_cobertura.tcl`) en un
Philips VG 8020: no qued&oacute; fuera del trazado nada de lo que se ejecut&oacute;. Parte de los comentarios vienen de
otros Casio ya hechos (`comun/casio/porta.py`, en los tramos id&eacute;nticos: las rutinas de los botones, los puntos,
la presentaci&oacute;n y el motor de sonido), revisados.

Las grabaciones de la web (`tools/guiones/*.tcl`, grabadas con `tools/lanza_graba.ps1` en C-BIOS) apuntan, en cada
cuadro, los registros del VDP, la RAM desde 0xE000, el PSG y la VRAM que cambi&oacute;. `tools/pantallas.py` ejecuta
el t&iacute;tulo con `tools/bios.py` y lo coteja con la grabaci&oacute;n (**0 puntos distintos**), `tools/gifs.py` hace
los GIF y `tools/musica.py` ejecuta el motor de sonido.

## La RAM

| | |
|---|---|
| 0xE000 | jugando |
| 0xE001 | las vidas de reserva (BCD) |
| 0xE003 / 0xE004 | la escena / la segunda vuelta |
| 0xE006 / 0xE00C | las cifras de los puntos / los puntos (BCD) |
| 0xE010-0xE017 | ocho cuentas de cuadros |
| 0xE020 / 0xE022 / 0xE026 | el bot&oacute;n 2 / el 1 / el de empezar |
| 0xE027 / 0xE037 | la demostraci&oacute;n / su lista de mandos |
| 0xE039 / 0xE03A | CAPS / TAB |
| 0xE051 | la parte de la escena: 0 el r&iacute;o, 1 la orilla, 2 tierra |
| 0xE054 | lo recogido (BCD) |
| 0xE180 | la palanca |
| 0xE183 / 0xE184 | la ca&iacute;da / la escena acabada |
| 0xE190 / 0xE191 | el avance del r&iacute;o / su cuenta |
| 0xE1B2 / 0xE1B4 | STOP / la pausa |
| 0xE1B5 / 0xE1B7 | la barra del protagonista / la del oni |
| 0xE280-0xE2D5 | el sonido |
| 0xE300 | el cuenco, el protagonista (0xE320) y el arma (0xE340) |
| 0xE380 | lo que baja por el r&iacute;o: 16 de 16 bytes |
| 0xE500 | el oni |
| 0xE600 | el mapa del r&iacute;o (192 x 14) o el decorado de tierra (32 x 22) |
