# Curiosidades

## TAB y CAPS

Al acabar la presentaci&oacute;n de CASIO el juego mira dos teclas (0x8066): con **TAB** pulsada, 0xE03A = 2 y el
protagonista no muere nunca (la muerte, 0x8282, se anula al momento: ni la barra vac&iacute;a ni los troncos); con
**CAPS**, 0xE039 = 2 y, cuando se acaban las vidas, vuelven a ser dos (0x830B). La demostraci&oacute;n las borra.

## La demostraci&oacute;n juega el cartucho

Los mandos de la demostraci&oacute;n se leen de una lista, un byte cada 16 cuadros (la mitad baja es la palanca, la
alta los botones), que empieza en **0x4000** (0x80DA): la cabecera del cartucho ("AB", INIT...) y el c&oacute;digo de
INIT. No hay lista hecha a prop&oacute;sito.

## Bytes que sirven para dos cosas

- Los colores del t&iacute;tulo (0x5800, 0x300 bytes) acaban en 0x5A00, que son tambi&eacute;n los dibujos de los
  sprites de la pausa: los colores de las casillas 0x70-0x8F salen de ah&iacute; y el juego los pinta despu&eacute;s
  de blanco (0x88CD).
- Los cuatro pasos del agua est&aacute;n guardados en las mismas casillas del juego (0x90-0x9F y 0xA0-0xAF, en
  0x5600-0x56FF): las que se ven y las que esperan su turno.
- Los sprites que miran hacia el otro lado no est&aacute;n en la ROM: en tierra, el juego da la vuelta a los 26
  primeros, byte a byte, y los pone en los dibujos 0x80-0xE7 (`sprites_vuelve`, 0x85C1).

## El oni, dos veces por cuadro

La rutina del oni (`objeto_tierra`, 0x9448) la llama el bucle de la partida (0x81D0) y, adem&aacute;s, la de los enemigos al
acabar (`enemigos`, 0x9469, con un salto): corre dos veces en cada cuadro. Su cuenta sube de dos en dos en las
grabaciones, as&iacute; que piensa, se mueve y mira los choques al doble de lo que dicen sus n&uacute;meros.

## La m&uacute;sica 5

La tabla de m&uacute;sicas tiene siete (0-6) y ninguna instrucci&oacute;n pide la 5: `musica_pide` se llama con la 1,
2, 3, 4 y 6, y 0xE2BE solo lo escribe ella; en las grabaciones no suena nunca.

## Sobrantes

- **C&oacute;digo que nadie llama**: en 0x8712, una rutina que llena la barra del protagonista un octavo cada dos
  llamadas; en 0x8744, otra que llena la del oni; en 0x8528, `cerca_y2`, la comprobaci&oacute;n de choque con el arma
  en Y (la de X s&iacute; se usa); y 3 bytes en 0x9445 y 2 en 0x9E54, que un salto pasa por encima.
- **Un dibujo** de tierra (0x431A, 8 x 1 casillas) que ninguna lista usa.
- En el final, el cuarto sprite de la figura que llega recibe su dibujo (0x30) en el byte del color (0x83C9), que
  despu&eacute;s se pisa; su dibujo se queda en 0.
- Las rutinas que piden los efectos (0xB2E0 y 0xB2EB) miran si se est&aacute; jugando y no hacen nada con ello.
