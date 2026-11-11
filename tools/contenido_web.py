#!/usr/bin/env python3
"""EL CONTENIDO de la web de esta ROM: lo unico que es de este juego.

jekyll.py y make_web.py son la maquinaria y no llevan dentro el nombre de
ningun juego: lo leen de aqui.

Todas las cifras de aqui estan medidas sobre esta ROM, con las herramientas
de tools/: CODIGO y DATOS los imprime tools/presupuesto.py (make sanity),
INSTRUCCIONES, COMENTARIOS y RUTINAS los da tools/densidad.py (make densidad:
"de N" rutinas, "N instrucciones, M comentarios").
"""

NOMBRE = "Issun-boushi no Donnamondai"
EDITOR = "Casio"
ANIO = 1987
REPOSITORIO = "https://github.com/antxiko/IssunBoushi-disassembly"
SHA1 = "02a2fafc7b9249db76803ece347ba73be25f71b5"

CODIGO = 8488
DATOS = 24280
RUTINAS = 483
INSTRUCCIONES = 3834
COMENTARIOS = 2323


def densidad(idioma):
    """El porcentaje comentado, con la coma o el punto de cada idioma."""
    d = "%.1f" % (100.0 * COMENTARIOS / INSTRUCCIONES)
    return d.replace(".", ",") if idioma == "es" else d


PIE_LEGAL = {
    "es": "<em>Issun-boushi no Donnamondai</em> (一寸法師のどんなもんだい) es un juego de Casio para MSX, de 1987, en "
          "un cartucho de 32 KB. Todos los derechos sobre el juego siguen siendo de sus titulares. Este trabajo es de "
          "preservaci&oacute;n, estudio y documentaci&oacute;n, y la imagen de la ROM no se distribuye.",
    "en": "<em>Issun-boushi no Donnamondai</em> (一寸法師のどんなもんだい) is a 1987 Casio game for the MSX, on a 32 KB "
          "cartridge. All rights in the game remain with their holders. This is preservation, study and documentation "
          "work, and the ROM image is not distributed.",
}

PORTADA = {
    "es": dict(
        titulo="Issun-boushi no Donnamondai - desensamblado comentado",
        claim="Issun-b&#333;shi, el ni&ntilde;o de una pulgada del cuento, sube el r&iacute;o en su cuenco: "
              "esquiva troncos, ensarta peces, p&aacute;jaros y lo que sale de la orilla, recoge lo que dejan y, al "
              "llegar a tierra, se las ve con el oni de cada escena. Cinco escenas y un final. El t&iacute;tulo sale "
              "de ejecutar la ROM, cotejado con openMSX punto a punto; la partida en GIF, jugada en openMSX; las ocho "
              "m&uacute;sicas, de su propio motor, id&eacute;nticas a openMSX cuadro a cuadro.",
        ficha=["Casio - <b>(c) 1987</b>",
               "Cartucho de <b>32 KB</b> (cabecera en 0x4000)",
               "<b>MSX</b>", "Volcado <b>02a2fafc...</b>"],
        aviso="<b>Aqu&iacute; no hay capturas del juego.</b> El t&iacute;tulo sale de ejecutar la ROM y los GIF son "
              "la ROM <b>funcionando en openMSX</b>: en cada cuadro se apuntan la VRAM, la RAM y los registros del "
              "VDP, y <b>c&oacute;digo nuestro los pinta</b>.",
    ),
    "en": dict(
        titulo="Issun-boushi no Donnamondai - commented disassembly",
        claim="Issun-b&#333;shi, the one-inch boy of the tale, goes up the river in his bowl: he dodges logs, "
              "skewers fish, birds and whatever comes out of the bank, picks up what they leave and, once ashore, "
              "takes on the oni of each scene. Five scenes and an ending. The title comes from running the ROM, "
              "checked against openMSX point by point; the game in GIF, played in openMSX; the eight tunes, from its "
              "own engine, identical to openMSX frame by frame.",
        ficha=["Casio - <b>(c) 1987</b>",
               "<b>32 KB</b> cartridge (header at 0x4000)",
               "<b>MSX</b>", "Dump <b>02a2fafc...</b>"],
        aviso="<b>There are no screenshots of the game here.</b> The title comes from running the ROM and the GIFs "
              "are the ROM <b>running in openMSX</b>: on every frame the VRAM, the RAM and the VDP registers are "
              "logged, and <b>our own code paints them</b>.",
    ),
}

PAGINAS = [
    [("THE-GAME.html", "LA-PARTIDA.html", "The game", "La partida",
      "the CASIO intro, the title, the controls, the river and what comes down it, the bars, the falls and GAME OVER",
      "la presentaci&oacute;n de CASIO, el t&iacute;tulo, los mandos, el r&iacute;o y lo que baja por &eacute;l, "
      "las barras, las ca&iacute;das y GAME OVER"),
     ("THE-SCENES.html", "LAS-ESCENAS.html", "The scenes", "Las escenas",
      "the five scenes: the river, the bank, the oni on land and the ending",
      "las cinco escenas: el r&iacute;o, la orilla, el oni en tierra y el final"),
     ("THE-MUSIC.html", "LA-MUSICA.html", "The music", "La m&uacute;sica",
      "the eight tunes, from its own sound engine and checked against openMSX",
      "las ocho m&uacute;sicas, de su propio motor de sonido y cotejadas con openMSX")],
    [("CURIOSITIES.html", "CURIOSIDADES.html", "Curiosities", "Curiosidades",
      "TAB and CAPS on the title, a demo that plays the cartridge header, shared bytes, leftovers",
      "TAB y CAPS en el t&iacute;tulo, una demostraci&oacute;n que juega la cabecera del cartucho, bytes "
      "compartidos, sobrantes")],
    [("UNDER-THE-HOOD.html", "POR-DENTRO.html", "Under the hood", "Por dentro",
      "rebuilding the ROM, the cartridge, the BIOS it uses, the loop, the river map, the sprites, the RAM and the tools",
      "rehacer la ROM, el cartucho, la BIOS que usa, el bucle, el mapa del r&iacute;o, los sprites, la RAM y las "
      "herramientas")],
]

# Repositorio nuevo: no hay paginas viejas que redirigir.
VIEJAS = {}

LOGOTIPO = "logotipo.png"
