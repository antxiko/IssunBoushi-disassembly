"""Los mapas de las cinco escenas de Issun-boushi, PINTADOS EJECUTANDO LA ROM, sobre la RAM y la VRAM de un cuadro
grabado de cada escena (work/forzada.bin y partida.bin):

  - el rio: rio_decorado (0x90F1, hasta 0x9174) monta el mapa en la RAM (0xE600: 14 filas de 192 casillas, filas de
    0xC0; las columnas 0-0x3F copiadas en 0x40-0x7F) y pinta el agua (filas 14-21); rio_pinta (0x9262) ensena 32 columnas desde el avance (0xE190, de 0 a 0x7F) y CADA FILA AL
    REVES (la columna 0 de la pantalla es la 31 del tramo): aqui, las 160 columnas que se llegan a ver, en el mismo
    orden que en la pantalla (el principio del rio a la derecha);
  - la tierra: decorado_dibujos, tierra_decorado y decorado_pinta (0x920F-0x9218), como al llegar a la orilla.

Sin marcador ni sprites. La escena 5 no tiene rio.

Cotejo: en los cuadros grabados del rio (0xE051 = 0), las filas 0-13 de la tabla de nombres contra el tramo del mapa
montado aqui desde su avance, al reves; en los de tierra (0xE051 = 2), las filas 0-21 contra la tierra montada.

Uso: mapas.py docs/imagenes
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, AQUI)
import vdp                  # noqa: E402
from bios import Msx        # noqa: E402
from PIL import Image       # noqa: E402

RAIZ = os.path.dirname(AQUI)
ROM = open(os.path.join(RAIZ, "issun.rom"), "rb").read()
VISTAS = 0x7F + 32          # las columnas que se llegan a ver


def maquina(c):
    m = Msx(ROM, 0x4000)
    m.mem[0xE000:0xF000] = c["ram"]
    m.vdp.vram[:] = c["vram"]
    return m


def rio(c):
    m = maquina(c)
    m.sp = 0xF380
    m.hasta(0x90F1, 0x9174)             # hasta antes de agua_dibuja y rio_pinta, con el mapa ya montado
    mapa = [bytes(m.mem[0xE600 + 0xC0 * f:0xE600 + 0xC0 * f + 0xC0]) for f in range(14)]
    return mapa, bytes(m.vdp.vram)


def tramo(mapa, avance):
    """Lo que ensena rio_pinta: 32 columnas desde el avance, cada fila al reves."""
    return b"".join(bytes(reversed(mapa[f][avance:avance + 32])) for f in range(14))


def tierra(c):
    m = maquina(c)
    m.mem[0xE051] = 2
    m.sp = 0xF380
    m.hasta(0x920F, 0x9218)
    return bytes(m.vdp.vram)


def pinta(vram, regs, filas, desde=0):
    v = bytearray(vram)
    for f, fila in enumerate(filas):
        v[0x1800 + 32 * (desde + f):0x1800 + 32 * (desde + f) + 32] = fila
    return vdp.imagen(bytes(v), regs, 1, con_sprites=False)


def main(salida):
    cuadro_rio, cuadro_tierra = {}, {}
    grab_rio, grab_tierra = {}, {}
    for g in ("forzada", "partida"):
        for c in vdp.cuadros(os.path.join(RAIZ, "work", g + ".bin")):
            r = c["ram"]
            if not (r[0x000] and c["regs"][1] & 0x40) or r[0x003] > 4:
                continue
            e = r[0x003]
            if r[0x051] == 0 and e < 4:          # la escena 5 no tiene rio (0xE051 a 0 sin rio)
                cuadro_rio.setdefault(e, []).append(c) if len(cuadro_rio.get(e, [])) < 300 else None
                grab_rio.setdefault(e, []).append((r[0x190], c["vram"][0x1800:0x1800 + 14 * 32]))
            elif r[0x051] == 2:
                cuadro_tierra.setdefault(e, []).append(c) if len(cuadro_tierra.get(e, [])) < 300 else None
                grab_tierra.setdefault(e, []).append(c["vram"][0x1800:0x1800 + 22 * 32])
    tiras = []
    for e in range(5):
        partes = []
        if e in cuadro_rio:
            c = cuadro_rio[e][len(cuadro_rio[e]) // 2]     # uno del medio: los primeros son del cambio, con la VRAM de antes
            mapa, vram = rio(c)
            agua = [vram[0x1800 + 32 * f:0x1800 + 32 * f + 32] for f in range(14, 22)]
            im = Image.new("RGB", (8 * VISTAS, 176))
            for k in range(0, VISTAS, 32):
                ancho = min(32, VISTAS - k)
                # la columna j de la imagen es la VISTAS-1-j del mapa (al reves, como en la pantalla)
                filas = [bytes(reversed(mapa[f][VISTAS - k - ancho:VISTAS - k])) + bytes(32 - ancho) for f in range(14)]
                pant = pinta(vram, c["regs"], filas + agua)
                im.paste(pant.crop((0, 0, 8 * ancho, 176)), (8 * k, 0))
            partes.append(im)
            ds = [sum(1 for a, b in zip(tramo(mapa, av), g) if a != b) for av, g in grab_rio.get(e, [])[::3]]
            ds.sort()
            print("escena %d, rio: %d cuadros cotejados, %d iguales, mediana %s" % (
                e + 1, len(ds), ds.count(0), ds[len(ds) // 2] if ds else "-"))
        if e in cuadro_tierra:
            c = cuadro_tierra[e][len(cuadro_tierra[e]) // 2]
            vram = tierra(c)
            nombres = vram[0x1800:0x1800 + 22 * 32]
            partes.append(pinta(vram, c["regs"], []).crop((0, 0, 256, 176)))
            ds = sorted(sum(1 for a, b in zip(nombres, g) if a != b) for g in grab_tierra[e][::3])
            print("escena %d, tierra: %d cuadros cotejados, %d iguales, mediana %d" % (
                e + 1, len(ds), ds.count(0), ds[len(ds) // 2]))
        ancho = sum(p.size[0] for p in partes) + 8 * (len(partes) - 1)
        t = Image.new("RGB", (ancho, 176), (0, 0, 0))
        x = 0
        for p in partes:
            t.paste(p, (x, 0))
            x += p.size[0] + 8
        tiras.append(t)
    hoja = Image.new("RGB", (max(t.size[0] for t in tiras), 5 * 176 + 4 * 8), (0, 0, 0))
    for i, t in enumerate(tiras):
        hoja.paste(t, (0, i * 184))
    hoja = hoja.resize((hoja.size[0] // 2, hoja.size[1] // 2), Image.NEAREST)
    ruta = os.path.join(salida, "mapas.png")
    hoja.save(ruta, optimize=True)
    print(ruta, hoja.size)


if __name__ == "__main__":
    main(sys.argv[1])
