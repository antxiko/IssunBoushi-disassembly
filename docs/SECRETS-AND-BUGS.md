# Secrets and bugs

What was searched for in the code and what was found. A bug only goes here if it has been checked: by running the
game's own routine (`tools/bios.py`) or against the openMSX recordings.

## Secrets

Told in [Curiosities](CURIOSITIES.html):

- **TAB** when the CASIO intro ends (0x8066): the hero never dies.
- **CAPS** at the same moment: when the lives run out, they are back to two.
- **The demo plays the cartridge**: its controls are the header bytes, from 0x4000.

Apart from those keys, the controls are read in the interrupt: STOP for the pause (0x8A5C), the stick from the cursor
keys and joystick 1, the joystick 1 buttons, the space bar and GRAPH.

## Bug: past 9,999,990 points, the high score to zero

When the score goes past 999,999 inside (9,999,990 on screen, with the fixed 0), `puntos_suma` (0x894D) copies into the
high score the score **after it has wrapped** (0x8977-0x8986). Running the game's addition here:

| score (on screen) | high score | + | after: score | high score |
|---|---|---|---|---|
| 123,450 | 100,000 | 100 | 123,550 | 123,550 |
| 9,999,900 | 9,999,900 | 100 | **0** | **0** |
| 9,999,500 | 9,999,500 | 900 | **400** | **400** |

## Bug: the cursor keys and the joystick at once

`palanca` (0x8A9F) joins the cursor keys and joystick 1 with an `or` (0x8AAF) of their direction numbers. With both at
once, running it here, right and down give **left** (7), and up-right and down-right give **down-left** (6).

## Checked and correct

- **The life at 10,000**: running the addition, from 9,900 to 10,000 on screen it calls `vida_suma` (0x899A) and sets
  0xE02D so as not to give it twice.

## Leftovers, in [Curiosities](CURIOSITIES.html)

- **The oni runs twice per frame**: both the loop and the enemies routine call it.
- **Tune 5**, which nobody asks for, and a sprite in the ending that gets its drawing in the colour byte (0x83C9).
