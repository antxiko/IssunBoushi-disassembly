# Los textos

Todos los textos del cartucho están en un solo bloque (`textos`, 0x8D5A-0x8E15). Las letras y las cifras son las
del propio cartucho (`letras_dibujos`, 0x4B80): las cifras en las casillas 0-9, el espacio en la 0x10 y las letras
desde la 0x11 (A). El nombre, CASIO y los rótulos son casillas dibujadas.

| dirección | texto | dónde sale | traducción |
|---|---|---|---|
| 0x8D5B / 0x8D64 | CASIO (dos filas de casillas grandes) | la presentación (`presentacion`, 0x8C28) | |
| 0x8E0E | SOFTWARE (casillas 0x80-0x86) | la presentación, debajo de CASIO (0x8C70) | |
| 0x8D6D | 一寸法師 の どんなもんだい (64 casillas) | el título (`titulo_nombre`, 0x8BDF) | «Issun-bōshi: ¿qué te parece?» |
| 0x8D95 | どんなもんだい | el final, en grande (0x84A9) | «¿qué te parece?», «¡toma ya!» |
| 0x8DB7 | CASIO (casillas 0x8A-0x8F) | el título, fila 4 | |
| 0x8DAD | GAME START | el título, fila 18 (0x80AC) | empezar la partida |
| 0x8DBD | PUSH TRIG:1 OR SPACE | el título, fila 20 | pulsa el botón 1 o la barra |
| 0x8DD1 | COPYRIGHT 1987 © CASIO | el título, fila 16 | |
| 0x8DE7 | HISCORE: | el marcador (0x8611) | el récord |
| 0x8DEF | (dibujo de las vidas) = | la barra de la fila 22 (`barra_arriba`, 0x8697) | las vidas que quedan |
| 0x8DF2 | (dibujo de la escena) = | la barra de la fila 23 (`barra_abajo`, 0x86B6) | la escena |
| 0x8DF5 | GAME OVER | sin vidas (0x8326) | fin de la partida |
| 0x8DFE | dieciséis espacios | borra las filas de la presentación (0x8CBE) | |

Issun-bōshi (一寸法師, «el niño de una pulgada») es el protagonista del cuento japonés; どんなもんだい es una
exclamación de orgullo, «¿qué te parece?». Todos los textos se usan: cada uno tiene su `ld hl` en el código.
