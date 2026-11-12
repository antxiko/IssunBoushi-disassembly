#!/usr/bin/env python3
"""Los sprites de Issun-boushi no Donnamondai MONTADOS DESDE LA ROM (ninguna imagen es una captura).

Los dibujos: los 0x800 bytes de 0xAA80 que `sprites_dibujos` pone en 0x3800 y, encima de los 0x80-0xE7, su copia
mirando al otro lado (`sprites_vuelve`, 0x85C1: los 0x340 primeros bytes con cada byte del reves y las dos mitades
cambiadas en los 25 primeros dibujos; el 26, solo del reves). Sprites de 16 x 16. Cada cosa son sprites de 16 bytes
desde 0xE300 (los 4 primeros, sus atributos): el cuenco en 0xE310, el protagonista en 0xE320 y 0xE330, el arma en 0xE340
y los enemigos desde 0xE380 (+4 el tipo, por la tabla 0x947F; su segundo sprite, el hueco siguiente con el tipo 15).

  protagonista.png   el protagonista, dos sprites en el mismo sitio: el paso (+0x0C) + el lado (+0x0D, 0 u 0x80) en azul
                     claro (en el rio, negro) y el + 4 en amarillo claro (`prota_dibujo`, 0x8FAB); en el rio, su cuenco
                     (`prota_sprites` 0x8F7E: 0x80 o 0x84 cada 16 cuadros, negro, 11 puntos por debajo y uno a la
                     izquierda); y el arma (0x18, blanco)
  enemigos.png       los peces (`pez`: 0x88 y 0x98), el verde de la orilla (`verde`: 0xC8), el pajaro (`pajaro`: 0xD8,
                     y en las escenas impares 0xB8 y 0xA8), lo que se recoge (`cosa`: 0x78 y 0x7C), el tronco (`tronco`:
                     0x60), lo que cae del cielo (`cae_del_cielo`: 0x70), los tiros del jefe (`tiro_jefe`: 0x74;
                     `tiro_jefe2`: 0x68 y 0x6C), el jefe vencido en pequeno (`jefe_se_va`: 0xF0-0xFC) y el tocado
                     (`enemigo_tocado`: 0x74 en rojo y amarillo oscuro)
  andar_cuadros.gif  el protagonista en el rio con su cuenco y los peces, al ritmo del juego

Uso: hojas.py docs/imagenes | hojas.py cotejo
"""
import os
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))
import vdp          # noqa: E402

ORG = 0x4000
ROM = open(os.path.join(RAIZ, "issun.rom"), "rb").read()
FONDO = (64, 104, 160)
# (tipos, dibujos, color del primero, color del segundo (+4, el hueco siguiente))
ENEMIGOS = [((1,), (0x88, 0x90), 6, 15), ((2,), (0x98, 0xA0), 1, 15), ((3,), (0xC8, 0xD0), 12, 3),
            ((3,), (0xA8, 0xB0), 9, 15), ((4,), (0xD8, 0xE0), 7, 1), ((4,), (0xB8, 0xC0), 9, 14),
            ((4,), (0xA8, 0xB0), 13, 15), ((5, 8), (0x78,), 11, 9), ((7,), (0x60,), 6, 11), ((9,), (0x70,), 9, 9),
            ((11,), (0x74,), 9, 9), ((11,), (0x74,), 11, 11), ((12,), (0x68, 0x6C), 6, 6), ((6,), (0xF0, 0xF8), 5, 5)]
FINAL = [(0, 0, 0x24, 9), (0, 16, 0x28, 11), (16, 0, 0x2C, 9), (16, 16, 0x30, 11)]   # escena_acabada, 0x83A4


def b(a):
    return ROM[a - ORG]


def al_reves(v):
    return int("{:08b}".format(v)[::-1], 2)


def patrones():
    """sprites_dibujos y sprites_vuelve (0x85C1)."""
    t = bytearray(ROM[0xAA80 - ORG:0xAA80 - ORG + 0x800])
    m = bytearray(al_reves(x) for x in ROM[0xAA80 - ORG:0xAA80 - ORG + 0x340])
    for k in range(25):
        a = 32 * k
        m[a:a + 16], m[a + 16:a + 32] = m[a + 16:a + 32], m[a:a + 16]
    t[0x400:0x740] = m
    return bytes(t)


def rio():
    """En el rio la tabla es la de sprites_dibujos tal cual (0x8584), sin la copia vuelta."""
    return ROM[0xAA80 - ORG:0xAA80 - ORG + 0x800]


def pinta(im, pat, n, x, y, color, escala=1):
    if color & 15 == 0:
        return
    n &= 0xFC
    d = pat[n * 8:n * 8 + 32]
    c = vdp.PALETA[color & 15]
    for fila in range(16):
        for col in range(16):
            if (d[fila + (16 if col >= 8 else 0)] >> (7 - (col & 7))) & 1:
                for ey in range(escala):
                    for ex in range(escala):
                        px, py = (x + col) * escala + ex, (y + fila) * escala + ey
                        if 0 <= px < im.width and 0 <= py < im.height:
                            im.putpixel((px, py), c)


def prota(im, pat, d, x, y, E, color=5, cuenco=None):
    if cuenco is not None:
        pinta(im, pat, cuenco, x - 1, y + 11, 1, E)
    pinta(im, pat, d + 4, x, y, 11, E)
    pinta(im, pat, d, x, y, color, E)


def hoja(Image):
    pat, E = patrones(), 4
    im = Image.new("RGB", (8 * 20 * E, 2 * 32 * E), FONDO)
    for k, d in enumerate((0x00, 0x08, 0x10, 0x80, 0x88, 0x90)):     # en tierra: + 0x80, la copia vuelta
        prota(im, pat, d, 3 + 20 * k, 4, E)
    for k, (d, cu) in enumerate(((0x00, 0x80), (0x08, 0x84))):        # en el rio, con su cuenco
        prota(im, rio(), d, 3 + 20 * k, 32, E, 1, cu)
    pinta(im, pat, 0x18, 3 + 20 * 3, 32, 15, E)
    return im


def hoja_enemigos(Image):
    pat, E = rio(), 3
    im = Image.new("RGB", (4 * 44 * E + 20 * E, 4 * 22 * E + 12 * E), FONDO)
    for k, (_, ds, c1, c2) in enumerate(ENEMIGOS):
        x, y = 2 + 44 * (k % 4), 2 + 22 * (k // 4)
        for j, d in enumerate(ds):
            pinta(im, pat, d + 4, x + 20 * j, y, c2, E)
            pinta(im, pat, d, x + 20 * j, y, c1, E)
    for k, c in enumerate((8, 10)):
        pinta(im, pat, 0x74, 2 + 44 * 2 + 20 * k, 2 + 22 * 3, c, E)
    for dy, dx, d, c in FINAL:
        pinta(im, pat, d, 2 + 44 * 3 + dx, 2 + 22 * 3 - 12 + dy, c, E)
    return im


def anima(Image):
    pat, E, cuadros = rio(), 4, []
    for n in range(64):
        im = Image.new("RGB", (3 * 20 * E, 32 * E), FONDO)
        prota(im, pat, 0x08 if n & 8 else 0x00, 3, 4, E, 1, 0x84 if n & 16 else 0x80)
        for k, (_, ds, c1, c2) in enumerate(ENEMIGOS[:2]):
            d = ds[(n // 8) % len(ds)]
            pinta(im, pat, d + 4, 22 + 20 * k, 8, c2, E)
            pinta(im, pat, d, 22 + 20 * k, 8, c1, E)
        cuadros.append(im)
    return cuadros


def guarda_gif(cuadros, ruta, ms=1000 / 60):
    imgs, durs = [], []
    for im in cuadros:
        if imgs and list(im.getdata()) == list(imgs[-1].getdata()):
            durs[-1] += ms
        else:
            imgs.append(im)
            durs.append(ms)
    imgs[0].save(ruta, save_all=True, append_images=imgs[1:], duration=[max(20, int(round(d))) for d in durs],
                 loop=0, disposal=1)


def cotejo():
    """Contra las grabaciones de openMSX (work/*.bin, la RAM 0xE000-0xEFFF):
    1) la tabla de dibujos de los sprites (VRAM 0x3800-0x3FFF): en tierra (0xE051 = 2) contra `patrones()`, con la
       copia vuelta; en el rio, contra los 0x800 bytes de 0xAA80 tal cual;
    2) el protagonista (0xE320 y 0xE330): en el mismo sitio, el paso + el lado y el + 4 en amarillo claro; el cuenco
       (0xE310), si esta, 0x80 u 0x84 en negro, 11 por debajo y uno a la izquierda;
    3) los enemigos (0xE380, 16 huecos): el dibujo de su tipo y su color, y su segundo sprite (el hueco siguiente,
       tipo 15) en el mismo sitio con el + 4."""
    pat = patrones()
    tipos = {}
    for ts, ds, c1, c2 in ENEMIGOS:
        for t in ts:
            tipos.setdefault(t, set()).update((d, c1) for d in ds)
    tot = dict(patrones_tierra=0, patrones_rio=0, pat_cambio=0, pat_carga=0, pat_mal=0, prota=0, prota_muerto=0, prota_sin_poner=0, prota_mal=0, cuenco=0, cuenco_mal=0,
               enemigos=0, enemigos_tocados=0, final=0, enemigos_mal=0)
    for grab in ("atraccion", "partida", "forzada", "mira"):
        ruta = os.path.join(RAIZ, "work", grab + ".bin")
        if not os.path.exists(ruta):
            continue
        try:
            cuadros = list(vdp.cuadros(ruta))
        except AssertionError:
            continue
        for c in cuadros:
            v, ram = c["vram"], c["ram"]
            t = v[0x3800:0x4000]
            if any(t):
                n = len(t.rstrip(bytes(1)))
                if t == pat and ram[0x051] == 2:
                    tot["patrones_tierra"] += 1         # en tierra (0xE051 = 2), con la copia vuelta (decorado_dibujos)
                elif t == ROM[0xAA80 - ORG:0xAA80 - ORG + 0x800] and ram[0x051] != 2:
                    tot["patrones_rio"] += 1            # en el rio, solo sprites_dibujos (0x8584): sin copia vuelta
                elif t in (pat, ROM[0xAA80 - ORG:0xAA80 - ORG + 0x800]):
                    tot["pat_cambio"] += 1              # la otra tabla: llegando a la orilla o saliendo de ella
                elif t[:n] == pat[:n] or t[0x40:] == pat[0x40:]:
                    tot["pat_carga"] += 1           # a medias, o con los 8 dibujos de la pausa (0x5A00)
                else:
                    tot["pat_mal"] += 1
            cu, a, s = ram[0x310:0x314], ram[0x320:0x324], ram[0x330:0x334]
            if a[0] < 0xC0:
                if a == bytes(4):
                    tot["prota_sin_poner"] += 1
                elif a[:2] == s[:2] and s[2] == (a[2] + 4) & 0xFF and s[3] & 15 == 11:
                    tot["prota"] += 1
                elif a[2] in (0xE8, 0xEC) and a[3] & 15 == 15:
                    tot["prota_muerto"] += 1        # `muerte`: cae dando vueltas
                else:
                    tot["prota_mal"] += 1
                if cu[3] & 15 == 1 and cu[0] < 0xC0:
                    ok = cu[2] in (0x80, 0x84) and (cu[1] - a[1]) & 0xFF == 0xFF
                    tot["cuenco"] += ok
                    tot["cuenco_mal"] += not ok
            for k in range(15):
                e = ram[0x380 + 16 * k:0x3A0 + 16 * k]
                if e[0] >= 0xC0 or e[4] not in tipos or e[3] & 15 == 0:
                    continue
                if e[2] == 0x74 and e[3] & 15 in (8, 10):
                    tot["enemigos_tocados"] += 1
                elif e[4] == 1 and (e[2], e[3] & 15) in {(d, c) for _, _, d, c in FINAL}:
                    tot["final"] += 1               # el personaje del final, 2 x 2 sprites (0x83A4)
                elif (e[2], e[3] & 15) in tipos[e[4]] or (e[2] & 0xF8 in {d for d, _ in tipos[e[4]]}):
                    tot["enemigos"] += 1
                else:
                    tot["enemigos_mal"] += 1
    return tot


def main(argv):
    if argv and argv[0] == "cotejo":
        print(cotejo())
        return 0
    from PIL import Image
    salida = argv[0]
    os.makedirs(salida, exist_ok=True)
    hoja(Image).save(os.path.join(salida, "protagonista.png"))
    hoja_enemigos(Image).save(os.path.join(salida, "enemigos.png"))
    guarda_gif(anima(Image), os.path.join(salida, "andar_cuadros.gif"))
    for f in ("protagonista.png", "enemigos.png", "andar_cuadros.gif"):
        print(f, os.path.getsize(os.path.join(salida, f)))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
