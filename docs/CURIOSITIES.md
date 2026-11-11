# Curiosities

## TAB and CAPS

When the CASIO intro ends the game looks at two keys (0x8066): with **TAB** held, 0xE03A = 2 and the hero never dies
(death, 0x8282, is cancelled at once: neither the empty bar nor the logs); with **CAPS**, 0xE039 = 2 and, when the
lives run out, they are two again (0x830B). The demo clears them.

## The demo plays the cartridge

The demo's controls are read from a list, one byte every 16 frames (the low half is the joystick, the high half the
buttons), that starts at **0x4000** (0x80DA): the cartridge header ("AB", INIT...) and the INIT code. There is no
list made for it.

## Bytes that do two jobs

- The title colours (0x5800, 0x300 bytes) end at 0x5A00, which are also the drawings of the pause sprites: the
  colours of tiles 0x70-0x8F come from there and the game then paints them white (0x88CD).
- The four steps of the water are kept in the game's own tiles (0x90-0x9F and 0xA0-0xAF, at 0x5600-0x56FF): the ones
  on screen and the ones waiting their turn.
- The sprites facing the other way are not in the ROM: on land, the game flips the first 26, byte by byte, and puts
  them in drawings 0x80-0xE7 (`sprites_vuelve`, 0x85C1).

## The oni, twice per frame

The oni's routine (`objeto_tierra`, 0x9448) is called by the game loop (0x81D0) and also by the enemies' routine as
it ends (`enemigos`, 0x9469, with a jump): it runs twice every frame. Its count goes up two at a time in the
recordings, so it thinks, moves and checks collisions at twice what its numbers say.

## Tune 5

The tune table has seven (0-6) and no instruction asks for number 5: `musica_pide` is called with 1, 2, 3, 4 and 6,
and only it writes 0xE2BE; it never plays in the recordings.

## Leftovers

- **Code nobody calls**: at 0x8712, a routine that fills the hero's bar one eighth every two calls; at 0x8744,
  another that fills the oni's; at 0x8528, `cerca_y2`, the Y collision check with the weapon (the X one is used); and
  3 bytes at 0x9445 and 2 at 0x9E54, which a jump goes over.
- **A land drawing** (0x431A, 8 x 1 tiles) that no list uses.
- In the ending, the fourth sprite of the arriving figure gets its drawing (0x30) in the colour byte (0x83C9), which
  is overwritten later; its drawing stays at 0.
- The routines that request effects (0xB2E0 and 0xB2EB) check whether a game is on and do nothing with it.
