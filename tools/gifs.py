"""Los GIF de la web: tramos de las grabaciones de openMSX (tools/guiones/*.tcl, grabados con
tools/lanza_graba.ps1 en C-BIOS_MSX1_JP), pintados con tools/vdp.py; cada imagen dura el tiempo emulado que dura en
la grabacion.

Los tramos salen de la RAM grabada (work/resumen.py): 0xE000 jugando, 0xE003 la escena, 0xE051 la parte (0 rio,
1 llegando a la orilla, 2 en tierra), 0xE183 la muerte, 0xE184 la escena acabada, 0xE004 la segunda vuelta.

  atraccion   sin tocar nada: la presentacion de CASIO, el titulo y la demostracion (la escena 2)
  partida     el piloto (tools/guiones/piloto.tcl): la escena 1 en el rio, tres caidas y GAME OVER
  forzada     FORZADA con pokes (CAPS, la barra del protagonista llena, el rio acortado, la barra del jefe casi
              vacia): las cinco escenas, sus jefes y el final

Las grabaciones son grandes: cada una se lee UNA vez.

Uso: gifs.py docs/imagenes
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import vdp          # noqa: E402

# (fichero, grabacion, desde, hasta, cada)
TRAMOS = [
    ("presentacion.gif", "atraccion", 131, 340, 3),     # la presentacion de CASIO
    ("demostracion.gif", "atraccion", 1893, 3000, 3),   # la demostracion (la escena 2)
    ("salida.gif", "partida", 400, 1300, 3),            # la escena 1 empieza, en el rio
    ("game_over.gif", "partida", 4820, 5460, 3),        # la ultima caida y GAME OVER
    ("orilla.gif", "forzada", 1600, 1960, 2),           # FORZADA (el rio acortado): la orilla y a tierra
    ("jefe_1.gif", "forzada", 2500, 3420, 3),           # FORZADA: el jefe de la escena 1, vencido
    ("rio_2.gif", "forzada", 3420, 4320, 3),            # FORZADA: el rio de la escena 2
    ("jefe_2.gif", "forzada", 8400, 9320, 3),           # FORZADA: el jefe de la escena 2
    ("rio_3.gif", "forzada", 9370, 10270, 3),           # FORZADA: el rio de la escena 3
    ("jefe_3.gif", "forzada", 11550, 12460, 3),         # FORZADA: el jefe de la escena 3
    ("rio_4.gif", "forzada", 12470, 13370, 3),          # FORZADA: el rio de la escena 4
    ("jefe_4.gif", "forzada", 15130, 16040, 3),         # FORZADA: el jefe de la escena 4
    ("jefe_5.gif", "forzada", 17290, 18200, 3),         # FORZADA: la escena 5, toda en tierra, y su jefe
    ("final.gif", "forzada", 18190, 18650, 2),          # FORZADA: el final
]


def main(salida):
    raiz = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    for grab in dict.fromkeys(t[1] for t in TRAMOS):
        mios = [t for t in TRAMOS if t[1] == grab]
        gifs = {t[0]: vdp.Gif() for t in mios}
        tope = max(t[3] for t in mios) + max(t[4] for t in mios)
        espera = {}                                    # fichero -> (imagen, t) pendiente de su duracion
        for n, c in enumerate(vdp.cuadros(os.path.join(raiz, "work", grab + ".bin"))):
            if n > tope:
                break
            for fichero, _, desde, hasta, cada in mios:
                if desde <= n <= hasta + cada and (n - desde) % cada == 0:
                    if fichero in espera:
                        im, t = espera.pop(fichero)
                        gifs[fichero].pon(im, (c["t"] - t) * 1000.0 / gifs[fichero].ms)
                    if n <= hasta:
                        espera[fichero] = (vdp.imagen(c["vram"], c["regs"], 1), c["t"])
        for fichero, _, desde, hasta, cada in mios:
            if fichero in espera:                       # la grabacion acaba antes: la ultima, un paso
                im, _t = espera.pop(fichero)
                gifs[fichero].pon(im, cada)
            ruta = os.path.join(salida, fichero)
            gifs[fichero].guarda(ruta, 4000)
            print("%-24s %4d imagenes, %8d bytes" % (fichero, len(gifs[fichero]), os.path.getsize(ruta)))


if __name__ == "__main__":
    main(sys.argv[1])
