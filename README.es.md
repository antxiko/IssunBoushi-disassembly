# Issun-boushi no Donnamondai - desensamblado comentado

*(Also [in English](README.md).)*

El desensamblado comentado de **Issun-boushi no Donnamondai** (一寸法師のどんなもんだい; Casio, 1987) para MSX: un cartucho de 32 KB con la cabecera en 0x4000.

- **100 %** del binario explicado: 8.488 bytes de código y 24.280 de datos con nombre, ni un byte sin asignar.
- **60,6 %** del listado comentado, 483 rutinas y etiquetas, ninguna por debajo del 10 % de comentarios.
- El listado se reensambla en la ROM original **byte a byte**.
- El título sale de ejecutar la ROM, cotejado con openMSX punto a punto; la presentación de CASIO, la demostración, el río, GAME OVER, los cinco oni y el final, jugados en GIF en openMSX; las ocho músicas, de su propio motor de sonido, idénticas a openMSX cuadro a cuadro.
- TAB en el título deja al protagonista sin muerte y CAPS da vidas sin fin; la demostración lee sus mandos de la cabecera del cartucho.

La web: <https://antxiko.github.io/IssunBoushi-disassembly/es/>
(en inglés: <https://antxiko.github.io/IssunBoushi-disassembly/>).

## Reproducirlo

La imagen de la ROM no se distribuye. Pon la tuya en la raíz como `issun.rom` (el volcado `[!]` de GoodMSX, sha1 `02a2fafc...`) y ejecuta `make`. El detalle, en [POR DENTRO](docs/es/POR-DENTRO.md).

## Legal

El juego es de Casio y de sus titulares. La licencia de `LICENSE` cubre solo las herramientas, los comentarios, el análisis y la documentación de aquí. Mira [AVISO-LEGAL.md](AVISO-LEGAL.md).
