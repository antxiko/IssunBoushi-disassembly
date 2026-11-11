# The music

The tunes, in three voices. They are not hand-made recordings: `tools/musica.py` **runs the ROM's own sound engine**
with `tools/z80run.py` -the sound routine (`sonido`, 0xB302), frame by frame, with the number the game writes- and
logs what it writes to the PSG through the BIOS (WRTPSG).

**All eight checked against openMSX**, in the recordings (`tools/guiones/`: the demo, the pilot's game and the forced
one): **0 different** in every frame looked at.

## The engine

It is the one other Casio games use: it serves three **requests** -a tune (0xE2BE), a channel A effect (0xE2C0) and a
B and C one (0xE2C2)- and the lower number wins. The tables: seven tunes at 0xB280 (number 0, nothing), eleven channel
A effects at 0xB2AA, eight B and C ones at 0xB2C0 and fourteen durations at 0xB5B3. During the game the background is
a B and C **effect** that the loop asks for on every pass (`sonido_fondo`, 0x8271): 7 on the river, 5 on land.

| | who asks for it | length |
|---|---|---:|
| the CASIO intro | 0x8C6B | 1.1 s |
| the title | 0x80B9 | 25.6 s |
| a scene starts | 0x815C | 4.3 s |
| GAME OVER | 0x8336 | 6.2 s |
| the oni beaten and the ending | 0x9C14 and 0x84BF | 7.6 s |
| the river | the loop (effect 7) | 34.1 s, starts again |
| on land | the loop (effect 5) | 8.6 s, starts again |
| the fall | 0x82AE (effect 2) | 4.0 s |

## The CASIO intro

<audio controls src="audio/musica_casio.mp3"></audio>

## The title

<audio controls src="audio/musica_titulo.mp3"></audio>

## A scene starts

<audio controls src="audio/musica_escena.mp3"></audio>

## GAME OVER

<audio controls src="audio/musica_game_over.mp3"></audio>

## The oni beaten and the ending

<audio controls src="audio/musica_final.mp3"></audio>

## The river

<audio controls src="audio/musica_rio.mp3"></audio>

## On land

<audio controls src="audio/musica_tierra.mp3"></audio>

## The fall

<audio controls src="audio/musica_caida.mp3"></audio>
