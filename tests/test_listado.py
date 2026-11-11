"""Lo que se afirma de la ROM, comprobado contra sus bytes.

Corre con la ROM delante y sin ella: cuando no esta, la imagen se rehace desde
las filas defb/defw del listado, que si viaja con el repositorio. Sin la ROM
solo se comprueba lo que cae en datos.
"""

import os
import re
import subprocess
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(RAIZ, "tools"))

ROM = os.path.join(RAIZ, "issun.rom")
ASM = os.path.join(RAIZ, "src", "issun.asm")
NOTAS = os.path.join(RAIZ, "src", "issun.notes")
ORG = 0x4000
TAM = 32768

FILA = re.compile(r"^\s+def(b|w)\s+([0-9a-fA-F,h ]+)\s*;\s*([0-9a-f]{4})")


def imagen_desde_el_listado():
    img = bytearray(TAM)
    with open(ASM, encoding="utf-8") as f:
        for ln in f:
            m = FILA.match(ln)
            if not m:
                continue
            ancho, cuerpo, dirr = m.group(1), m.group(2), int(m.group(3), 16)
            p = dirr - ORG
            for tok in cuerpo.split(","):
                tok = tok.strip().rstrip("h")
                if not tok:
                    continue
                v = int(tok, 16)
                if ancho == "b":
                    img[p] = v
                    p += 1
                else:
                    img[p] = v & 0xFF
                    img[p + 1] = v >> 8
                    p += 2
    return bytes(img)


def lee():
    if os.path.exists(ROM):
        with open(ROM, "rb") as f:
            return f.read()
    return imagen_desde_el_listado()


def b(a):
    return lee()[a - ORG]


def w(a):
    rom = lee()
    return rom[a - ORG] | (rom[a - ORG + 1] << 8)


def instruccion(dirr):
    """La instruccion del listado en esa direccion (sin el comentario)."""
    with open(ASM, encoding="utf-8") as f:
        for ln in f:
            m = re.match(r"^	(\S.*?)\s*;([0-9a-f]{4})", ln)
            if m and int(m.group(2), 16) == dirr:
                return m.group(1).replace("	", " ").strip()


def texto(a, n):
    """Casilla 0x10 = espacio, 0x11 = A..., 0-9 las cifras."""
    out = ""
    for c in lee()[a - ORG:a - ORG + n]:
        if c == 0x10:
            out += " "
        elif c <= 9:
            out += chr(0x30 + c)
        elif 0x11 <= c <= 0x2A:
            out += chr(0x40 + c - 0x10)
        elif c == 0x0A:
            out += ":"
        else:
            out += "?"
    return out


class Cabecera(unittest.TestCase):
    def test_ab_e_init_en_0x4010(self):
        rom = lee()
        self.assertEqual(rom[:2], b"AB")
        self.assertEqual(w(0x4002), 0x4010)

    def test_son_32_kb(self):
        self.assertEqual(len(lee()), TAM)

    def test_init_salta_a_la_pagina_2(self):
        self.assertEqual(instruccion(0x4035), "jp arranque_nop")


class LaInterrupcion(unittest.TestCase):
    def test_va_por_h_timi(self):
        self.assertEqual([instruccion(a) for a in (0x8024, 0x8027, 0x802C)],
                         ["ld hl,08a26h", "ld (0fda0h),hl", "ld (0fd9fh),a"])


class LosTextos(unittest.TestCase):
    def test_el_titulo(self):
        self.assertEqual(texto(0x8DBD, 20), "PUSH TRIG:1 OR SPACE")
        self.assertEqual(texto(0x8DAD, 10), "GAME START")
        self.assertEqual(texto(0x8DF5, 9), "GAME OVER")
        self.assertEqual(texto(0x8DE7, 7), "HISCORE")

    def test_el_final_repite_el_nombre(self):
        self.assertEqual(lee()[0x8D95 - ORG:0x8DAD - ORG], lee()[0x8D6D + 40 - ORG:0x8D6D + 64 - ORG])


class LaPartida(unittest.TestCase):
    def test_tab_y_caps(self):
        self.assertEqual([instruccion(a) for a in (0x806B, 0x8071, 0x8079, 0x807F)],
                         ["bit 3,a", "ld (0e03ah),a", "bit 3,a", "ld (0e039h),a"])

    def test_la_demostracion_lee_el_cartucho(self):
        self.assertEqual([instruccion(a) for a in (0x80DA, 0x80DD)], ["ld hl,04000h", "ld (0e037h),hl"])

    def test_cuatro_rios_y_cinco_tierras(self):
        self.assertTrue(all(0x4468 <= w(0x4460 + 2 * k) < 0x4860 for k in range(4)))
        self.assertTrue(all(0x4042 <= w(0x4038 + 2 * k) < 0x41D6 for k in range(5)))

    def test_el_record_empieza_en_10000(self):
        self.assertEqual([instruccion(a) for a in (0x8051, 0x8053)], ["ld a,010h", "ld (0e035h),a"])


class Tablas(unittest.TestCase):
    def test_los_tipos(self):
        t = [w(0x947F + 2 * k) for k in range(16)]
        self.assertEqual(t[1], 0x956B)
        self.assertEqual(t[7], 0x9898)
        self.assertEqual(t[6], 0x94FE)


class Sonido(unittest.TestCase):
    def test_siete_musicas(self):
        for k in range(1, 7):
            for j in range(3):
                self.assertTrue(0xB6BC <= w(0xB280 + 6 * k + 2 * j) < 0xC000)


class ElListado(unittest.TestCase):
    def test_densidad_y_flojas(self):
        salida = subprocess.run(
            [sys.executable, os.path.join(RAIZ, "tools", "densidad.py"), ASM],
            capture_output=True, text=True, check=True).stdout
        m = re.search(r"(\d+) instrucciones, (\d+) comentarios", salida)
        self.assertGreaterEqual(int(m.group(2)) * 100, 40 * int(m.group(1)))
        self.assertIn("---- 0 rutinas por debajo del 10 %", salida)

    def test_ningun_call_sin_nombre(self):
        salida = subprocess.run(
            [sys.executable, os.path.join(RAIZ, "tools", "sin_bautizar.py"), ASM],
            capture_output=True, text=True, check=True).stdout
        self.assertTrue(salida.startswith("0 rutinas sin bautizar"), salida[:200])

    def test_cada_comentario_en_su_instruccion(self):
        salida = subprocess.run(
            [sys.executable, os.path.join(RAIZ, "tools", "valida_c.py"), ASM, NOTAS],
            capture_output=True, text=True, check=True).stdout
        self.assertIn("0 fuera de sitio, 0 repetidos", salida)


if __name__ == "__main__":
    unittest.main()
