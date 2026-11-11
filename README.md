# Issun-boushi no Donnamondai - commented disassembly

*(También [en castellano](README.es.md).)*

The commented disassembly of **Issun-boushi no Donnamondai** (一寸法師のどんなもんだい; Casio, 1987) for the MSX: a 32 KB cartridge with its header at 0x4000.

- **100%** of the binary explained: 8,488 bytes of code and 24,280 of named data, not one byte unassigned.
- **60.6%** of the listing commented, 483 routines and labels, none below 10% of comments.
- The listing reassembles into the original ROM **byte for byte**.
- The title comes from running the ROM, checked against openMSX point by point; the CASIO intro, the demo, the river, GAME OVER, the five oni and the ending, played in GIF in openMSX; the eight tunes, from its own sound engine, identical to openMSX frame by frame.
- TAB on the title makes the hero immortal and CAPS gives endless lives; the demo reads its controls from the cartridge header.

The site: <https://antxiko.github.io/IssunBoushi-disassembly/>
(in Spanish: <https://antxiko.github.io/IssunBoushi-disassembly/es/>).

## Reproducing it

The ROM image is not distributed. Put yours in the root as `issun.rom` (the GoodMSX `[!]` dump, sha1 `02a2fafc...`) and run `make`. The details, in [UNDER THE HOOD](docs/UNDER-THE-HOOD.md).

## Legal

The game belongs to Casio and its rights holders. The licence in `LICENSE` covers only the tools, the comments, the analysis and the documentation here. See [LEGAL-NOTICE.md](LEGAL-NOTICE.md).
