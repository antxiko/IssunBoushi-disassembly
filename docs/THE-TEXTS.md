# The texts

All the cartridge's texts are in a single block (`textos`, 0x8D5A-0x8E15). The letters and digits are the cartridge's
own (`letras_dibujos`, 0x4B80): digits in tiles 0-9, space in 0x10 and letters from 0x11 (A). The name, CASIO and the
labels are drawn tiles.

| address | text | where it shows | translation |
|---|---|---|---|
| 0x8D5B / 0x8D64 | CASIO (two rows of large tiles) | the intro (`presentacion`, 0x8C28) | |
| 0x8E0E | SOFTWARE (tiles 0x80-0x86) | the intro, under CASIO (0x8C70) | |
| 0x8D6D | 一寸法師 の どんなもんだい (64 tiles) | the title (`titulo_nombre`, 0x8BDF) | "Issun-bōshi: how about that?" |
| 0x8D95 | どんなもんだい | the ending, large (0x84A9) | "how about that?", "take that!" |
| 0x8DB7 | CASIO (tiles 0x8A-0x8F) | the title, row 4 | |
| 0x8DAD | GAME START | the title, row 18 (0x80AC) | start the game |
| 0x8DBD | PUSH TRIG:1 OR SPACE | the title, row 20 | press button 1 or the space bar |
| 0x8DD1 | COPYRIGHT 1987 © CASIO | the title, row 16 | |
| 0x8DE7 | HISCORE: | the scoreboard (0x8611) | the high score |
| 0x8DEF | (lives drawing) = | the bar on row 22 (`barra_arriba`, 0x8697) | lives left |
| 0x8DF2 | (scene drawing) = | the bar on row 23 (`barra_abajo`, 0x86B6) | the scene |
| 0x8DF5 | GAME OVER | out of lives (0x8326) | game over |
| 0x8DFE | sixteen spaces | clears the intro rows (0x8CBE) | |

Issun-bōshi (一寸法師, "the one-inch boy") is the hero of the Japanese tale; どんなもんだい is a boast, "how about
that?". Every text is used: each has its `ld hl` in the code.
