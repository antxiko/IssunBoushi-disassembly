# Under the hood

## Rebuilding the ROM

`make verify` assembles `src/issun.asm` with pasmo and out comes the 32 KB ROM **byte for byte**. `make sanity`
checks what reassembly does not cover: that no byte declared as data is read as code, that no entry point falls in
data and that all 32,768 bytes are explained. `make test` runs the tests. The ROM is not in the repository: put it in
the root as `issun.rom` (the GoodMSX dump, `[!]`, sha1 `02a2fafc...`).

| | bytes |
|---|---|
| traced code | 8,488 |
| named data | 24,280 |
| unexplained | 0 |

The listing has 2,323 comments in 3,834 instructions (60.6%), 483 routines and labels, none under 10% commented, and
no called routine without a name.

## The cartridge

32 KB at 0x4000-0xBFFF, with the header at 0x4000. INIT (0x4010) also puts the cartridge in page 2 and jumps to
0x8000: 16 `nop` and the start-up. Page 1 is data: the land scenery (0x4038) and the river maps (0x4460) with their
drawings, the bank, the oni of scene 2, the letters (0x4B80), the title and game tiles with their colours
(0x4D00-0x5FFF) and the scenery ones (0x6000-0x7FFF). In page 2, the code (0x8000-0xA27F, with tables in between, the
other oni at 0x9F23), the tiles of scenes 4 and 5 and the sprites (0xA280-0xB27F), the sound tables (0xB280), the
engine (0xB2E0) and its pieces (0xB6BC-0xBFFF).

## The BIOS it uses

RSLREG and ENASLT for the slot; SETGRP, CHGCLR, WRTVDP, DISSCR and ENASCR; FILVRM, LDIRVM and WRTVRM; GTSTCK and
GTTRIG for the controls and SNSMAT for the space bar, GRAPH, STOP, TAB and CAPS; WRTPSG for the sound. The letters are
its own, not the BIOS ones.

## The interrupt and the loop

The start-up puts a jump to 0x8A26 in the H.TIMI hook. The interrupt does the requested silence, shares out the
sprites (below), runs the sound, counts frames and reads STOP, the buttons and the joystick (in the demo, its list).
The game runs in the **loop** (`bucle`, 0x817E): once per frame, the background sound and, if there is no pause, the
water and the river moving on, the protection, what comes down, the enemies and the oni, the hero with the joystick,
the weapon, the jump and the points.

**The hero** is two sprites (0xE320 and 0xE330, IX) and his bowl another two (0xE300 and 0xE310); the weapon, 0xE340.
What comes down the river is 16 blocks of 16 bytes from 0xE380, in pairs of sprites, each type with its routine (the
table at 0x947F).

**The sprites flicker on purpose**: the MSX only shows four per line, and the interrupt (`sprites_rota`, 0x8B59)
copies the ones on screen to the attribute table every frame starting from a different one, so that with five at the
same height they flicker instead of the same one always vanishing.

## How it was done

The trace follows the code from INIT, the interrupt and the jump table of the types (0x947F), declared in
`src/issun.entries`. The rest was **measured in openMSX** (`tools/omsx_cobertura.tcl`) on a Philips VG 8020: nothing
that ran was left out of the trace. Part of the comments come from other Casio games already done
(`comun/casio/porta.py`, on identical stretches: the button routines, the points, the intro and the sound engine),
checked.

The recordings for the site (`tools/guiones/*.tcl`, recorded with `tools/lanza_graba.ps1` on C-BIOS) log, on every
frame, the VDP registers, the RAM from 0xE000, the PSG and the VRAM that changed. `tools/pantallas.py` runs the
title with `tools/bios.py` and checks it against the recording (**0 different points**), `tools/gifs.py` makes the
GIFs and `tools/musica.py` runs the sound engine.

## The RAM

| | |
|---|---|
| 0xE000 | playing |
| 0xE001 | the reserve lives (BCD) |
| 0xE003 / 0xE004 | the scene / the second round |
| 0xE006 / 0xE00C | the digits of the points / the points (BCD) |
| 0xE010-0xE017 | eight frame counts |
| 0xE020 / 0xE022 / 0xE026 | button 2 / button 1 / the start button |
| 0xE027 / 0xE037 | the demo / its list of controls |
| 0xE039 / 0xE03A | CAPS / TAB |
| 0xE051 | the part of the scene: 0 the river, 1 the bank, 2 land |
| 0xE054 | what has been picked up (BCD) |
| 0xE180 | the joystick |
| 0xE183 / 0xE184 | the fall / the scene over |
| 0xE190 / 0xE191 | how far the river has gone / its count |
| 0xE1B2 / 0xE1B4 | STOP / the pause |
| 0xE1B5 / 0xE1B7 | the hero's bar / the oni's |
| 0xE280-0xE2D5 | the sound |
| 0xE300 | the bowl, the hero (0xE320) and the weapon (0xE340) |
| 0xE380 | what comes down the river: 16 of 16 bytes |
| 0xE500 | the oni |
| 0xE600 | the river map (192 x 14) or the land scenery (32 x 22) |
