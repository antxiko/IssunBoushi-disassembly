; ==========================================================================
; Issun-boushi no Donnamondai - ROM de 32 KB en 0x4000
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; DATOS cabecera: La cabecera del cartucho: "AB", INIT 0x4010, sin STATEMENT,
;   DEVICE ni TEXT; la demostracion la lee como mandos (0xE037 = 0x4000)
;   0x4000..0x4010  (16 bytes)
DATA_cabecera:
	defb 041h,042h,010h,040h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4000  AB.@............

; ======================================================================
; CODIGO 0x4010..0x4038  (40 bytes)
; ======================================================================


init:		; INIT: sin interrupciones, la pantalla apagada, el slot del cartucho tambien en la pagina 2 (ENASLT) y al codigo de 0x8000
	di			;4010   ; sin interrupciones
	call 00041h		;4011   ; DISSCR
	call 00138h		;4014   ; RSLREG: los slots de las paginas
	rrca			;4017   ; el de la pagina 1 (bits 2-3)...
	rrca			;4018
	and 003h		;4019   ; ...sus dos bits
	ld c,a			;401b
	ld b,000h		;401c
	ld hl,0fcc1h		;401e   ; ...expandido? (EXPTBL, 0xFCC1)
	add hl,bc			;4021
	ld c,a			;4022
	ld a,(hl)			;4023
	and 080h		;4024   ; el bit de expandido
	or c			;4026
	ld c,a			;4027
	inc hl			;4028
	inc hl			;4029
	inc hl			;402a
	inc hl			;402b
	ld a,(hl)			;402c   ; el secundario (SLTTBL)
	and 00ch		;402d
	or c			;402f
	ld h,080h		;4030   ; la pagina 2
	call 00024h		;4032   ; ENASLT
	jp arranque_nop		;4035   ; al codigo

; ----------------------------------------------------------------------
; DATOS tierra_planos: Los decorados de tierra de las cinco escenas: un
;   puntero cada una (0x417C, 0x4132, 0x4066, 0x40D8 y 0x4042)
;   0x4038..0x4042  (10 bytes)
DATA_tierra_planos:
	defb 07ch,041h,032h,041h,066h,040h,0d8h,040h,042h,040h	; 4038  |A2Af@.@B@

; ----------------------------------------------------------------------
; DATOS tierra_listas: Cada decorado de tierra: rectangulos (fila, columna,
;   ancho, alto y casilla) hasta 0xFF y dibujos (fila, columna y direccion)
;   hasta 0xFF
;   0x4042..0x41d6  (404 bytes)
DATA_tierra_listas:
	defb 011h,000h,020h,001h,0b0h,012h,000h,020h,004h,0b1h,0ffh,000h,000h,05eh,043h,013h	; 4042  .. .... .....^C.
	defb 001h,0f6h,049h,013h,004h,0f6h,049h,013h,007h,0f6h,049h,013h,01ah,0eeh,049h,013h	; 4052  ..I...I...I...I.
	defb 01dh,0eeh,049h,0ffh,0ffh,002h,001h,0ceh,042h,001h,004h,0d5h,042h,004h,000h,006h	; 4062  ..I.....B...B...
	defb 043h,004h,002h,0f8h,042h,004h,005h,010h,043h,004h,007h,024h,043h,000h,008h,0d6h	; 4072  C...B...C..$C...
	defb 041h,004h,010h,006h,043h,004h,012h,0f8h,042h,004h,015h,006h,043h,004h,017h,010h	; 4082  A...C...B...C...
	defb 043h,004h,019h,024h,043h,004h,01ah,010h,043h,004h,01ch,0f8h,042h,004h,01fh,024h	; 4092  C..$C...C...B..$
	defb 043h,001h,011h,0bch,042h,001h,015h,0cah,042h,000h,016h,0c6h,042h,002h,01ah,0d5h	; 40a2  C...B...B...B...
	defb 042h,001h,01ch,0c6h,042h,011h,000h,052h,049h,011h,004h,052h,049h,011h,008h,052h	; 40b2  B...B..RI..RI..R
	defb 049h,011h,00ch,052h,049h,011h,010h,052h,049h,011h,014h,052h,049h,011h,018h,052h	; 40c2  I..RI..RI..RI..R
	defb 049h,011h,01ch,052h,049h,0ffh,0ffh,001h,000h,044h,043h,001h,004h,044h,043h,000h	; 40d2  I..RI....DC..DC.
	defb 008h,02ah,043h,001h,008h,02ah,043h,002h,008h,02ah,043h,003h,008h,02ah,043h,004h	; 40e2  .*C..*C..*C..*C.
	defb 008h,02ah,043h,005h,008h,02ah,043h,006h,008h,02ah,043h,007h,008h,037h,043h,001h	; 40f2  .*C..*C..*C..7C.
	defb 013h,044h,043h,001h,017h,044h,043h,001h,01ch,044h,043h,001h,01bh,044h,043h,011h	; 4102  .DC..DC..DC..DC.
	defb 000h,052h,049h,011h,004h,052h,049h,011h,008h,052h,049h,011h,00ch,052h,049h,011h	; 4112  .RI..RI..RI..RI.
	defb 010h,052h,049h,011h,014h,052h,049h,011h,018h,052h,049h,011h,01ch,052h,049h,0ffh	; 4122  .RI..RI..RI..RI.
	defb 0ffh,006h,000h,0f4h,042h,000h,001h,03ah,042h,000h,004h,0bch,042h,002h,006h,0d5h	; 4132  ....B..:B...B...
	defb 042h,003h,004h,086h,042h,000h,00ah,054h,042h,001h,010h,0c6h,042h,002h,011h,0cah	; 4142  B...B..TB...B...
	defb 042h,006h,010h,0eeh,042h,006h,012h,0f4h,042h,000h,013h,03ah,042h,006h,016h,0f4h	; 4152  B...B...B..:B...
	defb 042h,000h,017h,03ah,042h,000h,01ah,054h,042h,012h,000h,05eh,04ah,012h,008h,05eh	; 4162  B..:B..TB..^J..^
	defb 04ah,012h,010h,05eh,04ah,012h,018h,05eh,04ah,0ffh,0ffh,001h,000h,0c6h,042h,002h	; 4172  J..^J..^J.....B.
	defb 002h,0c6h,042h,004h,000h,0dah,042h,004h,002h,0e4h,042h,000h,004h,018h,042h,004h	; 4182  ..B...B...B...B.
	defb 008h,0dah,042h,002h,00ah,0c6h,042h,004h,00ah,0e4h,042h,000h,00ch,018h,042h,000h	; 4192  ..B...B...B...B.
	defb 010h,0c6h,042h,001h,011h,0c6h,042h,003h,010h,0a6h,042h,000h,014h,018h,042h,002h	; 41a2  ..B...B...B...B.
	defb 018h,0c6h,042h,003h,01ah,0c6h,042h,004h,018h,0dah,042h,004h,01ah,0e4h,042h,000h	; 41b2  ..B...B...B...B.
	defb 01ch,018h,042h,012h,000h,05eh,04ah,012h,008h,05eh,04ah,012h,018h,05eh,04ah,012h	; 41c2  ..B..^J..^J..^J.
	defb 010h,05eh,04ah,0ffh	; 41d2

; ----------------------------------------------------------------------
; DATOS tierra_dibujos: Los dibujos de tierra (ancho, alto y casillas); el de
;   0x431A (8 x 1, la casilla 0x97) no lo usa ninguna lista
;   0x41d6..0x4460  (650 bytes)
DATA_tierra_dibujos:
	defb 008h,008h,010h,0e1h,0e2h,010h,010h,0c1h,0c2h,010h,010h,0e5h,0e6h,010h,010h,0c5h	; 41d6  ................
	defb 0c6h,010h,010h,0e9h,0eah,0ebh,0c8h,0c9h,0cah,010h,0ech,0edh,0eeh,0efh,0cch,0cdh	; 41e6  ................
	defb 0ceh,010h,0f0h,0f1h,0f2h,0f3h,0d0h,0d1h,0d2h,0d3h,0f4h,0f5h,0f6h,0f7h,0d4h,0d5h	; 41f6  ................
	defb 0d6h,0d7h,0f8h,0f9h,0fah,0fbh,0d8h,0d9h,0dah,0dbh,0dfh,0dfh,0feh,0ffh,0dch,0ddh	; 4206  ................
	defb 0dfh,0dfh,004h,008h,0e3h,0e0h,0e8h,0e4h,010h,0fdh,0fch,010h,010h,0fdh,0fch,010h	; 4216  ................
	defb 010h,0fdh,0fch,010h,0a0h,0fdh,0fch,0a5h,0cfh,0fdh,0fch,0cfh,0cfh,0fdh,0fch,0cfh	; 4226  ................
	defb 0e7h,0e0h,0e8h,09fh,003h,008h,010h,084h,08dh,082h,084h,010h,085h,084h,010h,010h	; 4236  ................
	defb 084h,08dh,085h,084h,010h,010h,084h,010h,09bh,084h,099h,0deh,084h,0deh,006h,008h	; 4246  ................
	defb 010h,010h,08eh,08fh,010h,010h,0ach,0adh,08eh,08fh,088h,089h,010h,010h,08eh,08fh	; 4256  ................
	defb 08ch,08dh,080h,081h,08eh,08fh,010h,010h,010h,085h,08eh,08fh,088h,089h,010h,010h	; 4266  ................
	defb 08eh,08fh,08ch,010h,09ah,09bh,08eh,08fh,09ah,09bh,0deh,0deh,08eh,08fh,0deh,0deh	; 4276  ................
	defb 006h,005h,010h,0b0h,0b1h,0b2h,0b3h,010h,010h,0b4h,0b5h,0b6h,0b7h,092h,092h,0b8h	; 4286  ................
	defb 0b9h,0bah,0bbh,093h,093h,0bch,0bdh,0beh,0bfh,093h,093h,0deh,0deh,0deh,0deh,093h	; 4296  ................
	defb 004h,005h,010h,086h,087h,010h,0a0h,08ah,08bh,0a5h,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh	; 42a6  ................
	defb 0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,004h,002h,010h,0abh,010h,010h,0aeh,0afh,0a8h,0adh	; 42b6  ................
	defb 002h,001h,0a9h,0aah,002h,001h,0ach,0adh,005h,001h,0ach,0a8h,0a8h,0a8h,0adh,003h	; 42c6  ................
	defb 001h,0ach,0a8h,0adh,002h,004h,0a0h,0a1h,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,002h,004h	; 42d6  ................
	defb 0a2h,0a5h,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,002h,002h,098h,099h,09ch,0deh,001h,002h	; 42e6  ................
	defb 09ah,0deh,003h,004h,094h,095h,096h,093h,091h,090h,093h,091h,090h,093h,091h,090h	; 42f6  ................
	defb 002h,004h,092h,010h,093h,092h,093h,093h,093h,093h,002h,004h,010h,092h,010h,093h	; 4306  ................
	defb 092h,093h,093h,093h,008h,001h,097h,097h,097h,097h,097h,097h,097h,097h,001h,004h	; 4316  ................
	defb 092h,093h,093h,093h,00bh,001h,0c4h,0a4h,09dh,097h,097h,083h,097h,097h,0a7h,0a6h	; 4326  ................
	defb 0c4h,00bh,001h,0c4h,0a4h,010h,010h,010h,010h,010h,010h,010h,0a6h,0c4h,004h,006h	; 4336  ................
	defb 0c7h,0c7h,0c7h,0c7h,0cbh,0cbh,0cbh,0cbh,0c4h,0c4h,0c4h,0c4h,0c0h,0c3h,0c0h,0c3h	; 4346  ................
	defb 0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,0c4h,020h,008h,001h,001h,001h,07bh,079h,055h	; 4356  ........ ....{yU
	defb 001h,076h,075h,04eh,001h,06eh,001h,001h,001h,001h,001h,001h,001h,001h,0a3h,041h	; 4366  .vuN.n.........A
	defb 042h,043h,020h,001h,022h,023h,000h,001h,001h,001h,001h,001h,001h,058h,07ah,056h	; 4376  BC ."#.......XzV
	defb 054h,077h,010h,04fh,04dh,06fh,069h,065h,001h,001h,001h,001h,066h,067h,044h,045h	; 4386  Tw.OMoie....fgDE
	defb 046h,010h,024h,025h,026h,027h,004h,001h,001h,001h,001h,001h,001h,001h,001h,078h	; 4396  F.$%&'.........x
	defb 049h,049h,049h,059h,049h,04ch,068h,064h,001h,001h,001h,001h,06ah,06bh,048h,049h	; 43a6  IIIYILhd....jkHI
	defb 04ah,04bh,028h,029h,02ah,02bh,001h,001h,001h,001h,001h,001h,001h,001h,001h,001h	; 43b6  JK()*+..........
	defb 001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,06ch,06dh,001h,001h,001h,001h	; 43c6  ..........lm....
	defb 001h,001h,001h,001h,001h,001h,001h,001h,001h,001h,07ch,07dh,07eh,07fh,05ch,05dh	; 43d6  ..........|}~.\]
	defb 05eh,072h,070h,040h,071h,063h,062h,061h,060h,053h,070h,071h,071h,073h,050h,051h	; 43e6  ^rp@qcba`SpqqsPQ
	defb 052h,02ch,030h,031h,032h,033h,002h,011h,012h,013h,019h,01bh,01fh,074h,005h,006h	; 43f6  R,0123.......t..
	defb 00ch,057h,074h,00fh,00ch,003h,007h,00ch,037h,057h,074h,00fh,00ch,00dh,00eh,00ch	; 4406  .Wt.....7Wt.....
	defb 037h,02dh,034h,035h,036h,037h,014h,015h,016h,017h,001h,01ah,01fh,03eh,039h,03ah	; 4416  7-4567.......>9:
	defb 03bh,05bh,03eh,039h,009h,00ah,00bh,008h,03bh,05bh,03eh,039h,009h,00ah,00bh,008h	; 4426  ;[>9....;[>9....
	defb 03bh,02eh,038h,039h,03ah,03bh,018h,015h,01ah,001h,001h,047h,021h,05ah,03fh,03fh	; 4436  ;.89:;.....G!Z??
	defb 03fh,05fh,03dh,03fh,03fh,03fh,03fh,03fh,03fh,05fh,03dh,03fh,03fh,03fh,03fh,03fh	; 4446  ?_=??????_=?????
	defb 03fh,02fh,03ch,03fh,03fh,03fh,01ch,01dh,01eh,001h	; 4456  ?/<???....

; ----------------------------------------------------------------------
; DATOS rio_planos: Los mapas del rio de las escenas 0-3: un puntero cada una
;   (0x470F, 0x4468, 0x4539 y 0x4606)
;   0x4460..0x4468  (8 bytes)
DATA_rio_planos:
	defb 00fh,047h,068h,044h,039h,045h,006h,046h	; 4460  .GhD9E.F

; ----------------------------------------------------------------------
; DATOS rio_listas: Las listas de cada mapa del rio: fila, columna y direccion
;   del dibujo (84, 52, 51 y 66 dibujos), hasta 0xFF
;   0x4468..0x4860  (1016 bytes)
DATA_rio_listas:
	defb 00bh,000h,091h,04ah,00bh,005h,091h,04ah,00bh,00ah,091h,04ah,00bh,00fh,091h,04ah	; 4468  ...J...J...J...J
	defb 00bh,014h,09dh,04ah,00bh,017h,091h,04ah,00bh,020h,091h,04ah,00bh,025h,091h,04ah	; 4478  ...J...J. .J.%.J
	defb 00bh,02ah,091h,04ah,00bh,02fh,091h,04ah,00bh,034h,09dh,04ah,00bh,037h,091h,04ah	; 4488  .*.J./.J.4.J.7.J
	defb 00bh,050h,0e4h,049h,00bh,080h,091h,04ah,00bh,085h,091h,04ah,00bh,08ah,091h,04ah	; 4498  .P.I...J...J...J
	defb 00bh,08fh,091h,04ah,00bh,094h,09dh,04ah,00bh,097h,09dh,04ah,000h,000h,070h,049h	; 44a8  ...J...J...J..pI
	defb 000h,006h,0c8h,049h,000h,008h,0a2h,049h,000h,00eh,070h,049h,000h,014h,0c8h,049h	; 44b8  ...I...I..pI...I
	defb 000h,018h,0c8h,049h,000h,01ah,0a2h,049h,000h,022h,0c8h,049h,000h,024h,0a2h,049h	; 44c8  ...I...I.".I.$.I
	defb 000h,02ah,0c8h,049h,000h,02ch,070h,049h,000h,032h,0c8h,049h,000h,034h,070h,049h	; 44d8  .*.I.,pI.2.I.4pI
	defb 000h,03ch,0c8h,049h,000h,080h,070h,049h,000h,086h,070h,049h,000h,08ch,0c8h,049h	; 44e8  .<.I..pI..pI...I
	defb 000h,08eh,0a2h,049h,008h,009h,032h,04ah,009h,00ah,032h,04ah,008h,01dh,032h,04ah	; 44f8  ...I..2J..2J..2J
	defb 009h,01bh,08ch,04ah,00bh,01ch,0e4h,049h,007h,027h,088h,04ah,008h,025h,08ch,04ah	; 4508  ...J...I.'.J.%.J
	defb 009h,038h,088h,04ah,006h,08fh,032h,04ah,007h,090h,032h,04ah,000h,094h,0c8h,049h	; 4518  .8.J..2J..2J...I
	defb 000h,097h,0c8h,049h,007h,09ah,0feh,049h,004h,09ah,0feh,049h,000h,09ah,0feh,049h	; 4528  ...I...I...I...I
	defb 0ffh,000h,000h,030h,049h,000h,004h,0feh,048h,000h,00ah,0feh,048h,003h,010h,08ch	; 4538  ...0I...H...H...
	defb 04ah,001h,012h,068h,049h,005h,010h,056h,04ah,006h,012h,0f8h,048h,005h,014h,056h	; 4548  J..hI..VJ...H..V
	defb 04ah,000h,016h,030h,049h,000h,01ah,0feh,048h,000h,020h,0feh,048h,004h,026h,04ch	; 4558  J..0I...H. .H.&L
	defb 04ah,006h,028h,0f8h,048h,004h,02ah,04ch,04ah,002h,027h,088h,04ah,001h,028h,08ch	; 4568  J.(.H.*LJ.'.J.(.
	defb 04ah,000h,02ch,030h,049h,000h,030h,0feh,048h,006h,036h,091h,04ah,005h,03bh,056h	; 4578  J.,0I.0.H.6.J.;V
	defb 04ah,002h,039h,08ch,04ah,001h,03bh,08ch,04ah,004h,03ah,08ch,04ah,006h,03dh,09dh	; 4588  J.9.J.;.J.:.J.=.
	defb 04ah,004h,080h,04ch,04ah,002h,081h,088h,04ah,001h,083h,088h,04ah,005h,082h,056h	; 4598  J..LJ...J...J..V
	defb 04ah,006h,084h,09dh,04ah,004h,087h,04ch,04ah,000h,089h,0feh,048h,005h,08fh,056h	; 45a8  J...J..LJ...H..V
	defb 04ah,005h,091h,056h,04ah,003h,090h,08ch,04ah,001h,092h,068h,049h,004h,093h,0a5h	; 45b8  J..VJ...J..hI...
	defb 04ah,007h,09ah,0feh,049h,004h,09ah,0feh,049h,000h,09ah,0feh,049h,008h,000h,0ceh	; 45c8  J...I...I...I...
	defb 048h,008h,008h,0ceh,048h,008h,010h,0ceh,048h,008h,018h,0ceh,048h,008h,020h,0ceh	; 45d8  H...H...H...H. .
	defb 048h,008h,028h,0ceh,048h,008h,030h,0ceh,048h,008h,038h,0ceh,048h,008h,080h,0ceh	; 45e8  H.(.H.0.H.8.H...
	defb 048h,008h,088h,0ceh,048h,008h,08eh,0ceh,048h,008h,092h,0ceh,048h,0ffh,000h,000h	; 45f8  H...H...H...H...
	defb 096h,048h,000h,002h,072h,048h,000h,004h,072h,048h,000h,006h,072h,048h,000h,008h	; 4608  .H..rH..rH..rH..
	defb 084h,048h,000h,00ah,072h,048h,000h,00ch,096h,048h,000h,00eh,060h,048h,000h,010h	; 4618  .H..rH...H..`H..
	defb 084h,048h,000h,012h,084h,048h,000h,014h,072h,048h,000h,016h,060h,048h,000h,018h	; 4628  .H...H..rH..`H..
	defb 072h,048h,000h,01ah,060h,048h,000h,01ch,096h,048h,000h,01eh,084h,048h,000h,020h	; 4638  rH..`H...H...H. 
	defb 084h,048h,000h,022h,072h,048h,000h,024h,072h,048h,000h,026h,084h,048h,000h,028h	; 4648  .H."rH.$rH.&.H.(
	defb 060h,048h,000h,02ah,060h,048h,000h,02ch,096h,048h,000h,02eh,060h,048h,000h,030h	; 4658  `H.*`H.,.H..`H.0
	defb 072h,048h,000h,032h,072h,048h,000h,034h,084h,048h,000h,036h,072h,048h,000h,038h	; 4668  rH.2rH.4.H.6rH.8
	defb 084h,048h,000h,03ah,096h,048h,000h,03ch,060h,048h,000h,03eh,072h,048h,000h,080h	; 4678  .H.:.H.<`H.>rH..
	defb 072h,048h,000h,082h,060h,048h,000h,084h,084h,048h,000h,086h,084h,048h,000h,088h	; 4688  rH..`H...H...H..
	defb 084h,048h,000h,08ah,060h,048h,000h,08ch,096h,048h,000h,08eh,072h,048h,000h,090h	; 4698  .H..`H...H..rH..
	defb 060h,048h,000h,092h,060h,048h,000h,094h,072h,048h,000h,096h,072h,048h,000h,098h	; 46a8  `H..`H..rH..rH..
	defb 072h,048h,00ah,000h,0a8h,048h,00ah,008h,0a8h,048h,00ah,010h,0a8h,048h,00ah,018h	; 46b8  rH...H...H...H..
	defb 0a8h,048h,00ah,020h,0a8h,048h,00ah,028h,0a8h,048h,00ah,030h,0a8h,048h,00ah,038h	; 46c8  .H. .H.(.H.0.H.8
	defb 0a8h,048h,00ah,080h,0a8h,048h,00ah,088h,0a8h,048h,00ah,090h,0a8h,048h,00ah,094h	; 46d8  .H...H...H...H..
	defb 0a8h,048h,008h,008h,0c2h,048h,008h,030h,0c2h,048h,008h,034h,0c2h,048h,008h,036h	; 46e8  .H...H.0.H.4.H.6
	defb 0c2h,048h,008h,082h,0c2h,048h,008h,090h,0c2h,048h,007h,09ah,0feh,049h,004h,09ah	; 46f8  .H...H...H...I..
	defb 0feh,049h,000h,09ah,0feh,049h,0ffh,004h,000h,04ch,04ah,004h,002h,04ch,04ah,005h	; 4708  .I...I...LJ..LJ.
	defb 004h,056h,04ah,004h,006h,04ch,04ah,004h,008h,04ch,04ah,004h,00ah,04ch,04ah,005h	; 4718  .VJ..LJ..LJ..LJ.
	defb 00ch,056h,04ah,004h,00eh,04ch,04ah,005h,010h,056h,04ah,005h,012h,056h,04ah,004h	; 4728  .VJ..LJ..VJ..VJ.
	defb 014h,04ch,04ah,006h,016h,080h,04ah,004h,019h,04ch,04ah,006h,01bh,091h,04ah,001h	; 4738  .LJ...J..LJ...J.
	defb 002h,08ch,04ah,000h,004h,088h,04ah,003h,00ch,08ch,04ah,002h,010h,088h,04ah,001h	; 4748  ..J...J...J...J.
	defb 012h,068h,049h,001h,01ch,088h,04ah,002h,01dh,088h,04ah,005h,020h,056h,04ah,006h	; 4758  .hI...J...J. VJ.
	defb 022h,080h,04ah,004h,025h,04ch,04ah,006h,027h,091h,04ah,004h,025h,04ch,04ah,006h	; 4768  ".J.%LJ.'.J.%LJ.
	defb 027h,091h,04ah,004h,02ch,04ch,04ah,005h,02eh,056h,04ah,004h,030h,0a5h,04ah,004h	; 4778  '.J.,LJ..VJ.0.J.
	defb 037h,04ch,04ah,006h,039h,09dh,04ah,004h,03ch,04ch,04ah,004h,03eh,04ch,04ah,003h	; 4788  7LJ.9.J.<LJ.>LJ.
	defb 022h,088h,04ah,002h,023h,032h,04ah,002h,02ch,032h,04ah,003h,02ch,08ch,04ah,002h	; 4798  ".J.#2J.,2J.,.J.
	defb 030h,088h,04ah,001h,032h,068h,049h,002h,036h,08ch,04ah,000h,03eh,088h,04ah,004h	; 47a8  0.J.2hI.6.J.>.J.
	defb 080h,04ch,04ah,005h,082h,056h,04ah,006h,084h,09dh,04ah,005h,087h,056h,04ah,004h	; 47b8  .LJ..VJ...J..VJ.
	defb 089h,04ch,04ah,004h,08bh,04ch,04ah,006h,08dh,091h,04ah,005h,092h,056h,04ah,004h	; 47c8  .LJ..LJ...J..VJ.
	defb 094h,04ch,04ah,004h,096h,04ch,04ah,004h,098h,04ch,04ah,002h,082h,08ch,04ah,001h	; 47d8  .LJ..LJ..LJ...J.
	defb 084h,08ch,04ah,003h,08ch,08ch,04ah,002h,090h,08ch,04ah,001h,092h,08ch,04ah,008h	; 47e8  ..J...J...J...J.
	defb 098h,036h,04ah,008h,000h,036h,04ah,008h,004h,036h,04ah,008h,008h,036h,04ah,008h	; 47f8  .6J..6J..6J..6J.
	defb 00ch,036h,04ah,008h,010h,036h,04ah,008h,014h,036h,04ah,008h,018h,036h,04ah,008h	; 4808  .6J..6J..6J..6J.
	defb 01ch,036h,04ah,008h,020h,036h,04ah,008h,024h,036h,04ah,008h,028h,036h,04ah,008h	; 4818  .6J. 6J.$6J.(6J.
	defb 02ch,036h,04ah,008h,030h,036h,04ah,008h,034h,036h,04ah,008h,038h,036h,04ah,008h	; 4828  ,6J.06J.46J.86J.
	defb 03ch,036h,04ah,008h,080h,036h,04ah,008h,084h,036h,04ah,008h,088h,036h,04ah,008h	; 4838  <6J..6J..6J..6J.
	defb 08ch,036h,04ah,008h,090h,036h,04ah,008h,094h,036h,04ah,007h,09ah,0feh,049h,004h	; 4848  .6J..6J..6J...I.
	defb 09ah,0feh,049h,000h,09ah,0feh,049h,0ffh	; 4858  ..I...I.

; ----------------------------------------------------------------------
; DATOS rio_dibujos: Los dibujos del rio (ancho, alto y casillas; 0,
;   transparente)
;   0x4860..0x4a1e  (446 bytes)
DATA_rio_dibujos:
	defb 002h,008h,042h,041h,046h,045h,04ah,049h,044h,040h,04bh,043h,048h,047h,069h,068h	; 4860  ..BAFEJID@KCHGih
	defb 06dh,06ch,002h,008h,086h,050h,050h,051h,051h,055h,055h,010h,061h,060h,065h,064h	; 4870  ml...PPQQUU.a`ed
	defb 069h,068h,06dh,06ch,002h,008h,050h,050h,051h,051h,055h,055h,010h,010h,061h,060h	; 4880  ihml..PPQQUU..a`
	defb 065h,064h,069h,068h,06dh,06ch,002h,008h,086h,050h,050h,050h,051h,051h,055h,055h	; 4890  edihml...PPPQQUU
	defb 061h,060h,065h,064h,069h,068h,06dh,06ch,008h,003h,06bh,06ah,06bh,06ah,06bh,06ah	; 48a0  a`edihml..kjkjkj
	defb 06bh,06ah,06fh,06ah,06fh,06ah,06fh,06ah,06fh,06ah,0c7h,0c6h,0c7h,0c6h,0c7h,0c6h	; 48b0  kjojojojoj......
	defb 0c7h,0c6h,002h,005h,0e9h,0e8h,0edh,0ech,06bh,06ah,06fh,06eh,0c7h,0c6h,008h,005h	; 48c0  ........kjon....
	defb 073h,072h,073h,072h,073h,072h,073h,072h,077h,076h,077h,076h,077h,076h,077h,076h	; 48d0  srsrsrsrwvwvwvwv
	defb 07bh,07ah,07bh,07ah,07bh,07ah,07bh,07ah,07fh,07eh,07fh,07eh,07fh,07eh,07fh,07eh	; 48e0  {z{z{z{z.~.~.~.~
	defb 08fh,08eh,08fh,08eh,08fh,08eh,08fh,08eh,002h,002h,0cbh,0cah,0cfh,0ceh,006h,008h	; 48f0  ................
	defb 063h,062h,085h,084h,010h,010h,067h,066h,081h,080h,010h,010h,010h,010h,085h,084h	; 4900  cb....gf........
	defb 010h,010h,010h,010h,085h,084h,010h,010h,010h,010h,081h,080h,053h,052h,010h,010h	; 4910  ............SR..
	defb 085h,084h,057h,056h,0f0h,0e2h,085h,084h,0f1h,0f0h,0f4h,0e4h,085h,084h,0f5h,0f4h	; 4920  ..WV............
	defb 004h,008h,010h,010h,05bh,010h,010h,010h,05fh,062h,010h,010h,05bh,062h,010h,010h	; 4930  ....[..._b..[b..
	defb 05fh,010h,067h,066h,05bh,010h,010h,010h,05fh,010h,0e2h,0e1h,05bh,0f1h,0e4h,0e4h	; 4940  _.gf[..._...[...
	defb 05fh,0f5h,004h,005h,0e3h,0e3h,0e3h,0e3h,0e7h,0e7h,0e7h,0e7h,0ebh,0ebh,0ebh,0ebh	; 4950  _...............
	defb 0efh,0eeh,0efh,0eeh,0ebh,0ebh,0ebh,0ebh,003h,002h,010h,0e5h,0f8h,07dh,0eah,0fch	; 4960  .............}..
	defb 006h,008h,010h,010h,010h,078h,010h,010h,010h,010h,010h,088h,071h,070h,010h,010h	; 4970  .....x......qp..
	defb 089h,010h,075h,074h,04eh,04dh,08ah,010h,010h,010h,054h,04fh,010h,078h,010h,010h	; 4980  ..utNM....TO.x..
	defb 010h,010h,010h,088h,071h,070h,010h,010h,089h,010h,075h,074h,010h,010h,08ah,010h	; 4990  ....qp....ut....
	defb 010h,010h,006h,006h,010h,010h,089h,010h,010h,010h,04eh,04dh,08ah,010h,010h,010h	; 49a0  ..........NM....
	defb 054h,04fh,010h,078h,010h,010h,010h,010h,010h,088h,071h,070h,010h,010h,089h,010h	; 49b0  TO.x......qp....
	defb 075h,074h,010h,010h,08ah,010h,010h,010h,002h,00dh,08dh,08ch,08dh,08ch,08dh,08ch	; 49c0  ut..............
	defb 08dh,08ch,08dh,08ch,08dh,08ch,08dh,08ch,08dh,08ch,08dh,08ch,08dh,08ch,08dh,08ch	; 49d0  ................
	defb 08dh,08ch,08dh,08ch,004h,002h,0e2h,0e1h,0e0h,0f1h,0e4h,0e4h,0e4h,0f4h,002h,003h	; 49e0  ................
	defb 0b4h,0b5h,0b8h,0b9h,0bch,0bdh,002h,003h,0b6h,0b7h,0bah,0bbh,0beh,0bfh,005h,006h	; 49f0  ................
	defb 0b3h,0cch,0c8h,0c9h,0cdh,0b3h,010h,0cch,0c8h,0b3h,0b3h,010h,010h,0c9h,0cdh,0b3h	; 4a00  ................
	defb 010h,010h,0c8h,0b3h,0b3h,010h,010h,0c9h,0cdh,0b3h,010h,010h,0c8h,0b3h	; 4a10  ..............

; ----------------------------------------------------------------------
; DATOS orilla_dibujo: La orilla (2 x 9 casillas), en la fila 13 al llegar
;   0x4a1e..0x4a32  (20 bytes)
DATA_orilla_dibujo:
	defb 002h,009h,0b3h,0c8h,0cdh,0c9h,0b3h,0c8h,0cdh,0c9h,0b3h,0c8h,0cdh,0c9h,0b3h,0c8h	; 4a1e  ................
	defb 0cdh,0c9h,0b3h,0c8h	; 4a2e

; ----------------------------------------------------------------------
; DATOS tierra_dibujos2: Mas dibujos de tierra
;   0x4a32..0x4ac3  (145 bytes)
DATA_tierra_dibujos2:
	defb 002h,001h,0d7h,0d3h,004h,005h,083h,082h,083h,082h,087h,087h,087h,087h,086h,08bh	; 4a32  ................
	defb 086h,08bh,086h,086h,08bh,086h,0c3h,0c2h,0c3h,0c2h,002h,004h,0c1h,0c0h,0c5h,0c4h	; 4a42  ................
	defb 0c5h,0c4h,0c5h,0c4h,002h,003h,0c1h,0c0h,0c5h,0c4h,0c5h,0c4h,008h,004h,0c0h,0c1h	; 4a52  ................
	defb 0c0h,0c1h,010h,010h,0c0h,0c1h,0c4h,0c5h,0c4h,0c5h,0c0h,0c1h,0c4h,0c5h,0c4h,0c5h	; 4a62  ................
	defb 0c4h,0c5h,0c4h,0c5h,0c4h,0c5h,0c4h,0c5h,0c4h,0c5h,0c4h,0c5h,0c4h,0c5h,003h,002h	; 4a72  ................
	defb 05ah,059h,058h,05eh,05dh,05ch,002h,001h,07dh,07ch,003h,001h,07dh,079h,07ch,005h	; 4a82  ZYX^]\..}|..}y|.
	defb 002h,0e2h,0e1h,0e0h,0f1h,0f0h,0e4h,0e4h,0e4h,0f5h,0f4h,003h,002h,0e0h,0f1h,0f0h	; 4a92  ................
	defb 0e4h,0f5h,0f4h,007h,004h,010h,0d2h,0d1h,0d0h,0f3h,0f2h,010h,0d7h,0d6h,0d5h,0d4h	; 4aa2  ................
	defb 0f7h,0f6h,010h,0dbh,0dah,0d9h,0d8h,0fbh,0fah,0f9h,0dfh,0deh,0ddh,0dch,0ffh,0feh	; 4ab2  ................
	defb 0fdh	; 4ac2

; ----------------------------------------------------------------------
; DATOS jefe_dibujos_1: Los cinco dibujos del jefe de la segunda escena
;   (0xE003 = 1) (0x4AC3, 0x4AE1, 0x4AFF, 0x4B24 y 0x4B57)
;   0x4ac3..0x4b80  (189 bytes)
DATA_jefe_dibujos_1:
	defb 004h,007h,010h,010h,010h,010h,060h,061h,062h,010h,064h,065h,066h,010h,068h,069h	; 4ac3  ......`ab.def.hi
	defb 06ah,06bh,06ch,06dh,06eh,06fh,070h,071h,072h,073h,074h,075h,076h,010h,004h,007h	; 4ad3  jklmnopqrstuv...
	defb 060h,061h,062h,010h,064h,065h,066h,010h,068h,069h,06ah,06bh,06ch,06dh,06eh,06fh	; 4ae3  `ab.def.hijklmno
	defb 070h,071h,072h,073h,077h,010h,010h,010h,07bh,07ah,010h,010h,005h,007h,010h,08eh	; 4af3  pqrsw...{z......
	defb 010h,010h,010h,08bh,094h,095h,096h,097h,08fh,098h,099h,09ah,09bh,010h,09ch,09dh	; 4b03  ................
	defb 09eh,09fh,010h,0b8h,0b9h,0bah,0bbh,010h,0bch,0bdh,0beh,010h,010h,088h,089h,08ah	; 4b13  ................
	defb 010h,007h,007h,010h,0a1h,0a2h,0a3h,010h,010h,010h,0a4h,0a5h,0a6h,0a7h,010h,010h	; 4b23  ................
	defb 010h,0a8h,0a9h,0aah,0abh,010h,010h,010h,010h,0adh,0aeh,0afh,010h,010h,010h,0b0h	; 4b33  ................
	defb 0b1h,0b2h,0b3h,090h,091h,092h,010h,0b5h,0b6h,0b7h,010h,010h,010h,010h,010h,010h	; 4b43  ................
	defb 010h,010h,010h,010h,005h,007h,010h,0a1h,0a2h,0a3h,010h,0a4h,0a5h,0a6h,0a7h,010h	; 4b53  ................
	defb 0a8h,0a9h,0aah,0abh,010h,010h,0adh,081h,082h,083h,0b0h,084h,085h,086h,087h,010h	; 4b63  ................
	defb 0b5h,0b6h,0b7h,010h,010h,010h,010h,010h,010h,0fbh,0b3h,0b4h,0b5h	; 4b73  .............

; ----------------------------------------------------------------------
; DATOS letras_dibujos: Las letras (casillas 0-0x2F): las cifras 0-9 y las
;   letras desde la 0x11 (A)
;   0x4b80..0x4d00  (384 bytes)
DATA_letras_dibujos:
	defb 000h,03eh,063h,063h,073h,073h,073h,03eh,000h,00ch,01ch,02ch,00ch,00ch,00ch,03fh	; 4b80  .>ccsss>...,...?
	defb 000h,03eh,047h,003h,00eh,030h,060h,07fh,000h,03eh,047h,003h,01eh,003h,047h,03eh	; 4b90  .>G..0`..>G...G>
	defb 000h,00eh,016h,026h,046h,04eh,07fh,006h,000h,07fh,070h,060h,07eh,007h,007h,07eh	; 4ba0  ...&FN....p`~..~
	defb 000h,03eh,063h,060h,07eh,063h,067h,03eh,000h,07fh,047h,003h,006h,00ch,018h,018h	; 4bb0  .>c`~cg>..G.....
	defb 000h,03eh,063h,067h,03eh,063h,067h,03eh,000h,03eh,063h,067h,03fh,003h,047h,03eh	; 4bc0  .>cg>cg>.>cg?.G>
	defb 000h,000h,00ch,00ch,000h,00ch,00ch,000h,000h,000h,000h,000h,000h,000h,060h,060h	; 4bd0  ..............``
	defb 000h,006h,00ch,018h,030h,018h,00ch,006h,000h,000h,000h,07eh,000h,07eh,000h,000h	; 4be0  ....0......~.~..
	defb 000h,008h,01ch,036h,07fh,07fh,05dh,008h,000h,03eh,067h,003h,01eh,018h,000h,018h	; 4bf0  ...6..]..>g.....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,01ch,03eh,063h,063h,073h,06fh,063h	; 4c00  ..........>ccsoc
	defb 000h,07eh,063h,073h,06eh,063h,063h,07eh,000h,03eh,063h,063h,070h,073h,073h,03eh	; 4c10  .~csncc~.>ccpss>
	defb 000h,07eh,063h,063h,073h,073h,073h,07eh,000h,07fh,060h,07ch,063h,060h,060h,07fh	; 4c20  .~ccsss~..`|c``.
	defb 000h,07fh,060h,07ch,063h,060h,060h,060h,000h,03eh,073h,073h,070h,067h,067h,03fh	; 4c30  ..`|c```.>sspgg?
	defb 000h,063h,063h,07fh,067h,063h,063h,063h,000h,018h,018h,018h,01ch,01ch,01ch,01ch	; 4c40  .cc.gccc........
	defb 000h,007h,007h,007h,003h,063h,063h,03fh,000h,063h,063h,064h,078h,074h,073h,073h	; 4c50  .....cc?.ccdxtss
	defb 000h,060h,060h,060h,070h,070h,073h,07fh,000h,07eh,07bh,07bh,06bh,06bh,06bh,06bh	; 4c60  .```pps..~{{kkkk
	defb 000h,066h,07bh,073h,063h,063h,063h,063h,000h,03eh,06bh,06fh,063h,07bh,06bh,03eh	; 4c70  .f{scccc.>koc{k>
	defb 000h,07eh,063h,063h,063h,066h,078h,060h,000h,03eh,073h,073h,073h,06bh,067h,03eh	; 4c80  .~cccfx`.>ssskg>
	defb 000h,07eh,063h,063h,067h,07ch,067h,063h,000h,03eh,073h,070h,03eh,007h,067h,03eh	; 4c90  .~ccg|gc.>sp>.g>
	defb 000h,07fh,018h,018h,018h,01ch,01ch,01ch,000h,063h,063h,063h,073h,073h,073h,03eh	; 4ca0  .........cccsss>
	defb 000h,077h,063h,063h,077h,036h,036h,01ch,000h,06bh,06bh,06bh,06bh,06fh,06fh,07eh	; 4cb0  .wccw66..kkkkoo~
	defb 000h,063h,027h,03eh,01ch,038h,07ch,067h,000h,043h,026h,01ch,018h,018h,01ch,01ch	; 4cc0  .c'>.8|g.C&.....
	defb 000h,07fh,063h,004h,018h,018h,023h,07fh,000h,000h,000h,000h,000h,000h,000h,000h	; 4cd0  ..c...#.........
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4ce0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4cf0  ................

; ----------------------------------------------------------------------
; DATOS casillas_d0: Las casillas 0xD0-0xFF de la partida (0x4D00) y sus
;   colores (0x4E80)
;   0x4d00..0x5000  (768 bytes)
DATA_casillas_d0:
	defb 0ffh,0f7h,0fdh,093h,091h,001h,001h,010h,0d8h,0feh,012h,073h,075h,0f9h,039h,058h	; 4d00  ...........su.9X
	defb 000h,000h,000h,000h,080h,080h,0c0h,0c0h,000h,01fh,0ffh,07fh,000h,000h,000h,000h	; 4d10  ................
	defb 00ch,00eh,00fh,047h,033h,034h,021h,061h,03eh,07fh,001h,0ffh,0afh,0a7h,0f5h,0dfh	; 4d20  ...G34!a>.......
	defb 0e0h,0ffh,0ffh,0ffh,0ffh,0fch,0fch,0feh,000h,070h,0f8h,0feh,000h,000h,000h,000h	; 4d30  .........p......
	defb 0e1h,0e1h,0c2h,0e0h,0fch,0feh,07eh,03ch,0dch,04ch,0cch,01eh,01fh,00fh,047h,007h	; 4d40  ......~<.L....G.
	defb 0ffh,06fh,0ffh,0afh,027h,03bh,07fh,007h,000h,000h,080h,0c0h,0e0h,0f0h,0fch,0feh	; 4d50  .o..';..........
	defb 07ch,05ch,05fh,01eh,00fh,003h,001h,0ffh,0c3h,0cbh,060h,08dh,001h,080h,0c4h,0f8h	; 4d60  |\_.......`.....
	defb 086h,0efh,0f0h,078h,04eh,063h,019h,0ffh,03fh,08fh,0e1h,0eah,027h,007h,0e1h,040h	; 4d70  ...xNc..?...'..@
	defb 000h,003h,005h,00bh,01dh,037h,0dfh,067h,0f0h,0f8h,0fch,0feh,0ffh,0ffh,0ffh,0ffh	; 4d80  .....7.g........
	defb 000h,000h,000h,000h,000h,080h,0c0h,0f8h,0efh,0efh,0ffh,0ffh,030h,078h,0f9h,0f9h	; 4d90  ............0x..
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0e0h,0f8h,0fch,0feh,0feh,0ffh,0ffh,0ffh	; 4da0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0f9h,0f9h,0f9h,0c9h,081h,0cfh,087h,000h	; 4db0  ................
	defb 00fh,07fh,0feh,0fch,0fch,0f8h,07fh,000h,0e0h,0fch,0feh,0ffh,0ffh,0ffh,0feh,040h	; 4dc0  ...............@
	defb 0ffh,0ffh,0f0h,0c0h,080h,0e0h,0f8h,0e0h,000h,0f7h,0f7h,0f7h,000h,07fh,07fh,07fh	; 4dd0  ................
	defb 003h,002h,005h,003h,00dh,00bh,00dh,007h,040h,0c0h,0e0h,0e0h,0e0h,0e0h,0c0h,080h	; 4de0  ........@.......
	defb 0ffh,081h,0fdh,085h,0b5h,0bdh,081h,0ffh,0ffh,081h,0bdh,0adh,0a1h,0bfh,081h,0ffh	; 4df0  ................
	defb 000h,000h,007h,019h,00fh,03bh,055h,07fh,000h,000h,080h,0f0h,0f0h,0f8h,0fch,0fdh	; 4e00  .....;U.........
	defb 000h,000h,001h,001h,003h,003h,003h,007h,03fh,0fdh,06fh,06bh,041h,041h,001h,004h	; 4e10  ........?.okAA..
	defb 0afh,0ffh,0bfh,07fh,0ffh,0ffh,0ffh,0ffh,0fch,0f3h,0e5h,0ebh,0bfh,0ffh,0ffh,0ffh	; 4e20  ................
	defb 007h,00fh,01fh,03fh,03fh,07fh,07fh,0ffh,0ffh,010h,068h,040h,040h,0e0h,0c0h,0c0h	; 4e30  ...??.....h@@...
	defb 007h,01fh,03fh,07fh,07fh,0ffh,0ffh,0ffh,000h,000h,001h,003h,007h,01fh,07fh,0ffh	; 4e40  ..?.............
	defb 001h,007h,00fh,01eh,064h,0cch,0cch,0dch,080h,083h,00dh,009h,003h,027h,00eh,01ch	; 4e50  ....d........'..
	defb 0ffh,0ffh,0ffh,07fh,07fh,03fh,01fh,007h,00fh,018h,0f2h,0ffh,021h,0ffh,01fh,07ch	; 4e60  .....?......!..|
	defb 0b8h,038h,072h,061h,0cfh,07dh,0c0h,0ffh,01ch,030h,0f4h,0e0h,0e8h,0c0h,0ffh,0ffh	; 4e70  .8ra.}...0......
	defb 07fh,075h,075h,074h,074h,074h,074h,0e4h,070h,070h,0e7h,0e7h,0e4h,0e4h,0e4h,0e4h	; 4e80  .uutttt.pp......
	defb 0f0h,0f0h,0f0h,0f0h,0e0h,0e0h,0e0h,0e0h,0f0h,0b0h,0ffh,0f0h,0f0h,0f0h,0f0h,0f0h	; 4e90  ................
	defb 0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0f4h,0fbh,0ffh,0e4h,0e4h,0e4h,0e4h	; 4ea0  ................
	defb 0e0h,0bfh,0ffh,0bfh,0ffh,0e0h,0e0h,0e0h,0f0h,0b0h,0f0h,0b0h,0f0h,0f0h,0f0h,0f0h	; 4eb0  ................
	defb 0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h	; 4ec0  ................
	defb 0efh,0e4h,0efh,0e4h,0e4h,0e4h,0e4h,0e4h,0f0h,0f0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; 4ed0  ................
	defb 0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,04fh,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h	; 4ee0  .......O........
	defb 0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,04fh,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h	; 4ef0  .......O........
	defb 0f0h,040h,040h,040h,040h,040h,040h,040h,040h,040h,040h,040h,04fh,04fh,04fh,04fh	; 4f00  .@@@@@@@@@@@OOOO
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,040h,040h,040h,070h,074h,05fh,04fh,074h,074h,075h,075h	; 4f10  .....@@@pt_Ottuu
	defb 04fh,04fh,04fh,04fh,04fh,04fh,04fh,04fh,0b0h,0b0h,0b0h,0b0h,0b0h,0bfh,0bfh,0bfh	; 4f20  OOOOOOOO........
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,075h,075h,075h,075h,075h,050h,050h,0f0h	; 4f30  ........uuuuuPP.
	defb 0c0h,0c0h,0c3h,0c3h,0c3h,0c3h,0c0h,0f0h,030h,030h,030h,03fh,03fh,03fh,0c0h,030h	; 4f40  ........000???.0
	defb 0bfh,0bfh,0b5h,0b7h,0b5h,0b5h,0b0h,0b0h,0f0h,030h,0c0h,0c0h,0f0h,030h,0c0h,0c0h	; 4f50  .........0...0..
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,030h,030h,030h,030h,030h,030h,0c0h,0c0h	; 4f60  ........000000..
	defb 0cfh,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0cfh,0cfh,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0cfh	; 4f70  ................
	defb 0f0h,0f0h,040h,040h,040h,040h,040h,040h,0f0h,0f0h,040h,040h,040h,040h,040h,040h	; 4f80  ..@@@@@@..@@@@@@
	defb 0f0h,0f0h,070h,040h,040h,040h,040h,040h,070h,075h,074h,074h,074h,074h,074h,0e4h	; 4f90  ..p@@@@@puttttt.
	defb 040h,04fh,040h,040h,04fh,04fh,04fh,04fh,040h,040h,040h,040h,040h,04fh,04fh,04fh	; 4fa0  @O@@OOOO@@@@@OOO
	defb 040h,040h,040h,040h,040h,040h,040h,04fh,04fh,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h	; 4fb0  @@@@@@@OO.......
	defb 0b0h,0b0h,0b0h,0b0h,0b0h,0bfh,0bfh,0bfh,0f0h,0f0h,040h,040h,040h,040h,040h,04fh	; 4fc0  ..........@@@@@O
	defb 0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h	; 4fd0  ................
	defb 0bfh,0bfh,0bfh,0b0h,0b0h,0b0h,0b0h,0b0h,0e4h,0e4h,0e4h,04fh,0e4h,04fh,0e4h,0e4h	; 4fe0  ...........O.O..
	defb 0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,04fh,0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,04fh,04fh	; 4ff0  .......O......OO

; ----------------------------------------------------------------------
; DATOS titulo_casillas: Las casillas del titulo (desde la 0x30: el nombre y
;   CASIO; el final las pone en el segundo tercio para どんなもんだい)
;   0x5000..0x5300  (768 bytes)
DATA_titulo_casillas:
	defb 0ffh,003h,007h,007h,0ffh,0ffh,0ffh,0ffh,0feh,080h,0c0h,0c0h,0fch,0feh,0feh,0fch	; 5000  ................
	defb 000h,007h,01fh,03fh,07eh,078h,0f0h,0e0h,000h,0e0h,0f8h,0fch,07eh,03eh,03fh,06fh	; 5010  ...?~x......~>?o
	defb 007h,007h,087h,0c7h,0c7h,0c7h,087h,007h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 5020  ................
	defb 0e0h,0e1h,0e3h,0f7h,07fh,07eh,03ch,018h,0c7h,0c7h,087h,087h,006h,00eh,01ch,038h	; 5030  .....~<........8
	defb 007h,007h,07fh,01fh,01fh,007h,003h,0ffh,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,080h,0feh	; 5040  ................
	defb 000h,000h,007h,01fh,019h,0b9h,0b0h,0b0h,000h,000h,0e0h,038h,008h,0cdh,01dh,01dh	; 5050  ...........8....
	defb 0ffh,00fh,01fh,09fh,0cfh,0c1h,0c1h,0cfh,0feh,0fch,0feh,0feh,0fch,0e0h,0e0h,0fch	; 5060  ................
	defb 0f9h,0f9h,0b1h,0b3h,0b3h,013h,01fh,007h,0ffh,00fh,00dh,0fdh,00dh,008h,0f8h,0e0h	; 5070  ................
	defb 0dfh,0dfh,09dh,01dh,01dh,01dh,09dh,0ddh,0feh,0feh,0eeh,0eeh,0eeh,0eeh,0eeh,0eeh	; 5080  ................
	defb 000h,000h,03fh,0ffh,0ffh,0f9h,098h,09ch,000h,000h,000h,0c0h,0c0h,0e0h,0e0h,0e0h	; 5090  ..?.............
	defb 0ddh,0ddh,0ddh,0ddh,0c1h,081h,0ffh,0ffh,0eeh,0eeh,0eeh,0eeh,0e6h,0e0h,0c0h,0feh	; 50a0  ................
	defb 09ch,09eh,09eh,08eh,0c7h,0e7h,0ffh,03fh,060h,060h,060h,0e0h,0e0h,0c0h,0c0h,000h	; 50b0  .......?```.....
	defb 000h,000h,0e0h,0f8h,0f8h,09dh,08dh,0edh,000h,000h,03fh,0ffh,0e7h,080h,080h,0e7h	; 50c0  ..........?.....
	defb 000h,000h,080h,0e3h,0e3h,0f7h,0f7h,0f7h,000h,000h,0fch,0ffh,0ffh,0cfh,0cfh,08fh	; 50d0  ................
	defb 09fh,09fh,00dh,08dh,01dh,038h,0f8h,0e0h,080h,080h,0e7h,0e6h,0e0h,0f0h,0ffh,03fh	; 50e0  .....8.........?
	defb 0ffh,0ffh,0f7h,076h,076h,0e2h,0e3h,080h,09fh,00dh,005h,021h,061h,073h,0ffh,0fch	; 50f0  ...vv......!as..
	defb 07fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 5100  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,07fh,0ffh,0ffh,07fh	; 5110  ................
	defb 0ffh,0ffh,03fh,07fh,07fh,07fh,03fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 5120  ..?...?.........
	defb 0ffh,0ffh,0f8h,0fch,0fch,0fch,0f8h,0ffh,0ffh,007h,00bh,017h,017h,01fh,00fh,007h	; 5130  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 5140  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 5150  ................
	defb 0ffh,00eh,01fh,03fh,03fh,01fh,00eh,0ffh,0ffh,0ffh,001h,09fh,0bfh,03fh,01fh,001h	; 5160  ...??........?..
	defb 0ffh,0c0h,0e0h,0feh,0ffh,0ffh,0feh,0e0h,0ffh,01eh,03ch,07fh,07fh,07fh,079h,079h	; 5170  ..........<...yy
	defb 039h,07dh,07dh,07dh,039h,003h,073h,03fh,001h,01fh,03fh,03fh,01fh,0ffh,006h,00fh	; 5180  9}}}9.s?..??....
	defb 0e0h,0feh,0ffh,0ffh,0feh,0ffh,0ffh,0ffh,079h,079h,07fh,07fh,07ch,07fh,07fh,079h	; 5190  ........yy..|..y
	defb 01fh,01fh,01fh,01fh,01fh,01fh,00eh,0ffh,00fh,01eh,03ch,07fh,07fh,07fh,030h,0ffh	; 51a0  ..........<...0.
	defb 018h,03ch,0feh,0ffh,0ffh,08fh,006h,0ffh,079h,079h,079h,07fh,07fh,07fh,030h,0ffh	; 51b0  .<......yyy...0.
	defb 000h,000h,01fh,07fh,079h,0f9h,0cfh,0c4h,000h,000h,080h,0e3h,023h,037h,0f7h,077h	; 51c0  ....y.......#7.w
	defb 000h,000h,0fch,0ffh,0ffh,0cfh,0cfh,08fh,000h,000h,007h,01fh,019h,0b0h,0b0h,0b9h	; 51d0  ................
	defb 0e0h,0f1h,0e3h,0c7h,0c0h,060h,07fh,01fh,0ffh,0ffh,0f7h,0f6h,076h,062h,0e3h,080h	; 51e0  .....`......vb..
	defb 09fh,00dh,005h,021h,061h,073h,0ffh,0fch,0f9h,0f3h,0b2h,0bch,0bch,01eh,01fh,007h	; 51f0  ...!as..........
	defb 000h,000h,03fh,07fh,0ffh,0f0h,0e0h,0e0h,0e0h,0e0h,0e0h,0f0h,0ffh,07fh,03fh,000h	; 5200  ..?...........?.
	defb 000h,000h,0e0h,0f0h,0f8h,078h,000h,000h,000h,000h,039h,079h,0f9h,0f3h,0e3h,000h	; 5210  .....x....9y....
	defb 000h,000h,03eh,03eh,07fh,077h,077h,0e3h,0e3h,0e3h,0ffh,0ffh,0c1h,080h,080h,000h	; 5220  ..>>.ww.........
	defb 000h,000h,003h,007h,00fh,00fh,00fh,08fh,087h,083h,0c0h,0cfh,0cfh,0e7h,0e3h,000h	; 5230  ................
	defb 000h,000h,0feh,0ffh,0ffh,007h,000h,0feh,0ffh,0ffh,007h,007h,0ffh,0ffh,0feh,000h	; 5240  ................
	defb 000h,000h,038h,039h,0bbh,0bbh,03bh,03bh,03bh,0bbh,0bbh,0bbh,0bbh,039h,038h,000h	; 5250  ..89..;;;....98.
	defb 000h,000h,0ffh,0ffh,0ffh,0c1h,080h,080h,080h,080h,080h,0c1h,0ffh,0ffh,0ffh,000h	; 5260  ................
	defb 000h,000h,080h,0c0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0c0h,080h,000h	; 5270  ................
	defb 000h,00fh,010h,010h,00fh,000h,010h,00fh,000h,01ch,0a2h,022h,022h,0a2h,0a2h,01ch	; 5280  ...........""...
	defb 000h,0fbh,080h,080h,0f0h,080h,080h,080h,000h,0e8h,088h,089h,089h,089h,089h,086h	; 5290  ................
	defb 000h,027h,028h,028h,02fh,028h,028h,0c8h,000h,09eh,051h,051h,0deh,052h,051h,051h	; 52a0  .'((/((...QQ.RQQ
	defb 000h,07ch,040h,040h,078h,040h,040h,07ch,000h,000h,000h,000h,000h,000h,000h,000h	; 52b0  .|@@x@@|........
	defb 000h,000h,000h,000h,000h,000h,000h,000h,03ch,042h,099h,0a1h,0a1h,099h,042h,03ch	; 52c0  ........<B....B<
	defb 07fh,080h,080h,080h,080h,080h,080h,07fh,003h,004h,008h,008h,00fh,008h,008h,008h	; 52d0  ................
	defb 0c0h,020h,010h,010h,0f0h,010h,010h,010h,07fh,080h,080h,07eh,001h,001h,001h,0feh	; 52e0  . .........~....
	defb 010h,010h,010h,010h,010h,010h,010h,010h,07eh,081h,081h,081h,081h,081h,081h,07eh	; 52f0  ........~......~

; ----------------------------------------------------------------------
; DATOS partida_casillas: Las casillas 0x30-0xCF de la partida; las 0x90-0x9F
;   y 0xA0-0xA7 guardan tambien los cuatro pasos del agua (0x5600, 0x5680 y
;   0x56C0)
;   0x5300..0x5800  (1280 bytes)
DATA_partida_casillas:
	defb 03ch,06eh,05fh,07eh,07eh,07fh,07eh,03ch,000h,000h,018h,0e4h,0e4h,018h,000h,000h	; 5300  <n_~~.~<........
	defb 000h,000h,002h,07eh,000h,000h,000h,000h,000h,044h,07eh,004h,024h,004h,00ch,000h	; 5310  ...~.....D~.$...
	defb 000h,004h,07eh,00ch,014h,024h,044h,000h,000h,000h,03ch,000h,000h,07eh,000h,000h	; 5320  ..~..$D...<..~..
	defb 000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,0ffh,07fh,07fh,07fh,07fh,07fh,0ffh	; 5330  ................
	defb 000h,0ffh,03fh,03fh,03fh,03fh,03fh,0ffh,000h,0ffh,01fh,01fh,01fh,01fh,01fh,0ffh	; 5340  ..?????.........
	defb 000h,0ffh,00fh,00fh,00fh,00fh,00fh,0ffh,000h,0ffh,007h,007h,007h,007h,007h,0ffh	; 5350  ................
	defb 000h,0ffh,003h,003h,003h,003h,003h,0ffh,000h,0ffh,001h,001h,001h,001h,001h,0ffh	; 5360  ................
	defb 000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,000h,000h,000h,000h,000h,000h,000h	; 5370  ................
	defb 003h,008h,00fh,00fh,004h,006h,001h,004h,04fh,063h,07ch,07fh,01fh,02fh,023h,03ch	; 5380  ........Oc|../#<
	defb 0f6h,0c6h,03eh,0f8h,0fah,0f6h,0c6h,03ch,086h,0c7h,025h,047h,006h,0a7h,046h,003h	; 5390  ..>....<..%G..F.
	defb 0c8h,018h,0f0h,0f0h,0d0h,010h,0f0h,0f0h,03fh,03fh,02fh,011h,01ch,01fh,007h,013h	; 53a0  ........??/.....
	defb 0feh,0f0h,0e4h,0cch,03ch,0f0h,0e4h,0cch,093h,0d1h,0f1h,0d3h,0e3h,0d1h,088h,038h	; 53b0  ....<..........8
	defb 0cdh,0c3h,0cbh,0cfh,0c3h,08dh,083h,008h,018h,01fh,01fh,007h,013h,008h,00fh,007h	; 53c0  ................
	defb 01ch,0f8h,0f8h,0e0h,0c8h,018h,0f0h,0e0h,0f3h,0f1h,0f3h,0e6h,0e0h,0e1h,0e4h,0e6h	; 53d0  ................
	defb 07eh,0d7h,08bh,0adh,05ah,0b5h,09bh,066h,000h,0c0h,060h,010h,03dh,07fh,0fah,0f7h	; 53e0  ~...Z..f..`.=...
	defb 070h,0f8h,0fch,0fch,0eeh,05eh,0afh,0d7h,0ffh,0ffh,0feh,0ffh,0ffh,079h,070h,038h	; 53f0  p....^.......yp8
	defb 0ffh,0ffh,0ffh,0ffh,07fh,07fh,0feh,0ffh,07eh,07eh,07eh,07eh,03ch,01ch,03ch,03ch	; 5400  ........~~~~<.<<
	defb 003h,00fh,01fh,01fh,039h,060h,0c0h,080h,080h,0c0h,0e0h,060h,010h,01eh,00fh,003h	; 5410  ....9`.....`....
	defb 0dfh,059h,0fch,0ech,0d4h,0deh,0ffh,03fh,03ch,01ch,00ch,018h,019h,058h,009h,083h	; 5420  .Y.....?<....X..
	defb 000h,000h,000h,000h,000h,000h,003h,000h,001h,00eh,03eh,03ch,078h,0c0h,000h,000h	; 5430  ..........><x...
	defb 00fh,00fh,00ah,015h,015h,035h,035h,055h,0ffh,0ffh,0aah,055h,055h,055h,055h,055h	; 5440  .....55U...UUUUU
	defb 0f0h,0f0h,0b0h,058h,058h,054h,054h,056h,0f5h,0f5h,0f5h,0f5h,0f5h,0ffh,0ffh,0f5h	; 5450  ...XXTTV........
	defb 055h,055h,0aah,0ffh,000h,035h,03fh,03fh,055h,055h,0aah,0ffh,000h,093h,093h,0ffh	; 5460  UU...5??UU......
	defb 056h,056h,0abh,0ffh,000h,0ach,0fch,0fch,0f5h,0f5h,0f5h,0f5h,0f5h,0f5h,0f5h,0f5h	; 5470  VV..............
	defb 086h,0cch,030h,056h,004h,0bah,04ch,005h,07bh,079h,013h,006h,080h,089h,08ch,09eh	; 5480  ..0V..L.{y......
	defb 060h,074h,03eh,03eh,01eh,00ch,006h,00ch,000h,000h,080h,080h,0c0h,040h,060h,060h	; 5490  `t>>.........@``
	defb 081h,0c1h,0e3h,0dah,0e9h,0d8h,08ch,03fh,0cdh,0e3h,0ebh,0cfh,083h,005h,033h,078h	; 54a0  .......?......3x
	defb 03ch,0f8h,0d0h,01fh,00fh,007h,002h,000h,000h,000h,000h,000h,0c0h,0e0h,0f0h,01ch	; 54b0  <...............
	defb 01fh,0b7h,0dfh,08ah,0ech,0c0h,0e1h,0a1h,07ch,05ah,02bh,087h,08fh,0cbh,0efh,0c7h	; 54c0  ........|Z+.....
	defb 000h,000h,06eh,000h,037h,0f3h,000h,03ch,000h,000h,076h,000h,0deh,0ceh,000h,07ch	; 54d0  ..n.7..<..v....|
	defb 0f7h,0afh,0cbh,04fh,007h,00ah,005h,000h,0ebh,0e6h,0c3h,085h,0c1h,000h,000h,000h	; 54e0  ...O............
	defb 0feh,07ch,000h,0c3h,0efh,0ffh,0c7h,000h,0feh,07fh,000h,0c3h,0f7h,0ffh,0f3h,000h	; 54f0  .|..............
	defb 00eh,01fh,03fh,035h,07eh,07dh,069h,07eh,01fh,070h,040h,01eh,0ffh,05fh,0efh,0ffh	; 5500  ..?5~}i~.p@.._..
	defb 00fh,0dfh,0e0h,0e0h,0e0h,030h,010h,0fch,0e1h,0f1h,0fbh,0fbh,0f9h,078h,03ch,01fh	; 5510  .....0.......x<.
	defb 03bh,037h,037h,02bh,03fh,07fh,07ch,070h,07fh,0ffh,07fh,0dfh,0deh,09ch,030h,000h	; 5520  ;77+?.|p......0.
	defb 0beh,0dfh,09fh,09bh,081h,0c6h,0f3h,0a3h,087h,0cbh,03ah,03fh,03fh,0bah,083h,0cfh	; 5530  ..........:??...
	defb 007h,00fh,03ch,078h,060h,0e0h,0c0h,0c0h,000h,000h,0ffh,0ffh,0ffh,0ffh,000h,000h	; 5540  ..<x`...........
	defb 047h,0cfh,087h,087h,0c3h,0c0h,0e0h,0ffh,0ffh,0efh,0f4h,0f8h,0f9h,031h,060h,0e1h	; 5550  G............1`.
	defb 000h,000h,00fh,07fh,0ffh,07fh,000h,000h,000h,000h,0f0h,0fch,0feh,0f8h,000h,000h	; 5560  ................
	defb 0f7h,07bh,01fh,01fh,089h,0f3h,093h,0f1h,0e0h,010h,010h,038h,097h,0c7h,0fdh,0ffh	; 5570  .{.........8....
	defb 07fh,07fh,07fh,07fh,07fh,0ffh,0ffh,0f2h,0cbh,0cbh,0cbh,0cbh,0cbh,0ffh,0ffh,000h	; 5580  ................
	defb 0ffh,0adh,0e5h,0ffh,081h,0a2h,0fdh,0ffh,0ffh,01eh,0ceh,0ffh,083h,0c6h,0fdh,0ffh	; 5590  ................
	defb 07fh,07fh,07fh,07fh,07fh,07fh,07fh,07fh,0cbh,0cbh,0cbh,0cbh,0cbh,0cbh,0cbh,0cbh	; 55a0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,018h,014h,028h,014h,08fh,0ffh,0ffh	; 55b0  ...........(....
	defb 0c0h,0c0h,0e0h,070h,038h,01eh,00fh,003h,0e0h,070h,03ch,00eh,006h,007h,003h,003h	; 55c0  ...p8....p<.....
	defb 003h,003h,003h,007h,00eh,03ch,070h,0e0h,028h,054h,064h,018h,04fh,0ffh,0ffh,0ffh	; 55d0  .....<p.(Td.O...
	defb 083h,0bbh,0bbh,03bh,0b8h,0bbh,0bbh,0bbh,0c1h,0ddh,0ddh,0dch,01dh,0ddh,0ddh,0ddh	; 55e0  ...;............
	defb 007h,01fh,03fh,07fh,07fh,05fh,077h,03fh,0f8h,0fch,0feh,0feh,0ffh,0ffh,0ffh,0ffh	; 55f0  ..?.._w?........
	defb 0ffh,0ffh,085h,0ffh,0ffh,0fah,0ffh,0ffh,0ffh,0ffh,0feh,0ffh,0ffh,0c0h,0ffh,0ffh	; 5600  ................
	defb 0ffh,0ffh,0a0h,0ffh,0ffh,0efh,0ffh,0ffh,0ffh,0ffh,0f5h,0ffh,0ffh,0ach,0ffh,0ffh	; 5610  ................
	defb 0ffh,0ffh,0bfh,0ffh,080h,058h,0ffh,0ffh,0ffh,0ffh,0d0h,0ffh,007h,00ch,0ffh,0ffh	; 5620  .....X..........
	defb 0ffh,0ffh,01eh,0ffh,0ffh,0f5h,0ffh,0ffh,0ffh,01ch,0b0h,0ffh,00ch,098h,0ffh,0ffh	; 5630  ................
	defb 0ffh,0f8h,00dh,0ffh,0ffh,00bh,0ffh,0ffh,0ffh,001h,003h,0ffh,0ffh,080h,0ffh,0ffh	; 5640  ................
	defb 0ffh,0f8h,00eh,0ffh,0c0h,070h,0ffh,0ffh,0ffh,001h,080h,0ffh,03fh,070h,0ffh,0ffh	; 5650  .....p......?p..
	defb 0ffh,0c0h,030h,0ffh,0fch,087h,0ffh,0ffh,0ffh,001h,05bh,0ffh,0ffh,041h,0ffh,0ffh	; 5660  ..0.......[..A..
	defb 0ffh,0d8h,00eh,0ffh,08ch,007h,0ffh,0ffh,0ffh,0ffh,005h,0ffh,0ffh,06fh,0ffh,0ffh	; 5670  .............o..
	defb 05bh,00fh,015h,00bh,025h,002h,0d0h,0f4h,0ffh,075h,0eeh,0bdh,052h,0a8h,04bh,097h	; 5680  [...%....u..R.K.
	defb 05bh,00fh,015h,00bh,025h,002h,0c9h,0f5h,0ffh,075h,0eeh,0bdh,052h,0a9h,074h,017h	; 5690  [...%....u..R.t.
	defb 05bh,00fh,015h,00bh,0a5h,0d1h,03fh,0f2h,0ffh,075h,0eeh,0bdh,053h,0d6h,043h,0d7h	; 56a0  [.....?..u..S.C.
	defb 05bh,00fh,015h,00bh,025h,0bah,03ah,0f5h,0ffh,075h,0eeh,0bdh,052h,0a8h,05bh,0a7h	; 56b0  [...%.:..u..R.[.
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,081h,07fh,07fh,07fh,07fh,07fh,07fh,07fh	; 56c0  ................
	defb 0ffh,0ffh,0ffh,0f7h,0ffh,0feh,0f7h,0ffh,07fh,07fh,07fh,07fh,07fh,07fh,07fh,0afh	; 56d0  ................
	defb 0ffh,0ffh,0ffh,07fh,0ffh,0dfh,0ffh,03fh,07fh,07fh,07fh,07fh,07fh,07fh,02fh,0e0h	; 56e0  .......?....../.
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,07fh,07fh,07fh,07fh,07fh,07fh,07fh,07fh	; 56f0  ................
	defb 051h,0fbh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 5700  Q...............
	defb 03ch,07eh,0ffh,0f7h,0bdh,0ebh,0adh,0c3h,0aeh,055h,0abh,057h,007h,057h,0afh,057h	; 5710  <~.......U.W.W.W
	defb 00fh,03ah,07fh,0f8h,0f0h,0e0h,0e0h,0e0h,0f0h,05ch,0feh,01fh,00fh,007h,007h,007h	; 5720  .:.......\......
	defb 00fh,03ah,07fh,0f8h,0f0h,0e0h,0e0h,0e0h,0f0h,05ch,0feh,01fh,00fh,007h,007h,007h	; 5730  .:.......\......
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,007h,005h,007h,005h,007h,005h,007h,007h	; 5740  ................
	defb 0e0h,0a0h,0e0h,0a0h,0e0h,0a0h,0e0h,0e0h,007h,007h,007h,007h,007h,007h,007h,007h	; 5750  ................
	defb 0e0h,0e0h,0a0h,0a0h,0e0h,0bfh,0d3h,07fh,007h,007h,005h,005h,007h,0fdh,0cbh,0feh	; 5760  ................
	defb 0e0h,0e0h,0a0h,0a0h,0e0h,0bfh,0d3h,07fh,007h,007h,005h,005h,007h,0fdh,0cbh,0feh	; 5770  ................
	defb 00ch,01eh,01fh,01fh,03fh,07fh,07fh,07fh,080h,0a0h,0a0h,0f8h,0f8h,0fch,0feh,0feh	; 5780  ....?...........
	defb 007h,01fh,03fh,07fh,07fh,05fh,077h,03fh,0f8h,0fch,0feh,0feh,0ffh,0ffh,0ffh,0ffh	; 5790  ..?.._w?........
	defb 03eh,07eh,0feh,0ech,0e0h,0f8h,0fch,07eh,0fch,09eh,03eh,07fh,0e7h,0cdh,09fh,03fh	; 57a0  >~.....~..>....?
	defb 000h,0dfh,0efh,0f7h,0fbh,0fdh,0feh,0ffh,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,07fh	; 57b0  ................
	defb 0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0fch,0fah,0f6h,0eeh,0deh,0beh,07eh	; 57c0  ...............~
	defb 01fh,03fh,07fh,07fh,07bh,07fh,077h,078h,0f8h,0fch,0fah,0f4h,0dah,0fah,0eeh,01ah	; 57d0  .?..{.wx........
	defb 0feh,0fch,0f8h,0f0h,0e0h,0c0h,080h,000h,0afh,057h,0afh,057h,0afh,057h,0afh,057h	; 57e0  .........W.W.W.W
	defb 03fh,0cbh,0c0h,088h,085h,0e0h,07fh,01fh,0fch,0d3h,005h,011h,0a1h,007h,0fah,0f8h	; 57f0  ?...............

; ----------------------------------------------------------------------
; DATOS titulo_colores: Los colores de las casillas del titulo; sus ultimos
;   0x100 bytes (0x5A00) son a la vez los dibujos de los sprites de la pausa
;   (por eso esos colores se pintan de blanco, 0x88CD)
;   0x5800..0x5b00  (768 bytes)
DATA_titulo_colores:
	defb 04fh,0b4h,0b4h,0b4h,0bfh,0bfh,0bfh,0bfh,040h,0b4h,0b4h,0b4h,0b4h,0b4h,0b5h,0b5h	; 5800  O.......@.......
	defb 0f0h,050h,050h,070h,070h,050h,050h,070h,0f0h,050h,050h,070h,070h,050h,050h,070h	; 5810  .PPppPPp.PPppPPp
	defb 0b5h,0b4h,0b4h,0b4h,0b4h,0b5h,0b5h,0b5h,0b5h,0b4h,0b4h,0b4h,0b4h,0b5h,0b5h,0b5h	; 5820  ................
	defb 070h,050h,050h,070h,070h,050h,050h,050h,070h,050h,050h,070h,070h,050h,050h,050h	; 5830  pPPppPPPpPPppPPP
	defb 0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b5h,05fh,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b5h,050h	; 5840  ......._.......P
	defb 0f0h,0f0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0f0h,0f0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h	; 5850  ................
	defb 04fh,0b4h,0b4h,0b4h,0b4h,0b4h,0b5h,0b5h,040h,0b4h,0b4h,0b4h,0b4h,0b4h,0b5h,0b5h	; 5860  O.......@.......
	defb 0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0bfh,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h	; 5870  ................
	defb 0b5h,0b4h,0b4h,0b4h,0b4h,0b5h,0b5h,0b4h,0b5h,0b4h,0b4h,0b4h,0b4h,0b5h,0b5h,0b4h	; 5880  ................
	defb 0f0h,0f0h,0b0h,0bfh,0bfh,0b0h,0b0h,0b0h,0f0h,0f0h,0f0h,0b0h,0b0h,0b0h,0b0h,0b0h	; 5890  ................
	defb 0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,05fh,05fh,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b5h,050h	; 58a0  ......__.......P
	defb 0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0bfh,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0f0h	; 58b0  ................
	defb 0f0h,0f0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0f0h,0f0h,0b0h,0bfh,0b0h,0b0h,0b0h,0b0h	; 58c0  ................
	defb 0f0h,0f0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0f0h,0f0h,0b0h,0bfh,0bfh,0b0h,0b0h,0b0h	; 58d0  ................
	defb 0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0bfh,0b0h	; 58e0  ................
	defb 0bfh,0bfh,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0bfh,0b0h	; 58f0  ................
	defb 040h,04fh,04fh,04fh,04fh,04fh,05fh,05fh,04fh,04fh,04fh,04fh,04fh,04fh,05fh,05fh	; 5900  @OOOOO__OOOOOO__
	defb 04fh,04fh,04fh,04fh,04fh,04fh,05fh,05fh,04fh,04fh,04fh,04fh,0b4h,0bfh,0bfh,0b5h	; 5910  OOOOOO__OOOO....
	defb 05fh,04fh,0b4h,0b4h,0b4h,0b5h,0b5h,05fh,05fh,04fh,0bfh,0bfh,0bfh,0bfh,0bfh,05fh	; 5920  _O.....__O....._
	defb 05fh,04fh,0b4h,0b4h,0b4h,0b5h,0b5h,05fh,05fh,0b4h,0b4h,0b4h,0b4h,0b5h,0b5h,0b5h	; 5930  _O.....__.......
	defb 04fh,04fh,04fh,04fh,04fh,04fh,05fh,05fh,04fh,04fh,04fh,04fh,04fh,04fh,05fh,05fh	; 5940  OOOOOO__OOOOOO__
	defb 04fh,04fh,04fh,04fh,04fh,04fh,05fh,05fh,04fh,04fh,04fh,04fh,04fh,04fh,05fh,05fh	; 5950  OOOOOO__OOOOOO__
	defb 04fh,0b4h,0b4h,0b4h,0b4h,0b4h,0b5h,05fh,04fh,04fh,0b4h,0b4h,0b4h,0b4h,0b5h,0b5h	; 5960  O......_OO......
	defb 04fh,0b4h,0b4h,0b4h,0bfh,0bfh,0b5h,0b5h,04fh,0b4h,0b4h,0b4h,0b4h,0b4h,0b5h,0b5h	; 5970  O.......O.......
	defb 0b5h,0b4h,0b4h,0b4h,0b4h,0b5h,0b5h,0b4h,0b5h,0b4h,0b4h,0b4h,0b4h,05fh,0b5h,0b4h	; 5980  ............._..
	defb 0b5h,0b4h,0bfh,0bfh,0b4h,05fh,05fh,04fh,0b5h,0b4h,0b4h,0b4h,0b4h,0b5h,0b5h,0b4h	; 5990  .....__O........
	defb 0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b5h,05fh,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b5h,05fh	; 59a0  ......._......._
	defb 0b4h,0b4h,0b4h,0bfh,0bfh,0b4h,0b5h,05fh,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,0b5h,05fh	; 59b0  ......._......._
	defb 0f0h,0f0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0f0h,0f0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h	; 59c0  ................
	defb 0f0h,0f0h,0b0h,0bfh,0bfh,0b0h,0b0h,0b0h,0f0h,0f0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h	; 59d0  ................
	defb 0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0bfh,0bfh,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h	; 59e0  ................
	defb 0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0bfh,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h	; 59f0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,001h,003h,007h,005h,003h,001h,000h,000h,000h	; 5a00  ................
	defb 000h,000h,000h,000h,000h,000h,000h,0c0h,0e0h,0f0h,0a0h,0d8h,0b0h,000h,000h,000h	; 5a10  ................
	defb 000h,000h,000h,000h,000h,003h,007h,00eh,00ch,008h,000h,000h,00ch,01eh,03fh,000h	; 5a20  ..............?.
	defb 000h,000h,038h,078h,080h,0e0h,0f0h,038h,018h,008h,000h,000h,002h,00dh,0dfh,00eh	; 5a30  ..8x...8........
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,023h,070h,078h,078h	; 5a40  ............#pxx
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,001h,002h,0e7h,0f6h,0f8h,038h,038h	; 5a50  ..............88
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,040h,0c0h,000h,001h,002h,003h	; 5a60  ..........@.....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,080h,0e0h,0e0h	; 5a70  ................
	defb 00fh,01fh,03fh,07fh,0ffh,000h,07fh,07fh,07fh,07fh,07fh,07fh,07fh,000h,000h,000h	; 5a80  ..?.............
	defb 0ffh,0f8h,0f0h,0f6h,0ffh,000h,0ffh,0ffh,0c8h,0d8h,0d0h,0e0h,0c0h,000h,000h,000h	; 5a90  ................
	defb 0ffh,08fh,087h,0b7h,0ffh,000h,0ffh,0ffh,000h,000h,000h,000h,000h,000h,000h,000h	; 5aa0  ................
	defb 0f0h,0f8h,0fch,0feh,0ffh,000h,0feh,0feh,016h,016h,00eh,00eh,006h,000h,000h,000h	; 5ab0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 5ac0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,002h,007h,007h,007h,000h	; 5ad0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,007h,01fh,007h,081h,081h,000h	; 5ae0  ................
	defb 000h,000h,000h,000h,000h,000h,000h,000h,008h,010h,038h,0b0h,0c0h,0c0h,0c0h,000h	; 5af0  ..........8.....

; ----------------------------------------------------------------------
; DATOS partida_colores: Los colores de las casillas 0x30-0xCF (con los del
;   agua en 0x5E00-0x5EFF)
;   0x5b00..0x6000  (1280 bytes)
DATA_partida_colores:
	defb 0a0h,0b0h,0b0h,0b6h,0b6h,0b0h,0b0h,0a0h,0f0h,0f0h,060h,060h,060h,060h,0f0h,0f0h	; 5b00  ..........````..
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 5b10  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 5b20  ................
	defb 0f0h,04fh,08fh,08fh,08fh,08fh,08fh,04fh,0f0h,04fh,083h,083h,083h,083h,083h,04fh	; 5b30  .O.....O.O.....O
	defb 0f0h,04fh,083h,083h,083h,083h,083h,04fh,0f0h,04fh,083h,083h,083h,083h,083h,04fh	; 5b40  .O.....O.O.....O
	defb 0f0h,04fh,083h,083h,083h,083h,083h,04fh,0f0h,04fh,083h,083h,083h,083h,083h,04fh	; 5b50  .O.....O.O.....O
	defb 0f0h,04fh,083h,083h,083h,083h,083h,04fh,0f0h,04fh,083h,083h,083h,083h,083h,04fh	; 5b60  .O.....O.O.....O
	defb 0f0h,04fh,03fh,03fh,03fh,03fh,03fh,04fh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 5b70  .O?????O........
	defb 060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 5b80  ````````````````
	defb 060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 5b90  ````````````````
	defb 060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 5ba0  ````````````````
	defb 060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 5bb0  ````````````````
	defb 060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 5bc0  ````````````````
	defb 060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 5bd0  ````````````````
	defb 0c0h,030h,0c0h,0c0h,030h,0c0h,020h,0c0h,0f0h,0c0h,0c0h,0c0h,0b0h,0b0h,0b0h,0b0h	; 5be0  .0..0. .........
	defb 0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0bfh,0bfh,0b0h,0bfh,0bfh,0b0h,0b0h,0b0h	; 5bf0  ................
	defb 06fh,06fh,06fh,06fh,060h,060h,060h,06fh,060h,060h,060h,060h,060h,060h,060h,060h	; 5c00  oooo```o````````
	defb 030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,030h,0c0h,0c0h,0c0h,0c0h	; 5c10  000000000000....
	defb 0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0bfh,0b0h,060h,060h,060h,060h,060h,060h,060h,060h	; 5c20  ........````````
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,030h,0f0h,0c0h,030h,030h,030h,030h,030h,0f0h,0f0h	; 5c30  ......0..00000..
	defb 090h,060h,060h,090h,090h,090h,090h,090h,09fh,06fh,060h,090h,090h,090h,090h,090h	; 5c40  .``......o`.....
	defb 090h,060h,060h,090h,090h,090h,090h,090h,0c2h,0c2h,0c2h,0c2h,0c2h,03fh,0cfh,0c2h	; 5c50  .``..........?..
	defb 090h,090h,090h,06fh,0f0h,0e0h,0e0h,0e0h,090h,090h,090h,06fh,0f0h,0e0h,0e0h,0efh	; 5c60  ...o.......o....
	defb 090h,090h,090h,06fh,0f0h,0e0h,0e0h,0e0h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h	; 5c70  ...o............
	defb 060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 5c80  ````````````````
	defb 030h,030h,030h,030h,030h,030h,0c0h,0c0h,0f0h,0f0h,030h,030h,030h,030h,030h,030h	; 5c90  000000....000000
	defb 060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 5ca0  ````````````````
	defb 0c0h,0c0h,0c0h,030h,030h,030h,030h,0f0h,0f0h,0f0h,0f0h,0f0h,030h,030h,030h,030h	; 5cb0  ...0000.....0000
	defb 060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 5cc0  ````````````````
	defb 0f0h,0f0h,0c0h,0f0h,0c0h,030h,0f0h,0c0h,0f0h,0f0h,0c0h,0f0h,0c0h,030h,0f0h,0c0h	; 5cd0  .....0.......0..
	defb 060h,060h,060h,060h,060h,060h,060h,0f0h,060h,060h,060h,060h,060h,0f0h,0f0h,0f0h	; 5ce0  ```````.`````...
	defb 0c0h,030h,0f0h,0c0h,0c0h,0cfh,030h,0f0h,0c0h,030h,0f0h,0c0h,0c0h,0cfh,030h,0f0h	; 5cf0  .0....0..0....0.
	defb 0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0c0h,0c0h,0c0h,0b0h,0bfh,0b0h,0b0h,0bfh	; 5d00  ................
	defb 0a0h,0a0h,0bah,0bah,0bah,0bah,0bah,0bah,0b0h,0b0h,0b0h,0bah,0bah,0bah,0bah,0bah	; 5d10  ................
	defb 0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0bfh,0b0h,0b0h,0b0h,0b0h,0b0h,0f0h	; 5d20  ................
	defb 0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah	; 5d30  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0f0h,0f0h,05fh,07fh,05fh,05fh,0f0h,0f0h	; 5d40  .........._.__..
	defb 0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bfh,0bfh,0bah,0bah,0bah,0bah,0bah,0bah,0bah	; 5d50  ................
	defb 0f0h,0f0h,050h,070h,05fh,050h,0f0h,0f0h,0f0h,0f0h,050h,070h,050h,070h,0f0h,0f0h	; 5d60  ..Pp_P....PpPp..
	defb 0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bah,0bfh	; 5d70  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,03fh,0cfh,0c0h,0c2h,0c2h,0c2h,0c2h,0c2h,03fh,0cfh,0f0h	; 5d80  .....?.......?..
	defb 06fh,0c6h,060h,06fh,0c6h,0c6h,060h,06fh,06fh,0c6h,060h,06fh,0c6h,0c6h,060h,06fh	; 5d90  o.`o..`oo.`o..`o
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h,0c2h	; 5da0  ................
	defb 06fh,06fh,06fh,06fh,06fh,06fh,06fh,06fh,06fh,0c6h,0c6h,0c6h,0c6h,060h,06fh,06fh	; 5db0  ooooooooo....`oo
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 5dc0  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c6h,0c6h,0c6h,0c6h,060h,06fh,06fh,06fh	; 5dd0  ............`ooo
	defb 070h,070h,070h,070h,070h,070h,070h,070h,050h,050h,050h,050h,050h,050h,050h,050h	; 5de0  ppppppppPPPPPPPP
	defb 0ebh,0ebh,0ebh,0ebh,0ebh,0e0h,0e0h,0e0h,0ebh,0ebh,0ebh,0ebh,0efh,0efh,0efh,0efh	; 5df0  ................
	defb 05fh,05fh,075h,05fh,05fh,075h,05fh,05fh,05fh,05fh,075h,05fh,05fh,075h,05fh,05fh	; 5e00  __u__u____u__u__
	defb 05fh,05fh,075h,05fh,05fh,075h,05fh,05fh,05fh,05fh,075h,05fh,05fh,075h,05fh,05fh	; 5e10  __u__u____u__u__
	defb 05fh,05fh,075h,05fh,075h,075h,05fh,05fh,05fh,05fh,075h,05fh,075h,075h,05fh,05fh	; 5e20  __u_uu____u_uu__
	defb 05fh,05fh,075h,05fh,05fh,075h,05fh,05fh,05fh,075h,075h,05fh,075h,075h,05fh,05fh	; 5e30  __u__u___uu_uu__
	defb 05fh,075h,075h,05fh,05fh,075h,05fh,05fh,05fh,075h,075h,05fh,07fh,075h,05fh,05fh	; 5e40  _uu__u___uu_.u__
	defb 05fh,075h,075h,05fh,075h,075h,05fh,05fh,05fh,075h,075h,05fh,075h,075h,05fh,05fh	; 5e50  _uu_uu___uu_uu__
	defb 05fh,075h,075h,05fh,075h,075h,05fh,05fh,05fh,075h,075h,05fh,05fh,075h,05fh,05fh	; 5e60  _uu_uu___uu__u__
	defb 05fh,075h,075h,05fh,075h,075h,05fh,05fh,05fh,05fh,075h,05fh,05fh,075h,05fh,05fh	; 5e70  _uu_uu____u__u__
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,040h,040h,0efh,0e0h,0e0h,0e0h,0e0h,0e0h,040h,040h	; 5e80  ......@@......@@
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,040h,040h,0efh,0e0h,0e0h,0e0h,0e0h,040h,074h,040h	; 5e90  ......@@.....@t@
	defb 0e0h,0e0h,0e0h,0e0h,040h,074h,074h,040h,0efh,0e0h,0e0h,0e0h,040h,074h,040h,040h	; 5ea0  ....@tt@....@t@@
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,040h,070h,040h,0efh,0e0h,0e0h,0e0h,0e0h,0e0h,040h,040h	; 5eb0  .....@p@......@@
	defb 08fh,09fh,09fh,09fh,09fh,09fh,09fh,09fh,098h,090h,090h,090h,090h,090h,090h,090h	; 5ec0  ................
	defb 08fh,09fh,09fh,097h,09fh,097h,097h,09fh,080h,090h,090h,090h,090h,090h,090h,040h	; 5ed0  ...............@
	defb 08fh,09fh,09fh,097h,09fh,097h,04fh,074h,080h,090h,090h,090h,090h,090h,040h,074h	; 5ee0  ......Ot......@t
	defb 08fh,09fh,09fh,09fh,09fh,09fh,09fh,04fh,080h,090h,090h,090h,090h,090h,090h,090h	; 5ef0  .......O........
	defb 090h,090h,09fh,09fh,09fh,09fh,09fh,09fh,08fh,08fh,08fh,08fh,08fh,08fh,08fh,08fh	; 5f00  ................
	defb 0c0h,0c0h,0cfh,0c3h,0c3h,0c3h,0c3h,0c3h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 5f10  ................
	defb 098h,098h,098h,090h,090h,090h,090h,090h,098h,098h,098h,096h,096h,096h,096h,096h	; 5f20  ................
	defb 098h,098h,098h,096h,096h,096h,096h,096h,098h,098h,098h,090h,090h,090h,090h,090h	; 5f30  ................
	defb 090h,090h,090h,090h,090h,090h,090h,090h,096h,096h,096h,096h,096h,096h,096h,096h	; 5f40  ................
	defb 096h,096h,096h,096h,096h,096h,096h,096h,090h,090h,090h,090h,090h,090h,090h,090h	; 5f50  ................
	defb 096h,096h,096h,096h,096h,096h,096h,098h,096h,096h,096h,096h,096h,096h,096h,098h	; 5f60  ................
	defb 096h,096h,096h,096h,096h,096h,096h,098h,096h,096h,096h,096h,096h,096h,096h,098h	; 5f70  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 5f80  ................
	defb 0e6h,0e6h,0e6h,0e6h,0e6h,0e0h,0e0h,0e0h,0e6h,0e6h,0e6h,0e6h,0efh,0efh,0efh,0efh	; 5f90  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 5fa0  ................
	defb 0f0h,080h,080h,060h,060h,060h,060h,06fh,0f0h,08fh,08fh,06fh,06fh,06fh,06fh,060h	; 5fb0  ...````o...oooo`
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 5fc0  ................
	defb 0f0h,0f0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 5fd0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 5fe0  ................
	defb 0e0h,0e6h,0e6h,0e6h,0e6h,0e6h,0e0h,0e0h,0f0h,0e6h,0f6h,0f6h,0f6h,0f6h,0f0h,0e0h	; 5ff0  ................

; ----------------------------------------------------------------------
; DATOS decorado_casillas: Las casillas del decorado: las del primer tercio
;   (0x6000) y sus colores (0x6800), las del segundo (0x7000) y sus colores
;   (0x7800)
;   0x6000..0x8000  (8192 bytes)
DATA_decorado_casillas:
	defb 0ffh,0ffh,0ffh,0fch,0ffh,0ffh,0ffh,0fdh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 6000  ................
	defb 00fh,007h,003h,007h,00fh,007h,007h,007h,0ffh,0ffh,0ffh,0ffh,003h,003h,0c3h,0ffh	; 6010  ................
	defb 0e7h,0f7h,0ffh,0f8h,0f0h,0f4h,061h,0ffh,06fh,027h,003h,000h,0ffh,0ffh,0ffh,0c0h	; 6020  ......a.o'......
	defb 0fch,0f0h,0c0h,000h,0ffh,0ffh,0ffh,0ffh,0e0h,0c0h,0c0h,080h,080h,0ffh,0ffh,0ffh	; 6030  ................
	defb 0f7h,0ebh,0ffh,07fh,0ebh,0f7h,0ffh,0ffh,0efh,0d7h,0ffh,0feh,0d7h,0efh,0ffh,0ffh	; 6040  ................
	defb 0feh,0fdh,0afh,0bfh,0fdh,0feh,0ffh,0ffh,07fh,0bfh,0f5h,0fdh,0bfh,07fh,0ffh,0ffh	; 6050  ................
	defb 000h,000h,000h,000h,0ffh,0ffh,0ffh,0ffh,003h,001h,000h,000h,0ffh,0ffh,0ffh,0ffh	; 6060  ................
	defb 0f0h,0e0h,060h,000h,0ffh,0ffh,0ffh,0ffh,000h,000h,000h,000h,0ffh,0ffh,0ffh,0c0h	; 6070  ..`.............
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0ffh,0feh,0fch,0feh,003h,003h,003h,003h	; 6080  ................
	defb 007h,003h,001h,001h,0e0h,0f8h,0feh,0feh,0c1h,0f4h,0f8h,0fch,0feh,0feh,0ffh,0ffh	; 6090  ................
	defb 00fh,00fh,00fh,00fh,00fh,007h,007h,007h,003h,003h,003h,003h,003h,003h,003h,003h	; 60a0  ................
	defb 0feh,0fch,0f8h,0f0h,0c0h,0ffh,0ffh,0ffh,0ffh,0feh,0feh,0fch,0f8h,0f0h,0c0h,0ffh	; 60b0  ................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,0ffh,0ffh,07fh,07fh,03fh,05fh,00fh,003h	; 60c0  ............?_..
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,07fh,03fh,01fh,00fh,003h,0ffh,0ffh,0ffh	; 60d0  .........?......
	defb 001h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,003h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 60e0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0c0h,0f0h,0fch,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 60f0  ................
	defb 0ffh,0ffh,0ffh,00fh,00fh,00fh,00fh,00fh,0c0h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 6100  ................
	defb 0ffh,0ffh,0ffh,0c0h,0c0h,0c0h,080h,080h,0ffh,020h,068h,0c0h,0c0h,01eh,000h,000h	; 6110  ......... h.....
	defb 007h,000h,000h,000h,000h,000h,000h,000h,0fbh,07bh,000h,000h,000h,000h,000h,000h	; 6120  .........{......
	defb 000h,000h,000h,001h,001h,003h,003h,003h,000h,001h,0e3h,0ffh,0ffh,0f3h,0c0h,0c0h	; 6130  ................
	defb 000h,0fch,0feh,03fh,0ffh,0ffh,0ffh,0ffh,007h,0ffh,0ffh,0dfh,070h,028h,0ffh,0ffh	; 6140  ...?........p(..
	defb 087h,0ffh,01fh,047h,0ffh,0ffh,0ffh,0ffh,0c0h,0c0h,080h,080h,040h,080h,0ffh,0ffh	; 6150  ...G........@...
	defb 000h,000h,003h,00fh,00fh,007h,007h,007h,00fh,00fh,00fh,00fh,00fh,007h,007h,007h	; 6160  ................
	defb 007h,007h,007h,007h,007h,007h,007h,007h,003h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 6170  ................
	defb 000h,000h,0c0h,0f0h,0f0h,0f0h,00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh,0f0h,0f0h	; 6180  ................
	defb 0fch,0fch,0fch,0fch,0fch,0fch,003h,003h,0e0h,0e0h,00fh,000h,0ffh,0ffh,0ffh,0ffh	; 6190  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,00fh,00fh,003h,000h,000h,000h,0ffh,0ffh,0ffh,0c0h	; 61a0  ................
	defb 0f8h,070h,000h,000h,0ffh,0ffh,0ffh,0ffh,000h,000h,000h,000h,0ffh,0ffh,0ffh,003h	; 61b0  .p..............
	defb 00fh,00fh,00fh,00fh,00fh,00fh,00fh,00fh,01fh,06fh,07fh,07fh,06fh,01fh,0c0h,0ffh	; 61c0  .........o..o...
	defb 0efh,0d7h,0ffh,0ffh,0d7h,0efh,0ffh,0ffh,0f8h,0f6h,0feh,0feh,0f6h,0f8h,003h,0ffh	; 61d0  ................
	defb 03fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0c0h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 61e0  ?...............
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 61f0  ................
	defb 07eh,038h,000h,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,001h,003h,003h,003h,003h,003h	; 6200  ~8..............
	defb 020h,0ffh,040h,001h,0feh,0feh,0fch,0fch,0ffh,002h,0ffh,0e0h,0c0h,000h,000h,000h	; 6210   .@.............
	defb 0f0h,0f8h,0f8h,0f8h,0fch,0fch,0fch,0fch,003h,001h,000h,000h,000h,000h,000h,000h	; 6220  ................
	defb 0fch,0d8h,000h,000h,000h,000h,000h,00fh,0ffh,0ffh,0ffh,0ffh,0ffh,003h,00fh,03fh	; 6230  ...............?
	defb 0fch,083h,0a3h,041h,0ffh,0ffh,0ffh,0ffh,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 6240  ...A............
	defb 0feh,0f8h,0f0h,0f0h,0ffh,0ffh,0ffh,0ffh,0e0h,01fh,04fh,00fh,0ffh,004h,0ffh,0ffh	; 6250  ..........O.....
	defb 09fh,00fh,00fh,018h,010h,0ffh,0ffh,0ffh,07fh,07fh,02fh,009h,000h,000h,000h,000h	; 6260  ........../.....
	defb 0ffh,0ffh,0ffh,0c0h,0c0h,0c0h,000h,000h,000h,000h,000h,000h,000h,000h,000h,03eh	; 6270  ...............>
	defb 0f8h,0f8h,0f0h,0f0h,0f8h,0f8h,007h,007h,003h,003h,003h,003h,003h,003h,0feh,0feh	; 6280  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0feh,007h,00fh,000h,000h,003h,00fh,00fh,007h,0f8h,0f8h	; 6290  ................
	defb 07fh,07fh,03fh,00fh,007h,000h,000h,000h,0ffh,0ffh,0ffh,0fch,0fch,0fch,0f0h,0c0h	; 62a0  ..?.............
	defb 000h,000h,000h,000h,0f8h,0fch,0fch,0fch,00fh,00fh,00fh,00fh,00fh,007h,0f8h,0f8h	; 62b0  ................
	defb 0feh,0ffh,0ffh,03fh,01fh,00fh,00fh,00fh,03fh,01fh,00fh,00fh,020h,0ffh,0ffh,0ffh	; 62c0  ...?....?... ...
	defb 080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h	; 62d0  ................
	defb 07fh,07fh,07fh,07fh,07fh,07fh,080h,080h,0fch,0fch,0fch,0fch,0fch,0fch,003h,003h	; 62e0  ................
	defb 007h,006h,000h,000h,0ffh,0ffh,0ffh,0ffh,0fch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 62f0  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,080h,0ffh,0ffh,01fh,01fh,01fh,01fh,01fh,00fh,0ffh,0ffh	; 6300  ................
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,01fh,01fh,0ffh,0ffh,07fh,07fh,07fh,0ffh,0ffh,0ffh	; 6310  ................
	defb 0e0h,0f0h,0f0h,0f0h,0ffh,010h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,020h,0d0h,0c0h	; 6320  ............. ..
	defb 0ffh,0ffh,0ffh,0fch,0fch,0fch,0fch,0fch,007h,003h,003h,001h,001h,003h,003h,003h	; 6330  ................
	defb 01fh,0c1h,0f1h,095h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,07fh,01fh,00fh,00fh	; 6340  ................
	defb 0f8h,007h,007h,011h,004h,0ffh,0ffh,0ffh,003h,0ffh,0fch,0e0h,0ffh,0ffh,0ffh,0ffh	; 6350  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0feh,0f0h,0fch,0ffh,0ffh,0ffh,00fh,001h,001h,001h,001h	; 6360  ................
	defb 0ffh,0ffh,0ffh,0c3h,0c3h,0c1h,0c0h,0c0h,0c0h,0c0h,0c0h,080h,000h,000h,006h,01eh	; 6370  ................
	defb 000h,000h,0c0h,0f0h,0f0h,0e0h,0e0h,0e0h,000h,000h,000h,000h,0ffh,0ffh,0ffh,0ffh	; 6380  ................
	defb 080h,000h,003h,00fh,00fh,00fh,0f0h,0f0h,003h,003h,003h,003h,003h,003h,0fch,0fch	; 6390  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0e0h,0e0h,0e0h,0ffh,010h,020h,01fh,01fh,01fh,000h,000h	; 63a0  .......... .....
	defb 0ffh,0ffh,0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0c0h,000h,000h,000h,000h	; 63b0  ................
	defb 0fch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,00fh,00fh,00fh,00fh,003h	; 63c0  ................
	defb 000h,080h,0c0h,0e0h,0e1h,0ffh,083h,001h,0ffh,0ffh,0ffh,0feh,0feh,0feh,0feh,0feh	; 63d0  ................
	defb 0ffh,023h,00fh,01fh,03fh,07fh,07fh,0ffh,0e0h,0c0h,080h,080h,003h,00fh,03fh,07fh	; 63e0  .#..?.........?.
	defb 0ffh,07fh,03fh,07fh,0c0h,0c0h,0c0h,0c0h,0f0h,0e0h,0c0h,0e0h,0f0h,0e0h,0e0h,0e0h	; 63f0  ..?.............
	defb 000h,001h,003h,002h,003h,001h,000h,000h,07eh,0ffh,0bfh,0ffh,06fh,0f7h,0bch,008h	; 6400  ........~...o...
	defb 000h,000h,03eh,07fh,07fh,05fh,02fh,01eh,000h,0e7h,0e7h,0e7h,0e7h,0e7h,0e7h,0e7h	; 6410  ..>.._/.........
	defb 0f6h,0bdh,0ddh,0fah,0f9h,0f5h,0fah,0edh,006h,00dh,002h,001h,000h,000h,000h,000h	; 6420  ................
	defb 008h,008h,018h,018h,01fh,031h,03fh,075h,010h,010h,018h,018h,0f8h,08ch,0fch,0aeh	; 6430  .....1?u........
	defb 01fh,076h,03fh,067h,03bh,01fh,00ch,00ch,0feh,0dfh,0ffh,0bbh,0efh,0fch,000h,000h	; 6440  .v?g;...........
	defb 070h,06fh,0dch,0a8h,000h,0f8h,0abh,0fah,006h,0feh,03bh,019h,000h,01fh,0d5h,05fh	; 6450  po........;...._
	defb 014h,038h,0f0h,0d8h,0f6h,02bh,0c0h,000h,078h,0deh,0eeh,07ch,0c0h,080h,000h,000h	; 6460  .8...+..x..|....
	defb 0f6h,0bdh,0dch,0fah,0f9h,0f5h,0fbh,0eeh,06ah,055h,0c5h,0abh,08ah,056h,015h,0adh	; 6470  ........jU...V..
	defb 0feh,0fbh,0ffh,0fdh,0fbh,0feh,0ffh,0fdh,0f5h,0fbh,0f7h,0f5h,0ffh,0f7h,0fbh,0f5h	; 6480  ................
	defb 01ch,02eh,07dh,07fh,0dfh,07fh,0efh,0bfh,06fh,0dfh,07fh,0efh,0bfh,07fh,0afh,07fh	; 6490  ..}.....o.......
	defb 00fh,01fh,02fh,07fh,07fh,0ffh,0afh,057h,0e0h,0b0h,0d9h,0fbh,0f7h,0fbh,0fdh,0f6h	; 64a0  ../....W........
	defb 000h,000h,0e0h,0b8h,0f4h,0feh,07fh,0ffh,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 64b0  ................
	defb 000h,000h,003h,006h,00fh,01fh,03dh,07fh,000h,000h,080h,043h,0a7h,05fh,0bfh,07fh	; 64c0  ......=....C._..
	defb 00eh,039h,0feh,0fdh,024h,046h,082h,082h,000h,000h,0c0h,0a0h,058h,0ach,0feh,0f7h	; 64d0  .9..$F......X...
	defb 0f5h,0fbh,0f7h,0ffh,0dfh,0ffh,0ffh,000h,000h,01fh,01fh,01fh,01fh,01fh,01fh,01fh	; 64e0  ................
	defb 000h,0ffh,0c3h,0dbh,0c3h,03ch,0ffh,0ffh,00fh,00fh,00fh,01fh,01fh,00fh,01fh,00fh	; 64f0  .....<..........
	defb 000h,000h,007h,00fh,01fh,03fh,07fh,0ffh,000h,001h,003h,087h,0efh,0dfh,0bfh,0ffh	; 6500  .....?..........
	defb 070h,0fch,0feh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0f0h,0f0h,0f0h,0f0h,0f0h	; 6510  p...............
	defb 00fh,00fh,00fh,000h,00eh,00eh,00eh,000h,000h,000h,000h,000h,0c0h,0f0h,0f8h,0feh	; 6520  ................
	defb 0e0h,0e0h,0e0h,000h,0f0h,0f0h,0f0h,000h,000h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h	; 6530  ................
	defb 000h,000h,0ffh,03fh,0e0h,0ffh,000h,000h,000h,000h,03fh,07fh,01fh,000h,000h,000h	; 6540  ...?......?.....
	defb 000h,000h,000h,0f8h,0fch,0f8h,000h,000h,000h,0e0h,070h,038h,038h,03ch,03ch,07ch	; 6550  ..........p88<<|
	defb 000h,000h,00fh,03fh,07fh,037h,000h,000h,000h,000h,0b8h,0fch,0feh,0f8h,000h,000h	; 6560  ...?.7..........
	defb 000h,040h,063h,07fh,03fh,03fh,01fh,007h,07ch,0fch,0e0h,03fh,080h,0c0h,0e0h,080h	; 6570  .@c.??..|..?....
	defb 001h,001h,001h,003h,003h,003h,002h,003h,000h,000h,080h,080h,080h,0c0h,0c0h,0c0h	; 6580  ................
	defb 000h,000h,001h,001h,003h,007h,007h,007h,080h,080h,080h,0c0h,040h,0c0h,040h,0c0h	; 6590  ............@.@.
	defb 002h,007h,007h,007h,007h,00bh,00fh,01fh,0ffh,0a3h,0ffh,055h,011h,080h,06fh,090h	; 65a0  ...........U..o.
	defb 0ffh,095h,00fh,054h,004h,001h,076h,089h,0c0h,0e0h,0e0h,0a0h,0e0h,0f0h,0b0h,0f8h	; 65b0  ...T..v.........
	defb 03fh,07fh,0fbh,0a3h,0c7h,00fh,01dh,03fh,06fh,0c0h,0feh,0fdh,0feh,0f8h,0f4h,0c8h	; 65c0  ?......?o.......
	defb 076h,003h,07fh,03fh,07fh,01fh,02fh,013h,0fch,0feh,076h,0c0h,0e4h,0d0h,07ch,03ch	; 65d0  v..?../...v...|<
	defb 03fh,07fh,07fh,000h,0ffh,055h,0ffh,000h,0dch,0e0h,006h,050h,056h,050h,056h,050h	; 65e0  ?....U.....PVPVP
	defb 03bh,00fh,062h,00ah,06ah,00ah,06ah,00ah,03ch,03eh,03eh,000h,0ffh,0aah,0ffh,000h	; 65f0  ;.b.j.j.<>>.....
	defb 0ffh,081h,0bdh,0adh,0a1h,0bfh,081h,0ffh,001h,003h,003h,003h,007h,006h,007h,007h	; 6600  ................
	defb 080h,080h,0c0h,0c0h,0e0h,0e0h,0e0h,0e0h,0ffh,081h,0fdh,085h,0b5h,0bdh,081h,0ffh	; 6610  ................
	defb 000h,0efh,0efh,0efh,000h,0feh,0feh,0feh,00fh,00fh,00fh,00fh,00fh,00fh,01fh,01fh	; 6620  ................
	defb 0f0h,0f0h,078h,0f8h,078h,0f8h,0f8h,0d8h,0efh,0efh,0ffh,0ffh,030h,078h,0f9h,0f9h	; 6630  ..x.x.......0x..
	defb 0ebh,0ffh,0ffh,0f2h,0e5h,07fh,001h,0abh,0feh,0ffh,0feh,02bh,01fh,0feh,0fch,0a4h	; 6640  ...........+....
	defb 0f8h,0f8h,0fch,0fch,0fch,0fch,0fch,0fch,0f9h,0f9h,0f9h,0c9h,081h,0cfh,087h,000h	; 6650  ................
	defb 08ah,08ah,082h,000h,000h,000h,081h,07eh,084h,001h,001h,001h,003h,001h,083h,07ch	; 6660  .......~.......|
	defb 0fch,0feh,06eh,0feh,0dfh,0ffh,0c0h,0c0h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 6670  ..n.............
	defb 081h,06eh,07ah,076h,080h,03fh,05fh,01fh,083h,07ch,054h,07ch,007h,0ffh,0ffh,0ffh	; 6680  .nzv.?_..|T|....
	defb 0e0h,0e0h,0f0h,0d4h,0feh,0f6h,0bch,0feh,080h,0e0h,0e0h,0e0h,0f0h,0d8h,0feh,0ffh	; 6690  ................
	defb 0bfh,087h,009h,002h,01fh,0a7h,0f9h,0aah,01dh,001h,001h,07fh,09fh,027h,008h,07fh	; 66a0  .............'..
	defb 0fch,0fch,0feh,0ffh,0ffh,07fh,03fh,03fh,0fbh,0ffh,0dfh,0ffh,080h,0c0h,060h,0f0h	; 66b0  ......??......`.
	defb 0ffh,000h,000h,000h,000h,000h,07eh,000h,09fh,001h,003h,001h,010h,053h,051h,052h	; 66c0  ......~......SQR
	defb 01fh,01fh,0ffh,06bh,000h,0ffh,055h,0aah,0d8h,0f8h,0ffh,05ah,000h,0ffh,055h,0aah	; 66d0  ...k..U....Z..U.
	defb 07fh,000h,07fh,020h,05fh,000h,07fh,000h,053h,053h,053h,053h,053h,053h,050h,050h	; 66e0  ... _...SSSSSSPP
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,000h,000h	; 66f0  ................
	defb 0ffh,0ffh,0ffh,000h,000h,0ffh,000h,0ffh,000h,001h,001h,001h,003h,003h,003h,003h	; 6700  ................
	defb 080h,080h,0c0h,0c0h,060h,0e0h,0e0h,0e0h,00fh,00fh,00fh,000h,000h,00fh,000h,00fh	; 6710  ....`...........
	defb 0f0h,0f0h,0f0h,000h,000h,0f0h,000h,0f0h,007h,007h,005h,007h,007h,007h,007h,007h	; 6720  ................
	defb 0f0h,0f0h,0f8h,0b8h,078h,0f8h,0ech,0fch,00fh,00fh,00fh,0f8h,0f8h,00fh,0f8h,00fh	; 6730  ....x...........
	defb 0edh,0feh,0edh,000h,000h,0edh,000h,0edh,00fh,00fh,01fh,01fh,03fh,037h,03fh,07fh	; 6740  ............?7?.
	defb 080h,080h,0ffh,0d2h,0f5h,080h,080h,016h,0dfh,00fh,003h,01fh,02fh,0ffh,0ffh,06ah	; 6750  ............/..j
	defb 000h,000h,000h,000h,001h,001h,001h,007h,07fh,0fbh,0ffh,0fbh,0fbh,0f7h,0f7h,0efh	; 6760  ................
	defb 002h,082h,082h,080h,0c0h,080h,0c1h,03eh,028h,008h,000h,000h,000h,000h,081h,07eh	; 6770  .......>(......~
	defb 007h,00fh,01bh,01fh,02fh,0ffh,0ffh,0ffh,0cfh,0cfh,09fh,09fh,09fh,01fh,03bh,01fh	; 6780  ..../.........;.
	defb 0c1h,03eh,02ah,03eh,0e0h,0ffh,0ffh,0bfh,081h,076h,05eh,06eh,001h,0fdh,0f8h,0fah	; 6790  .>*>.....v^n....
	defb 0deh,0f8h,060h,0c0h,0c0h,080h,0ffh,003h,07fh,07fh,0feh,0feh,0feh,0bch,0fch,0f1h	; 67a0  ..`.............
	defb 07eh,07bh,07fh,0feh,0f9h,0e4h,010h,0feh,0fch,0e1h,090h,040h,0f8h,0e2h,08fh,02ah	; 67b0  ~{.........@...*
	defb 007h,00fh,0ffh,0b5h,000h,0ffh,055h,0aah,0b1h,0f3h,0ffh,0adh,000h,0ffh,055h,0aah	; 67c0  ......U.......U.
	defb 0f8h,080h,0c0h,040h,008h,0dah,05ah,09ah,0ffh,000h,000h,000h,000h,000h,03fh,000h	; 67d0  ...@..Z.......?.
	defb 03eh,022h,022h,023h,0e2h,022h,022h,022h,083h,0bbh,0bbh,03bh,0b8h,0bbh,0bbh,0bbh	; 67e0  >""#."""...;....
	defb 0dah,0dah,0dah,0dah,0dah,0dah,01ah,01ah,07fh,000h,07fh,002h,07dh,000h,07fh,000h	; 67f0  ............}...
	defb 06fh,06fh,06fh,096h,09fh,09fh,09fh,096h,06fh,06fh,06fh,06fh,06fh,06fh,06fh,06fh	; 6800  ooo.....oooooooo
	defb 0f0h,0f0h,050h,0f0h,0f3h,0f3h,0fch,0fch,06fh,06fh,06fh,06fh,096h,096h,0c6h,07fh	; 6810  ..P.....oooo....
	defb 096h,096h,09fh,096h,096h,096h,096h,06fh,060h,060h,060h,0f0h,03fh,03fh,0cfh,0c7h	; 6820  .......o```.??..
	defb 090h,090h,090h,0f0h,03fh,03fh,0cfh,07fh,090h,090h,090h,090h,093h,03fh,0cfh,07fh	; 6830  ....??.......?..
	defb 0c7h,0c7h,0cfh,0c7h,0c7h,0c7h,07fh,0cfh,0c7h,0c7h,0cfh,0c7h,0c7h,0c7h,07fh,0cfh	; 6840  ................
	defb 0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,07fh,0cfh,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,07fh,0cfh	; 6850  ................
	defb 0f0h,0f0h,0f0h,0f0h,03fh,03fh,0cfh,07fh,090h,090h,0f0h,0f0h,03fh,03fh,0cfh,07fh	; 6860  ....??......??..
	defb 060h,060h,060h,0f0h,03fh,03fh,0cfh,07fh,0f0h,0f0h,0f0h,0f0h,03fh,03fh,0cfh,0c7h	; 6870  ```.??......??..
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,07fh,070h,050h,070h,0c7h,0c7h,0c7h,0c7h	; 6880  .........pPp....
	defb 090h,090h,090h,090h,0c0h,0c0h,0c0h,0c9h,096h,096h,096h,096h,096h,096h,09fh,09fh	; 6890  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f3h,0f3h,0fch,0fch,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h	; 68a0  ................
	defb 0c9h,0c9h,0c9h,0c9h,0c9h,09fh,09fh,09fh,09fh,096h,096h,096h,096h,096h,096h,06fh	; 68b0  ...............o
	defb 0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,09fh,09fh,096h,096h,096h,096h,096h,096h	; 68c0  ................
	defb 09fh,09fh,09fh,09fh,09fh,09fh,09fh,09fh,0c9h,0c9h,0c9h,0c9h,0c9h,09fh,09fh,09fh	; 68d0  ................
	defb 0fbh,0bfh,0afh,0bfh,0bfh,0afh,0bfh,0bfh,0c7h,0bfh,0afh,0bfh,0bfh,0afh,0bfh,0bfh	; 68e0  ................
	defb 09fh,09fh,09fh,09fh,09fh,0a9h,0b9h,0b9h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h	; 68f0  ................
	defb 06fh,06fh,06fh,090h,090h,090h,090h,090h,0c7h,0bfh,0afh,0bfh,0bfh,0afh,0bfh,0bfh	; 6900  ooo.............
	defb 06fh,06fh,06fh,060h,060h,060h,060h,060h,06fh,096h,096h,096h,096h,060h,0f0h,0f0h	; 6910  ooo`````o....`..
	defb 090h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,060h,060h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 6920  ........``......
	defb 0f0h,0f0h,0f0h,090h,090h,090h,090h,090h,0f0h,090h,090h,09fh,09fh,096h,096h,096h	; 6930  ................
	defb 0f0h,090h,090h,096h,06fh,06fh,06fh,06fh,090h,09fh,09fh,096h,096h,096h,06fh,06fh	; 6940  ....oooo......oo
	defb 090h,09fh,096h,096h,06fh,06fh,06fh,06fh,096h,096h,096h,096h,096h,096h,06fh,06fh	; 6950  ....oooo......oo
	defb 0f0h,0f0h,0f0h,0f0h,0f3h,0f3h,0fch,0fch,0f0h,0f0h,0f0h,0f0h,0f3h,0f3h,0fch,0fch	; 6960  ................
	defb 0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fbh,0bfh,0afh,0bfh,0bfh,0afh,0bfh,0bfh	; 6970  ................
	defb 0f0h,0f0h,070h,070h,073h,073h,0c7h,0c7h,090h,090h,090h,090h,093h,093h,0c9h,0c9h	; 6980  ..ppss..........
	defb 060h,060h,060h,060h,063h,063h,0c6h,0c6h,096h,096h,060h,0f0h,03fh,03fh,0cfh,0cfh	; 6990  ````cc....`.??..
	defb 070h,070h,070h,070h,073h,073h,0c7h,0c7h,090h,0f0h,0f0h,0f0h,03fh,03fh,0cfh,0c7h	; 69a0  ppppss......??..
	defb 060h,060h,0f0h,0f0h,03fh,03fh,0cfh,07fh,0f0h,0f0h,0f0h,0f0h,03fh,03fh,0cfh,0c7h	; 69b0  ``..??......??..
	defb 0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0cfh	; 69c0  ................
	defb 0c7h,0c7h,0cfh,0cfh,0c7h,0c7h,07fh,0cfh,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0cfh	; 69d0  ................
	defb 0b7h,0bfh,0afh,0bfh,0bfh,0afh,0bfh,0bfh,0fbh,0bfh,0afh,0bfh,0bfh,0afh,0bfh,0bfh	; 69e0  ................
	defb 0fch,0fch,0fch,0fch,0fch,0fch,0fch,0fch,0bfh,0bfh,0afh,0bfh,0bfh,0afh,0bfh,0bfh	; 69f0  ................
	defb 060h,060h,0f0h,0f0h,03fh,03fh,0cfh,0cfh,06fh,06fh,096h,090h,090h,090h,090h,090h	; 6a00  ``..??..oo......
	defb 096h,06fh,096h,096h,060h,060h,060h,060h,06fh,096h,06fh,060h,060h,0f0h,0f0h,0f0h	; 6a10  .o..````o.o``...
	defb 060h,060h,060h,060h,060h,060h,060h,060h,090h,090h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 6a20  ````````........
	defb 060h,060h,0f0h,0f0h,0f0h,0f0h,0f0h,090h,09fh,09fh,09fh,09fh,09fh,0a9h,0b9h,0b9h	; 6a30  ``..............
	defb 060h,096h,096h,096h,06fh,06fh,06fh,06fh,0f0h,09fh,09fh,09fh,06fh,06fh,06fh,06fh	; 6a40  `...oooo....oooo
	defb 096h,096h,096h,096h,06fh,06fh,06fh,06fh,060h,096h,096h,096h,06fh,096h,06fh,06fh	; 6a50  ....oooo`...o.oo
	defb 096h,096h,096h,096h,096h,06fh,06fh,06fh,060h,060h,060h,060h,0f0h,0f0h,0f0h,0f0h	; 6a60  .....ooo````....
	defb 06fh,06fh,06fh,090h,090h,090h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,060h	; 6a70  ooo............`
	defb 060h,060h,060h,060h,063h,063h,0c6h,0c6h,090h,090h,090h,090h,093h,093h,0c9h,0c9h	; 6a80  ````cc..........
	defb 06fh,06fh,06fh,06fh,06fh,063h,0c6h,0c6h,0f0h,0f0h,070h,070h,073h,073h,0c7h,0c7h	; 6a90  oooooc....ppss..
	defb 060h,060h,060h,060h,060h,0f0h,0f0h,0f0h,06fh,06fh,06fh,090h,090h,090h,090h,090h	; 6aa0  `````...ooo.....
	defb 0f0h,0f0h,0f0h,0f0h,090h,090h,090h,090h,070h,070h,070h,070h,073h,073h,0c7h,0c7h	; 6ab0  ........ppppss..
	defb 090h,09fh,09fh,096h,096h,096h,096h,096h,096h,096h,096h,096h,096h,06fh,06fh,06fh	; 6ac0  .............ooo
	defb 0fbh,0bfh,0afh,0bfh,0bfh,0afh,0bfh,0bfh,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h,0c7h	; 6ad0  ................
	defb 060h,060h,060h,060h,063h,063h,0c6h,0c6h,090h,090h,090h,090h,093h,093h,0c9h,0c9h	; 6ae0  ````cc..........
	defb 096h,090h,0f0h,0f0h,03fh,03fh,0cfh,0cfh,0b7h,0bfh,0afh,0bfh,0bfh,0afh,0bfh,0bfh	; 6af0  ....??..........
	defb 090h,090h,090h,090h,093h,093h,0cfh,0cfh,060h,060h,060h,060h,063h,063h,0cfh,0cfh	; 6b00  ........````cc..
	defb 090h,090h,090h,090h,093h,093h,0c9h,0c9h,06fh,06fh,060h,060h,063h,06fh,06fh,06fh	; 6b10  ........oo``cooo
	defb 096h,096h,096h,096h,06fh,096h,06fh,06fh,06fh,06fh,06fh,06fh,06fh,096h,096h,096h	; 6b20  ....o.ooooooo...
	defb 06fh,06fh,06fh,060h,060h,060h,060h,060h,090h,090h,090h,090h,090h,090h,090h,090h	; 6b30  ooo`````........
	defb 060h,096h,096h,096h,06fh,06fh,06fh,06fh,06fh,06fh,06fh,06fh,060h,060h,060h,060h	; 6b40  `...oooooooo````
	defb 060h,096h,096h,096h,096h,06fh,06fh,06fh,090h,09fh,096h,096h,06fh,06fh,06fh,06fh	; 6b50  `....ooo....oooo
	defb 06fh,06fh,06fh,06fh,06fh,060h,060h,060h,06fh,06fh,06fh,060h,090h,090h,090h,090h	; 6b60  ooooo```ooo`....
	defb 06fh,06fh,06fh,090h,090h,090h,090h,090h,090h,090h,090h,090h,0f0h,0f0h,090h,090h	; 6b70  ooo.............
	defb 0f0h,0f0h,0f0h,0f0h,0f3h,0f3h,0fch,0fch,0f0h,0f0h,0f0h,0f0h,03fh,03fh,0cfh,0cfh	; 6b80  ............??..
	defb 090h,0f0h,070h,070h,073h,073h,0c7h,0c7h,090h,090h,090h,090h,093h,093h,0c9h,0c9h	; 6b90  ..ppss..........
	defb 0f0h,0f0h,0f0h,0f0h,0f3h,0f3h,0fch,0fch,06fh,096h,096h,060h,060h,060h,0f0h,0f0h	; 6ba0  ........o..```..
	defb 06fh,06fh,06fh,090h,090h,090h,090h,090h,090h,090h,090h,090h,0f0h,0f0h,0f0h,0f0h	; 6bb0  ooo.............
	defb 090h,09fh,09fh,09fh,06fh,06fh,06fh,06fh,06fh,06fh,06fh,060h,060h,060h,060h,060h	; 6bc0  ....ooooooo`````
	defb 0f0h,090h,090h,090h,090h,09fh,096h,096h,06fh,06fh,06fh,090h,090h,090h,090h,090h	; 6bd0  ........ooo.....
	defb 06fh,096h,096h,096h,096h,096h,096h,09fh,090h,090h,090h,090h,0c0h,0c0h,0c0h,0c9h	; 6be0  o...............
	defb 07fh,070h,050h,070h,0c7h,0c7h,0c7h,0c7h,0f0h,0f0h,050h,0f0h,0f3h,0f3h,0fch,0fch	; 6bf0  .pPp......P.....
	defb 0f0h,0c0h,0c0h,0c0h,0c0h,0c0h,0f0h,0f0h,0c0h,0cfh,0c0h,0cfh,0c0h,0c0h,0c0h,060h	; 6c00  ...............`
	defb 0f0h,0f0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0f0h,090h,060h,060h,060h,060h,060h,060h	; 6c10  ..........``````
	defb 060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,0f0h,0f0h,0f0h,0f0h	; 6c20  ````````````....
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; 6c30  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,060h,060h,0c0h,0c0h,0cfh,0c0h,0c0h,0c0h,0f0h,0f0h	; 6c40  ......``........
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,070h,030h,030h,0e0h,0e0h,0e0h,0e0h,0f0h,070h,0c0h,0c0h	; 6c50  .....p00.....p..
	defb 060h,060h,060h,060h,060h,060h,060h,0f0h,0c0h,0c0h,0c0h,0c0h,060h,060h,0f0h,0f0h	; 6c60  ```````.....``..
	defb 090h,090h,090h,090h,090h,090h,090h,090h,060h,060h,060h,060h,060h,060h,060h,060h	; 6c70  ........````````
	defb 0c0h,0c0h,0cfh,0c0h,0c0h,0c0h,0cfh,0c0h,0c3h,0c7h,0c3h,0c7h,0cfh,0c3h,0c7h,0c3h	; 6c80  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c7h,0c3h,0c7h,0c3h,0c3h,0c7h,0c3h,0c3h,0c7h,0c3h,0c7h,0c3h	; 6c90  ................
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0cfh,0c7h,0c3h,0c0h,0c0h,0c0h,0c0h,0c0h,0c3h,0c7h,0c3h	; 6ca0  ................
	defb 0f0h,0f0h,0c0h,0c0h,0c0h,0c0h,0c7h,0cfh,0f0h,09fh,06fh,06fh,06fh,06fh,06fh,06fh	; 6cb0  ..........oooooo
	defb 0f0h,0f0h,040h,040h,040h,040h,040h,040h,0f0h,0f0h,040h,040h,040h,040h,040h,040h	; 6cc0  ..@@@@@@..@@@@@@
	defb 040h,040h,040h,040h,054h,054h,054h,054h,0f0h,0f0h,040h,040h,040h,040h,040h,040h	; 6cd0  @@@@TTTT..@@@@@@
	defb 040h,040h,040h,04fh,040h,04fh,04fh,0f0h,0f0h,090h,060h,060h,060h,060h,060h,060h	; 6ce0  @@@O@OO...``````
	defb 0f0h,09fh,0f6h,0e6h,0e6h,0feh,0efh,06fh,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; 6cf0  .......o........
	defb 0f0h,0f0h,0e0h,0e0h,0e0h,0e0h,0e0h,0efh,0f0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0efh	; 6d00  ................
	defb 0e0h,0e0h,0e0h,0efh,0efh,0efh,0efh,0efh,06fh,06fh,06fh,060h,060h,060h,060h,060h	; 6d10  ........ooo`````
	defb 030h,0c0h,0c0h,0f0h,030h,0c0h,0c0h,0f0h,0f0h,0f0h,0f0h,0f0h,0e0h,0e0h,0e0h,0e0h	; 6d20  0...0...........
	defb 030h,0c0h,0c0h,0f0h,030h,0c0h,0c0h,0f0h,0f0h,090h,060h,060h,060h,060h,060h,060h	; 6d30  0...0.....``````
	defb 0f0h,0f0h,07fh,0f7h,0f7h,07fh,0f0h,0f0h,0f0h,0f0h,070h,0f0h,070h,0f0h,0f0h,0f0h	; 6d40  ..........p.p...
	defb 0f0h,0f0h,0f0h,0f0h,070h,070h,0f0h,0f0h,0f0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h	; 6d50  ....pp..........
	defb 0f0h,0f0h,070h,0f0h,070h,070h,0f0h,0f0h,0f0h,0f0h,070h,0f0h,070h,0f0h,0f0h,0f0h	; 6d60  ..p.pp....p.p...
	defb 0f0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b7h,0fbh,0b7h,0b7h,0b0h,0b0h	; 6d70  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; 6d80  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; 6d90  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0efh,0e0h,0efh,0e0h,0e0h,070h,0c7h,070h	; 6da0  .............p.p
	defb 0ffh,0f0h,0feh,0e0h,0e0h,070h,0c7h,070h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h	; 6db0  .....p.p........
	defb 0f0h,0f0h,0feh,0feh,0feh,0feh,0feh,0feh,0c7h,0f0h,0f6h,0f6h,0f6h,0fch,0fch,0fch	; 6dc0  ................
	defb 0c7h,0f0h,0f6h,0f6h,0e6h,0e3h,0e3h,0e3h,0e0h,0e0h,0e0h,0feh,0feh,0feh,0feh,0feh	; 6dd0  ................
	defb 0feh,0feh,0feh,0f0h,07fh,0c0h,0cfh,0f0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 6de0  ................
	defb 030h,030h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0feh,0feh,0feh,0f0h,07fh,0c0h,0cfh,0f0h	; 6df0  00..............
	defb 03fh,030h,030h,030h,030h,030h,030h,03fh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 6e00  ?000000?........
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,03fh,030h,030h,030h,030h,030h,030h,03fh	; 6e10  ........?000000?
	defb 0f0h,030h,0c0h,0c0h,0f0h,030h,0c0h,0c0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 6e20  .0...0..........
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,070h,074h,05fh,04fh,074h,074h,075h,075h	; 6e30  ........pt_Ottuu
	defb 0f0h,0ffh,0ffh,0f0h,0f0h,0feh,0feh,0f0h,0feh,0ffh,0feh,0f0h,0f0h,0feh,0feh,0f0h	; 6e40  ................
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,075h,075h,075h,075h,075h,050h,050h,0f0h	; 6e50  ........uuuuuPP.
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,070h,0c7h,0f0h,0e0h,0e0h,0e0h,070h,0e0h,070h,0c7h	; 6e60  ......p.....p.p.
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0efh,0feh,0feh,0efh,0efh,0efh,0efh,0efh,0efh,0efh,0efh	; 6e70  ................
	defb 070h,0c7h,0c7h,0c7h,060h,0f6h,0f6h,0e6h,070h,0c7h,0c7h,0c7h,0f0h,0ffh,0ffh,0ffh	; 6e80  p...`...p.......
	defb 0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0efh	; 6e90  ................
	defb 0e6h,0ech,0ech,0ech,0c0h,0c0h,0c0h,0c0h,0feh,0feh,0feh,0ech,0ech,0ech,0ech,0c0h	; 6ea0  ................
	defb 0feh,0feh,0feh,0ffh,0ffh,0feh,0feh,0feh,0e0h,0efh,0e0h,0efh,0feh,0feh,0feh,0feh	; 6eb0  ................
	defb 0cfh,0f0h,0f0h,0f0h,0f0h,0f0h,060h,0f0h,0c0h,0e0h,070h,070h,0c0h,0c0h,0c0h,0c0h	; 6ec0  ......`...pp....
	defb 0feh,0feh,07fh,070h,0f0h,0cfh,0c0h,0c0h,0feh,0feh,07fh,070h,0f0h,0cfh,0c0h,0c0h	; 6ed0  ...p.......p....
	defb 060h,0f0h,060h,060h,060h,0f0h,060h,0f0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 6ee0  `.```.`.........
	defb 04fh,04fh,04fh,04fh,04fh,04fh,04fh,0f0h,0cfh,0cfh,0cfh,0cfh,0cfh,0cfh,0f0h,0f0h	; 6ef0  OOOOOOO.........
	defb 0ffh,0ffh,0ffh,0f0h,0f0h,0ffh,0f0h,0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 6f00  ................
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 6f10  ................
	defb 040h,040h,040h,0f0h,0f0h,040h,0f0h,040h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 6f20  @@@..@.@........
	defb 0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0e0h,0feh,0feh,0feh,0e0h,0e0h,0feh,0e0h,0feh	; 6f30  ................
	defb 0e0h,0e0h,0e0h,0f0h,0f0h,0e0h,0f0h,0e0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 6f40  ................
	defb 0feh,0feh,0efh,0e0h,0e0h,0feh,0feh,0f0h,0f0h,0feh,0feh,0e0h,0e0h,0efh,0efh,0f0h	; 6f50  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0feh,0ffh,0feh,0feh,0feh,0feh,0feh	; 6f60  ................
	defb 0f0h,0f0h,0f0h,0f0h,070h,0f0h,070h,0c7h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,070h,0c7h	; 6f70  ....p.p.......p.
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0ffh,0ffh,0ffh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh	; 6f80  ................
	defb 070h,0c7h,0c7h,0c7h,0f0h,0ffh,0ffh,0feh,070h,0c7h,0c7h,0c7h,060h,0f6h,0f6h,0f6h	; 6f90  p.......p...`...
	defb 0feh,0feh,0feh,0feh,0feh,0feh,0efh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh,0feh	; 6fa0  ................
	defb 0feh,0feh,0feh,0fch,0fch,0fch,0fch,0c0h,0f6h,0fch,0fch,0fch,0c0h,0c0h,0c0h,0c0h	; 6fb0  ................
	defb 0feh,0feh,07fh,070h,0f0h,0cfh,0c0h,0c0h,0feh,0feh,07fh,070h,0f0h,0cfh,0c0h,0c0h	; 6fc0  ...p.......p....
	defb 0c0h,0f0h,070h,070h,0c0h,0c0h,0c0h,0c0h,0cfh,0f0h,0f0h,0f0h,0f0h,0f0h,060h,0f0h	; 6fd0  ..pp..........`.
	defb 060h,060h,060h,060h,060h,060h,060h,060h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h	; 6fe0  ````````........
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,060h,0f0h,060h,060h,060h,0f0h,060h,0f0h	; 6ff0  ........`.```.`.
	defb 000h,000h,000h,000h,000h,018h,00dh,03fh,008h,00ch,00eh,00fh,00fh,01bh,07fh,0ffh	; 7000  .......?........
	defb 000h,000h,001h,00bh,080h,0feh,0fch,0f8h,01fh,0bfh,0ffh,03fh,03fh,01fh,05fh,07fh	; 7010  ...........??._.
	defb 0ffh,0e5h,03fh,080h,0fch,0feh,0ffh,0ffh,0e0h,0f0h,0f8h,010h,028h,016h,08eh,0fch	; 7020  ..?.........(...
	defb 000h,000h,000h,000h,000h,000h,030h,038h,06fh,037h,01fh,00fh,00fh,007h,00fh,01fh	; 7030  ......08o7......
	defb 0ffh,0ech,0e0h,0ffh,0ffh,0ffh,080h,0c0h,080h,000h,000h,0fch,0f8h,0f0h,0e0h,0f4h	; 7040  ................
	defb 01ch,03ch,01eh,01eh,03fh,03fh,07fh,0ffh,03fh,07fh,07fh,0deh,0edh,0f7h,0ffh,07fh	; 7050  .<..??..?.......
	defb 0e1h,0e3h,0e7h,0c7h,0c7h,087h,083h,001h,0fch,0f0h,0ffh,0ffh,0ffh,0feh,0f8h,0e0h	; 7060  ................
	defb 0ffh,07fh,01bh,00dh,00dh,0fch,0f0h,0e0h,03fh,07fh,07fh,07fh,055h,003h,000h,000h	; 7070  ........?...U...
	defb 000h,000h,000h,000h,000h,000h,000h,000h,080h,007h,0ffh,0ffh,0ffh,0f8h,0ebh,03fh	; 7080  ...............?
	defb 047h,0f7h,0beh,0feh,0beh,0ffh,0b8h,0e0h,0f0h,0f8h,038h,0b8h,038h,0f8h,0f0h,000h	; 7090  G.........8.8...
	defb 0ffh,000h,07fh,0ffh,03fh,080h,081h,0c3h,03fh,07fh,06fh,01fh,07fh,0ffh,0ffh,07fh	; 70a0  ....?...?.o.....
	defb 0e0h,0e0h,0e0h,0f0h,0f8h,0feh,00fh,0ffh,0f8h,0f0h,0e0h,0c0h,0e0h,0f0h,0f8h,0fch	; 70b0  ................
	defb 000h,00ch,004h,03dh,09fh,0ffh,03fh,07fh,000h,001h,001h,003h,003h,002h,0c0h,0ffh	; 70c0  ...=..?.........
	defb 080h,080h,0c0h,0c0h,0c0h,0e0h,0f4h,003h,000h,000h,000h,000h,000h,000h,080h,080h	; 70d0  ................
	defb 07fh,01fh,05fh,07fh,05fh,06fh,03fh,01fh,0cfh,082h,0feh,0f0h,0f8h,0f8h,0fch,0feh	; 70e0  .._._o?.........
	defb 03fh,0e0h,0c0h,070h,0a0h,0a0h,0b0h,078h,01fh,01fh,073h,07ch,0ffh,0ffh,0fbh,0fbh	; 70f0  ?..p...x..s|....
	defb 067h,037h,01bh,00bh,007h,00fh,01ch,03bh,0feh,0feh,0feh,0feh,0feh,0feh,0beh,0deh	; 7100  g7.....;........
	defb 080h,000h,000h,0fch,0f8h,0f0h,0e0h,0f0h,03fh,005h,007h,007h,007h,00fh,057h,077h	; 7110  ........?.....Ww
	defb 03fh,03fh,03fh,03fh,01fh,03fh,03fh,03fh,0dch,0fch,0f9h,0f9h,001h,0ffh,0ffh,0ffh	; 7120  ????.???........
	defb 0f8h,0fch,0feh,0feh,0ffh,0ffh,03fh,0f8h,0ffh,050h,0f0h,0f0h,0f0h,0e3h,0fbh,0f8h	; 7130  ......?..P......
	defb 07fh,07fh,07fh,07fh,0ffh,0ffh,01fh,03fh,0ech,0c0h,0ffh,0f0h,083h,0f8h,0efh,0fch	; 7140  .......?........
	defb 0f8h,000h,0e0h,0e0h,0c0h,080h,0d0h,0e0h,0ffh,0ffh,0ffh,0ffh,0ffh,001h,02bh,000h	; 7150  ..............+.
	defb 0f7h,08fh,0ffh,07fh,07fh,080h,0e0h,0f8h,0c3h,0c7h,0e7h,0e7h,0e3h,0e0h,0e0h,0f0h	; 7160  ................
	defb 0f0h,0f8h,0f8h,0fch,0fch,0fch,0f4h,07eh,000h,000h,000h,000h,000h,000h,0feh,0ffh	; 7170  .......~........
	defb 00fh,00fh,00fh,0f5h,0bfh,01fh,00fh,007h,0e0h,0e0h,0e0h,05fh,0ffh,0abh,0feh,0feh	; 7180  ..........._....
	defb 076h,0ffh,0f7h,0ffh,0e0h,0a0h,000h,000h,0c7h,0d7h,0c7h,0ffh,0feh,000h,000h,000h	; 7190  v...............
	defb 007h,00fh,00eh,001h,00fh,01fh,01fh,00fh,0feh,0feh,0feh,0feh,0ffh,03fh,00fh,0ffh	; 71a0  .............?..
	defb 000h,000h,000h,000h,000h,0c0h,0e0h,0e0h,07fh,037h,0cfh,00fh,003h,001h,03fh,001h	; 71b0  .........7....?.
	defb 0feh,0feh,0feh,0fch,0fch,0ech,0d8h,058h,000h,003h,003h,007h,00fh,00fh,0dfh,0ffh	; 71c0  .......X........
	defb 010h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,001h,001h,000h,000h,000h	; 71d0  ................
	defb 010h,07eh,06eh,0ffh,0ffh,0ffh,010h,000h,07fh,0ffh,01ch,014h,01ch,0ffh,07fh,01ch	; 71e0  .~n.............
	defb 000h,000h,000h,000h,000h,008h,01ch,01ch,01ch,008h,000h,000h,000h,000h,000h,000h	; 71f0  ................
	defb 000h,000h,000h,001h,001h,000h,000h,000h,000h,001h,00ch,007h,02fh,03fh,01fh,07fh	; 7200  ............/?..
	defb 000h,080h,080h,0a0h,0e0h,0c0h,0f0h,0fch,001h,000h,002h,007h,007h,003h,000h,000h	; 7210  ................
	defb 000h,000h,007h,007h,007h,000h,000h,000h,03fh,09fh,0ffh,0bfh,0dfh,07fh,0ffh,0ffh	; 7220  ........?.......
	defb 0fdh,0f0h,0f0h,0fch,0feh,0fch,0ffh,0f3h,000h,000h,0f0h,0e0h,0f8h,0fdh,0e0h,0e0h	; 7230  ................
	defb 000h,001h,003h,007h,007h,00fh,00fh,00fh,0ffh,0fdh,0fch,0feh,0f7h,07bh,07dh,03eh	; 7240  .............{}>
	defb 0f0h,0f1h,07ah,01ch,00fh,0c3h,0e0h,0f0h,0e0h,040h,080h,080h,0c0h,0c0h,000h,000h	; 7250  ..z......@......
	defb 00fh,007h,003h,009h,00eh,00fh,00fh,00fh,01fh,07fh,03fh,03fh,01fh,08fh,043h,01fh	; 7260  ..........??..C.
	defb 07ch,030h,098h,0dch,0ceh,0e3h,0fdh,0f8h,000h,000h,000h,000h,000h,002h,03fh,0ddh	; 7270  |0............?.
	defb 00fh,00fh,01fh,01fh,01fh,03fh,03fh,03fh,00fh,003h,0fdh,0ffh,0ffh,0fah,0fch,0afh	; 7280  .....???........
	defb 0f8h,0f8h,057h,0fch,0f8h,0a0h,0feh,0d4h,0ffh,002h,03fh,002h,000h,000h,000h,000h	; 7290  ..W.......?.....
	defb 07fh,037h,09fh,01fh,007h,0ffh,03fh,001h,0fbh,0f3h,0e7h,0cfh,0efh,0f7h,078h,0fch	; 72a0  .7....?.......x.
	defb 080h,080h,0c0h,0e0h,0f8h,0fch,0fch,000h,00ah,00eh,0ffh,03fh,00eh,00eh,004h,000h	; 72b0  ...........?....
	defb 00fh,00fh,00fh,0f5h,0bfh,01fh,07fh,0ffh,0e0h,0e0h,0e0h,05fh,0ffh,0abh,0f7h,0f7h	; 72c0  ..........._....
	defb 076h,0ffh,0f7h,0ffh,0e0h,080h,0f8h,0fch,0c7h,0d7h,0c7h,0ffh,0feh,000h,000h,070h	; 72d0  v..............p
	defb 07ch,03fh,07fh,07fh,0ffh,01fh,001h,007h,0efh,0c7h,083h,000h,080h,0c0h,0e0h,0f0h	; 72e0  |?..............
	defb 0ffh,07fh,07fh,07fh,030h,0feh,078h,000h,0f0h,0e0h,0c0h,0c0h,080h,000h,000h,000h	; 72f0  ....0.x.........
	defb 000h,000h,000h,00ch,01ch,038h,068h,0cfh,000h,000h,000h,001h,001h,003h,007h,007h	; 7300  .....8h.........
	defb 000h,000h,080h,080h,080h,080h,080h,000h,0cfh,0e3h,0f8h,0feh,0ffh,0ffh,0ffh,0ffh	; 7310  ................
	defb 0c7h,0c7h,0e3h,0ffh,0ffh,0ffh,0ffh,0ffh,07fh,0ffh,0ffh,0ffh,0ffh,0feh,07eh,07fh	; 7320  ..............~.
	defb 000h,080h,0e0h,0f8h,0f8h,07ch,000h,087h,0ffh,0ffh,0ffh,01fh,0c1h,0fch,0fch,0fch	; 7330  .....|..........
	defb 07fh,03fh,01fh,00fh,007h,01fh,07fh,003h,07fh,07fh,03fh,01fh,007h,0c3h,0ffh,0ffh	; 7340  .?........?.....
	defb 0ffh,0ffh,000h,040h,0ffh,0feh,000h,080h,0c0h,0f0h,000h,000h,080h,000h,000h,000h	; 7350  ...@............
	defb 007h,00fh,00fh,007h,003h,003h,0ffh,0ffh,0efh,0f7h,0f7h,0ebh,0f9h,0d4h,0eah,0ffh	; 7360  ................
	defb 0c0h,0e8h,0fch,0f8h,0fch,079h,03dh,001h,000h,000h,000h,080h,080h,080h,080h,080h	; 7370  .....y=.........
	defb 007h,0ffh,003h,0dfh,087h,083h,07ch,05ch,0ffh,0ffh,0feh,0feh,0fch,0f8h,001h,000h	; 7380  ......|\........
	defb 083h,0e7h,0ffh,0ffh,0feh,0feh,0fch,03ch,080h,080h,000h,000h,000h,000h,000h,000h	; 7390  .......<........
	defb 07ch,05ch,0fch,0bch,0fch,0bbh,0d5h,07fh,000h,000h,000h,00eh,01fh,0f5h,053h,0e0h	; 73a0  |\............S.
	defb 000h,000h,000h,000h,000h,080h,060h,0f0h,07ch,05ch,07ch,05ch,07ch,03ch,05ch,07ch	; 73b0  ......`.|\|\|<\|
	defb 0f8h,0feh,0f8h,0feh,0f8h,07eh,000h,0fch,003h,003h,003h,003h,003h,003h,003h,003h	; 73c0  .....~..........
	defb 000h,000h,000h,000h,000h,000h,0f0h,0e0h,038h,0f8h,0b0h,0f0h,0b0h,0d8h,06fh,03fh	; 73d0  ........8.....o?
	defb 0feh,0fdh,0feh,0ffh,07fh,00fh,003h,0ffh,0c0h,0c0h,0c0h,080h,000h,000h,000h,000h	; 73e0  ................
	defb 000h,000h,000h,000h,000h,080h,0c0h,0c0h,000h,000h,004h,00eh,00eh,03fh,0bfh,04eh	; 73f0  .............?.N
	defb 000h,000h,000h,000h,000h,003h,007h,00eh,0ffh,0ffh,0ffh,0ffh,001h,0ffh,0ffh,0fch	; 7400  ................
	defb 0feh,0ffh,0feh,0cfh,000h,003h,0ffh,0ffh,000h,000h,000h,000h,000h,0c0h,0e0h,0e0h	; 7410  ................
	defb 05fh,03fh,01fh,003h,01fh,0f8h,0fch,000h,0f0h,0c0h,001h,007h,01fh,080h,03ch,0feh	; 7420  _?............<.
	defb 0ffh,0ffh,000h,03fh,00fh,00fh,007h,00fh,0e0h,0c0h,020h,0f8h,0f8h,0f0h,0c0h,000h	; 7430  ...?...... .....
	defb 007h,01fh,03dh,076h,0f8h,0d0h,0ffh,07fh,0e3h,061h,080h,000h,000h,000h,0e0h,0c0h	; 7440  ..=v.....a......
	defb 0e0h,0f8h,07ch,000h,000h,000h,000h,000h,000h,000h,000h,000h,008h,00ch,00eh,00bh	; 7450  ..|.............
	defb 000h,000h,000h,000h,000h,000h,0e0h,03ch,0fch,0feh,0feh,0ffh,080h,0e0h,0f0h,0f0h	; 7460  .......<........
	defb 000h,000h,000h,000h,000h,000h,002h,003h,008h,00ch,00eh,007h,003h,003h,001h,000h	; 7470  ................
	defb 09eh,0cfh,0e3h,0f9h,0fah,0f1h,0c0h,000h,000h,080h,0e0h,0f8h,0ffh,0afh,07ah,007h	; 7480  ..............z.
	defb 000h,000h,000h,000h,000h,0ffh,0feh,080h,000h,000h,000h,000h,0c0h,0f0h,0f0h,000h	; 7490  ................
	defb 003h,001h,001h,001h,003h,00fh,01fh,03fh,080h,0c0h,0c0h,0f8h,03fh,0ffh,0ffh,0fch	; 74a0  .......?....?...
	defb 000h,000h,000h,000h,000h,0e0h,0f0h,08fh,000h,000h,000h,000h,000h,000h,000h,0c0h	; 74b0  ................
	defb 0e0h,03fh,03fh,07fh,0ffh,0ffh,0ffh,07fh,0fch,0fch,0ffh,0ffh,07fh,07fh,03fh,03fh	; 74c0  .??...........??
	defb 01fh,07fh,0feh,0f0h,000h,020h,0ffh,0ffh,0e0h,080h,000h,000h,000h,000h,0c0h,000h	; 74d0  ..... ..........
	defb 07fh,03fh,01fh,003h,001h,003h,003h,003h,01eh,0ffh,003h,00fh,0ffh,0ffh,0fbh,0f1h	; 74e0  .?..............
	defb 0c0h,0f0h,0f8h,0fch,0feh,0ffh,0ffh,0ffh,000h,020h,030h,030h,018h,01ch,09ch,09eh	; 74f0  ......... 00....
	defb 003h,003h,003h,003h,003h,003h,003h,003h,000h,000h,000h,000h,000h,000h,003h,01fh	; 7500  ................
	defb 008h,018h,038h,070h,070h,0f0h,0f0h,0f8h,000h,000h,000h,000h,000h,000h,000h,002h	; 7510  ..8pp...........
	defb 000h,001h,03eh,07fh,01fh,007h,000h,000h,003h,007h,01fh,007h,0cfh,0ffh,0ffh,00fh	; 7520  ..>.............
	defb 0feh,0ffh,0ffh,0ffh,0ffh,07fh,03fh,07fh,006h,00eh,09ah,0f2h,086h,00eh,09ch,0f8h	; 7530  ......?.........
	defb 000h,03fh,00fh,000h,000h,000h,000h,000h,04fh,0ffh,0ffh,01fh,03fh,07fh,07fh,0ffh	; 7540  .?......O...?...
	defb 07fh,01fh,00fh,00fh,007h,0e1h,0f8h,0ffh,0f8h,0f0h,0c0h,0c0h,080h,004h,00ch,0ffh	; 7550  ................
	defb 080h,080h,0c7h,0feh,0feh,0ffh,03fh,09fh,001h,003h,007h,00fh,007h,007h,083h,003h	; 7560  ......?.........
	defb 0ffh,0ffh,0ffh,0ffh,001h,0ffh,0ffh,0ffh,0feh,0ffh,0feh,0cfh,000h,006h,0e0h,0e0h	; 7570  ................
	defb 000h,000h,000h,001h,001h,000h,000h,000h,05fh,03fh,01fh,007h,057h,0abh,003h,001h	; 7580  ........_?..W...
	defb 0ffh,0ffh,0ffh,0ffh,06fh,0f8h,0fch,0feh,0c0h,0e0h,080h,03fh,00fh,00fh,007h,00fh	; 7590  ....o......?....
	defb 0cch,0e7h,0f3h,0f8h,0feh,0ffh,0ffh,0c0h,000h,000h,000h,000h,001h,003h,007h,00fh	; 75a0  ................
	defb 00fh,07fh,0ffh,0feh,0f8h,0f0h,0c0h,000h,00ch,000h,000h,000h,000h,000h,000h,000h	; 75b0  ................
	defb 003h,003h,003h,001h,000h,000h,000h,000h,0e0h,0f0h,0f8h,0fch,003h,057h,0ffh,0ffh	; 75c0  .............W..
	defb 07fh,007h,01eh,0fch,0feh,0fch,0feh,0feh,09eh,080h,0f8h,0f0h,0e0h,0ffh,0f8h,0c0h	; 75d0  ................
	defb 000h,000h,000h,000h,000h,001h,001h,003h,07fh,07fh,03fh,0fbh,0fbh,0fbh,0fbh,0f3h	; 75e0  ..........?.....
	defb 0feh,0f8h,060h,0e0h,080h,0c0h,0c0h,0e0h,000h,000h,0c0h,0e0h,00ch,01ch,078h,0feh	; 75f0  ..`...........x.
	defb 01fh,00fh,007h,007h,083h,0e3h,0f3h,050h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f8h,0fch	; 7600  .......P........
	defb 0f0h,0f8h,0f8h,0fch,0fch,0fch,0fch,0fch,003h,003h,003h,003h,003h,003h,001h,000h	; 7610  ................
	defb 0ffh,00fh,0ffh,003h,0ffh,0ffh,0ffh,007h,0feh,03fh,01fh,00fh,003h,0ffh,0ffh,0feh	; 7620  .........?......
	defb 0fch,0fch,0fch,0f8h,0f8h,0f0h,0c0h,000h,001h,003h,0ffh,0ffh,0fch,080h,020h,098h	; 7630  .............. .
	defb 007h,00fh,01dh,003h,01fh,03fh,03fh,01fh,0feh,0feh,0fch,0feh,0ffh,0e0h,0f8h,0ffh	; 7640  .....??.........
	defb 000h,000h,000h,000h,000h,0c0h,0e0h,0e0h,0e0h,0c0h,0f8h,0c0h,000h,018h,0f6h,000h	; 7650  ................
	defb 000h,000h,000h,038h,070h,0e0h,0c0h,0c0h,0c0h,0dfh,055h,003h,001h,000h,000h,000h	; 7660  ...8p.....U.....
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,07fh,03fh,03fh,01fh,00fh,007h,003h,0ffh,0ffh,0ffh,0f8h	; 7670  ......??........
	defb 0aah,0feh,0feh,0feh,0feh,0fch,0ffh,0ffh,060h,0c0h,0c4h,0e6h,0eeh,03fh,07fh,01fh	; 7680  ........`....?..
	defb 0e0h,0f0h,0f0h,0f8h,0feh,0ffh,07fh,000h,0ffh,0ffh,0ffh,0ffh,0ffh,07fh,03fh,003h	; 7690  ..............?.
	defb 0ffh,07fh,07fh,07fh,03fh,0c0h,07fh,0ffh,0dfh,0c7h,0f7h,0f7h,0f7h,0f7h,0f7h,00eh	; 76a0  ....?...........
	defb 000h,000h,000h,000h,000h,080h,080h,000h,01fh,00fh,007h,003h,0ffh,0ffh,0ffh,0ffh	; 76b0  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,07fh,0bfh,057h,00fh,00fh,01fh,01fh,01fh,03fh,07fh,0ffh	; 76c0  .......W.....?..
	defb 081h,0c0h,0e0h,0feh,0feh,0fch,0f8h,000h,000h,000h,000h,000h,000h,001h,001h,000h	; 76d0  ................
	defb 0bfh,05fh,0bfh,05fh,0bfh,05fh,0ffh,0ffh,0ffh,0feh,0fch,0fch,0fch,0feh,03fh,01fh	; 76e0  ._._._........?.
	defb 07fh,0ffh,0efh,01fh,0f8h,0feh,0ffh,07fh,0f3h,0e7h,0c7h,0e3h,0f1h,0fch,0feh,0feh	; 76f0  ................
	defb 000h,000h,001h,001h,001h,000h,001h,003h,060h,0c0h,0c4h,0e6h,0eeh,0c0h,080h,0ffh	; 7700  ........`.......
	defb 000h,000h,000h,000h,000h,080h,0f0h,0f8h,01fh,01fh,01fh,03fh,03fh,03fh,03fh,01fh	; 7710  ...........????.
	defb 007h,003h,07fh,060h,0f8h,0fch,0e0h,0c0h,0ffh,0ffh,080h,03fh,0e0h,030h,018h,01eh	; 7720  ...`.......?.0..
	defb 0fch,0feh,0ffh,0ffh,0ffh,0dfh,0c7h,0e3h,000h,000h,000h,000h,080h,080h,080h,0c0h	; 7730  ................
	defb 0c0h,0c0h,0e0h,0f0h,0fch,0e0h,0c0h,080h,01fh,01fh,01fh,01fh,01fh,03fh,03fh,03fh	; 7740  .............???
	defb 0f3h,0c0h,0f0h,0ffh,0c0h,0e0h,0f0h,0f8h,0c0h,0c0h,0c0h,0c0h,000h,000h,000h,000h	; 7750  ................
	defb 07fh,080h,07fh,0bfh,05fh,0f8h,0fch,0feh,03fh,01fh,00fh,00fh,003h,001h,001h,0ffh	; 7760  ...._...?.......
	defb 0fch,0feh,0feh,0ffh,0ffh,0ffh,080h,080h,0ffh,0ffh,080h,0e0h,0c0h,003h,007h,01fh	; 7770  ................
	defb 0feh,0feh,0ffh,0ffh,0ffh,07fh,03fh,003h,0ffh,0abh,003h,001h,0ffh,0ffh,0ffh,0ffh	; 7780  ......?.........
	defb 081h,0c0h,0e0h,0feh,0feh,0fch,0f8h,000h,0fch,0ffh,0ffh,0ffh,0ffh,0ffh,0fch,0f8h	; 7790  ................
	defb 003h,007h,007h,000h,007h,00fh,00fh,007h,0ffh,0ffh,07fh,0ffh,0ffh,0c0h,0f0h,0ffh	; 77a0  ................
	defb 000h,000h,000h,080h,0c0h,0f0h,0f8h,0f8h,008h,000h,0c0h,0fch,000h,080h,0c0h,0e0h	; 77b0  ................
	defb 01fh,01fh,007h,007h,007h,007h,007h,005h,000h,000h,000h,000h,000h,04ch,047h,077h	; 77c0  .............LGw
	defb 000h,000h,000h,000h,03fh,0c0h,080h,0ffh,000h,000h,000h,000h,0c0h,0f0h,0fch,0feh	; 77d0  ....?...........
	defb 000h,000h,003h,001h,003h,007h,00fh,00fh,07fh,03fh,00fh,003h,080h,0f0h,0c1h,080h	; 77e0  .........?......
	defb 001h,003h,0ffh,0ffh,0fch,080h,0e0h,0f8h,0e0h,0c0h,0f8h,0c0h,004h,038h,07ch,030h	; 77f0  .............8|0
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0c0h,0c0h,0c0h,0b0h,060h,0b0h,060h,0b0h,020h,020h,02fh	; 7800  .........`.`.  /
	defb 0f0h,0f0h,030h,030h,0b3h,020h,030h,020h,0c0h,0c0h,0cfh,0c0h,0c0h,060h,090h,090h	; 7810  ..00. 0 .....`..
	defb 02fh,0c6h,092h,0c9h,090h,090h,09fh,09fh,060h,060h,060h,060h,090h,090h,090h,090h	; 7820  /.......````....
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; 7830  ................
	defb 09fh,090h,090h,09fh,09fh,09fh,096h,096h,090h,0f0h,0f0h,090h,090h,090h,060h,030h	; 7840  ..............`0
	defb 090h,090h,090h,090h,090h,090h,090h,09fh,090h,090h,090h,096h,096h,096h,09fh,090h	; 7850  ................
	defb 096h,096h,096h,096h,096h,096h,096h,096h,098h,093h,09fh,09fh,09fh,093h,093h,093h	; 7860  ................
	defb 09fh,093h,093h,093h,093h,030h,030h,030h,090h,090h,095h,094h,094h,0c0h,0f0h,0f0h	; 7870  .....000........
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,093h,053h,05fh,04fh,04fh,0c4h,0c6h,060h	; 7880  .........S_OO..`
	defb 053h,054h,050h,040h,040h,04fh,0c4h,060h,050h,050h,050h,040h,040h,040h,040h,0f0h	; 7890  STP@@O.`PPP@@@@.
	defb 09fh,0f0h,090h,09fh,096h,096h,096h,096h,060h,090h,090h,090h,060h,06fh,06fh,060h	; 78a0  ........`...`oo`
	defb 060h,090h,090h,090h,090h,090h,096h,06fh,060h,090h,090h,090h,090h,090h,090h,060h	; 78b0  `......o`......`
	defb 0f0h,0c0h,0c0h,0c0h,0c0h,0cfh,0c0h,0c0h,0f0h,060h,0a0h,060h,0a0h,062h,0c2h,02fh	; 78c0  .........`.`.b./
	defb 0b0h,090h,0b0h,090h,0b0h,090h,020h,032h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,030h,030h	; 78d0  ...... 2......00
	defb 0c0h,060h,090h,090h,090h,090h,090h,090h,0c6h,0c6h,096h,090h,090h,090h,090h,090h	; 78e0  .`..............
	defb 032h,060h,060h,060h,090h,090h,090h,090h,090h,090h,090h,090h,09fh,09fh,096h,096h	; 78f0  2```............
	defb 090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h,090h	; 7900  ................
	defb 090h,0f0h,0f0h,090h,090h,090h,060h,030h,0c0h,090h,095h,094h,094h,090h,090h,090h	; 7910  ......`0........
	defb 090h,090h,090h,090h,060h,060h,060h,0c0h,090h,096h,096h,096h,096h,06fh,06fh,06fh	; 7920  ....```......ooo
	defb 090h,030h,090h,090h,09fh,09fh,096h,063h,0cfh,090h,095h,094h,094h,090h,090h,090h	; 7930  .0.....c........
	defb 0c0h,0c0h,0c0h,0c0h,0cfh,0cfh,060h,060h,0c3h,0c3h,0cfh,0c3h,0c3h,0c3h,0c6h,060h	; 7940  ......``.......`
	defb 090h,0f0h,090h,090h,090h,060h,030h,090h,03fh,03fh,03fh,03fh,03fh,063h,063h,0f0h	; 7950  .....`0.?????cc.
	defb 096h,096h,09fh,096h,096h,0c9h,0c9h,0c9h,096h,096h,096h,096h,096h,093h,093h,093h	; 7960  ................
	defb 030h,090h,090h,090h,090h,030h,030h,054h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,050h,05fh	; 7970  0....00T......P_
	defb 095h,094h,094h,0c9h,0c0h,0c0h,060h,060h,095h,094h,094h,0c9h,03fh,0c6h,060h,060h	; 7980  ......``....?.``
	defb 054h,04fh,040h,04fh,030h,030h,0f0h,0f0h,050h,040h,040h,04fh,040h,0f0h,0f0h,0f0h	; 7990  TO@O00..P@@O@...
	defb 060h,090h,060h,090h,060h,060h,060h,060h,090h,090h,090h,090h,09fh,096h,096h,06fh	; 79a0  `.`.````.......o
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,090h,090h,060h,060h,090h,090h,096h,096h,096h,060h,060h	; 79b0  .......``.....``
	defb 090h,090h,090h,090h,060h,060h,060h,060h,0f0h,090h,090h,090h,090h,090h,090h,09fh	; 79c0  ....````........
	defb 060h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,060h,060h,0f0h,0f0h,0f0h	; 79d0  `..........``...
	defb 0b0h,054h,054h,04fh,04fh,04fh,0b0h,0f0h,050h,05fh,0b5h,0b4h,0b4h,04fh,040h,0a0h	; 79e0  .TTOOO..P_...O@.
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0b0h,0b0h,0a0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 79f0  ................
	defb 0f0h,0f0h,0f0h,060h,060h,0f0h,0f0h,0f0h,0f0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 7a00  ...``...........
	defb 0f0h,0c0h,0c0h,0c0h,0c0h,0c0h,020h,0c0h,060h,0f0h,060h,060h,060h,060h,0f0h,0f0h	; 7a10  ...... .`.````..
	defb 0f0h,0f0h,050h,040h,040h,0f0h,0f0h,0f0h,0c0h,060h,09fh,090h,090h,090h,09fh,09fh	; 7a20  ..P@@....`......
	defb 020h,0c2h,062h,092h,092h,096h,09fh,090h,0f0h,0f0h,020h,020h,020h,030h,063h,063h	; 7a30   .b.......   0cc
	defb 0f0h,060h,060h,060h,060h,060h,060h,060h,09fh,090h,090h,090h,096h,096h,096h,096h	; 7a40  .```````........
	defb 090h,090h,090h,090h,090h,090h,090h,090h,060h,090h,090h,090h,090h,090h,0f0h,0f0h	; 7a50  ........`.......
	defb 060h,060h,060h,060h,060h,060h,060h,0c0h,096h,096h,096h,096h,096h,096h,096h,065h	; 7a60  ```````........e
	defb 090h,060h,090h,090h,090h,090h,090h,095h,0f0h,0f0h,0f0h,0f0h,0f0h,0b0h,050h,054h	; 7a70  .`............PT
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,060h,064h,064h,0c6h,0cfh,0cfh,0c3h,0c3h,0c6h	; 7a80  .......`dd......
	defb 094h,064h,0c6h,0c3h,0c3h,0c3h,030h,0c0h,04fh,0b4h,040h,030h,0f0h,0f0h,0f0h,0f0h	; 7a90  .d....0.O.@0....
	defb 060h,090h,090h,096h,096h,06fh,060h,060h,060h,060h,090h,090h,090h,090h,096h,060h	; 7aa0  `....o````.....`
	defb 060h,090h,090h,090h,090h,090h,060h,0f0h,0b4h,0b4h,04fh,040h,0b0h,0b0h,0f0h,0f0h	; 7ab0  `.....`...O@....
	defb 095h,094h,094h,0c9h,0c0h,0c0h,060h,06fh,095h,094h,094h,0c9h,0cfh,0c6h,060h,060h	; 7ac0  ......`o......``
	defb 054h,04fh,040h,04fh,0c0h,0c0h,060h,090h,050h,040h,040h,04fh,040h,0f0h,0f0h,090h	; 7ad0  TO@O..`.P@@O@...
	defb 096h,096h,090h,096h,09fh,096h,096h,060h,060h,060h,060h,0f0h,090h,090h,090h,060h	; 7ae0  .......````....`
	defb 09fh,096h,090h,096h,096h,060h,060h,0f0h,090h,090h,090h,060h,060h,0f0h,0f0h,0f0h	; 7af0  .....``....``...
	defb 0f0h,0f0h,0f0h,040h,040h,040h,040h,040h,0f0h,0f0h,0f0h,060h,0b0h,060h,0b0h,064h	; 7b00  ...@@@@@...`.`.d
	defb 0f0h,0f0h,0b0h,060h,0b0h,060h,0b0h,0f0h,0c0h,0c0h,0c0h,0c0h,0cfh,0cfh,0cfh,04fh	; 7b10  ...`.`.........O
	defb 040h,040h,040h,04fh,04fh,04fh,04fh,04fh,054h,05fh,05fh,05fh,05fh,054h,054h,054h	; 7b20  @@@OOOOOT____TTT
	defb 0f0h,050h,050h,050h,050h,040h,0f0h,040h,0cfh,0cfh,0cfh,0c0h,0c0h,0c0h,0c3h,0c3h	; 7b30  .PPPP@.@........
	defb 040h,040h,040h,040h,040h,040h,040h,054h,054h,054h,054h,054h,054h,054h,05fh,05fh	; 7b40  @@@@@@@TTTTTTT__
	defb 05fh,05fh,0f0h,050h,05fh,050h,0f0h,050h,050h,050h,0f0h,0f0h,050h,0f0h,0f0h,0f0h	; 7b50  __.P_P.PPP..P...
	defb 054h,054h,054h,054h,054h,054h,04fh,0bfh,050h,050h,050h,050h,050h,050h,050h,0bfh	; 7b60  TTTTTTO.PPPPPPP.
	defb 050h,050h,050h,050h,050h,050h,050h,050h,0f0h,0f0h,0f0h,050h,050h,050h,050h,050h	; 7b70  PPPPPPPP...PPPPP
	defb 0bah,0afh,0bah,0a5h,0a5h,0a5h,050h,050h,0bfh,0bfh,0b5h,0a5h,0a5h,0a5h,050h,0f0h	; 7b80  ......PP......P.
	defb 050h,050h,05fh,05fh,050h,050h,050h,050h,050h,050h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7b90  PP__PPPPPP......
	defb 050h,050h,050h,050h,050h,050h,050h,050h,0f0h,0f0h,0f0h,050h,050h,050h,050h,050h	; 7ba0  PPPPPPPP...PPPPP
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,050h,050h,050h,050h,050h,050h,050h,050h,050h,050h,050h	; 7bb0  .....PPPPPPPPPPP
	defb 030h,0c0h,0c0h,0c0h,0c0h,0c0h,0f0h,030h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,040h	; 7bc0  0......0.......@
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0a0h,0a0h,050h,050h,050h,050h,050h,050h,050h,050h	; 7bd0  ........PPPPPPPP
	defb 0e0h,0e0h,0feh,0ffh,0feh,0feh,0feh,0efh,040h,040h,040h,040h,0f0h,0f0h,0f0h,0f0h	; 7be0  ........@@@@....
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,050h,050h,050h,0f0h,0f0h,0f0h,0b0h,0b0h,050h,054h,0b5h	; 7bf0  .....PPP.....PT.
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,050h,050h,050h,05fh,05fh,05fh,05fh,0b5h,0bfh,0bfh,0b5h	; 7c00  .....PPP____....
	defb 050h,05fh,050h,050h,0f0h,050h,05fh,05fh,0f0h,0f0h,0f0h,0f0h,0f0h,050h,050h,050h	; 7c10  P_PP.P__.....PPP
	defb 0b4h,0b4h,0b4h,050h,050h,054h,040h,0f0h,0b5h,0b4h,0b4h,0b4h,0b4h,040h,040h,040h	; 7c20  ...PPT@......@@@
	defb 05fh,04fh,0f0h,040h,040h,040h,040h,040h,050h,040h,050h,050h,050h,040h,040h,0f0h	; 7c30  _O.@@@@@P@PPP@@.
	defb 050h,050h,050h,050h,050h,050h,05fh,050h,050h,050h,050h,0f0h,0f0h,0f0h,050h,050h	; 7c40  PPPPPP_PPPP...PP
	defb 050h,050h,050h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,050h,050h,050h,050h	; 7c50  PPP.........PPPP
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,050h,050h,0e0h,0e0h,0e0h,0efh,0feh,0feh,0feh,0e0h	; 7c60  ......PP........
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,070h,040h,040h,040h,040h,040h,040h,040h,040h,0f0h	; 7c70  ......p@@@@@@@@.
	defb 050h,050h,050h,050h,050h,050h,050h,0f0h,0f0h,050h,050h,050h,05fh,050h,050h,050h	; 7c80  PPPPPPP..PPP_PPP
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,05fh,050h,050h,0f0h,0f0h,0f0h,0f0h,0e0h,0e0h,0e0h,0f0h	; 7c90  ....._PP........
	defb 0b0h,060h,0b0h,040h,040h,040h,040h,040h,0b0h,060h,0b0h,040h,054h,05fh,05fh,054h	; 7ca0  .`.@@@@@.`.@T__T
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,050h,040h,040h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,040h	; 7cb0  .....P@@.......@
	defb 054h,040h,040h,040h,04fh,04fh,04fh,040h,050h,054h,05fh,05fh,054h,054h,054h,054h	; 7cc0  T@@@OOO@PT__TTTT
	defb 050h,050h,050h,050h,0f0h,050h,05fh,05fh,050h,050h,0f0h,0f0h,0f0h,0f0h,050h,0f0h	; 7cd0  PPPP.P__PP....P.
	defb 040h,040h,040h,040h,050h,050h,050h,050h,054h,04fh,054h,054h,05fh,05fh,054h,054h	; 7ce0  @@@@PPPPTOTT__TT
	defb 040h,050h,050h,050h,050h,05fh,05fh,05fh,0f0h,050h,050h,050h,050h,050h,050h,050h	; 7cf0  @PPPP___.PPPPPPP
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,040h,040h	; 7d00  ..............@@
	defb 0b0h,060h,0b0h,060h,0b0h,060h,0b0h,050h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,050h	; 7d10  .`.`.`.P.......P
	defb 0f0h,040h,050h,040h,040h,040h,0f0h,0f0h,054h,054h,050h,050h,040h,04fh,04fh,040h	; 7d20  .@P@@@..TTPP@OO@
	defb 050h,05fh,05fh,05fh,05fh,054h,054h,054h,050h,050h,050h,050h,050h,050h,050h,050h	; 7d30  P____TTTPPPPPPPP
	defb 0f0h,040h,040h,0f0h,0f0h,0f0h,0f0h,0f0h,040h,04fh,04fh,040h,040h,040h,040h,04fh	; 7d40  .@@.....@OO@@@@O
	defb 054h,054h,054h,054h,054h,054h,050h,05fh,050h,050h,050h,050h,050h,050h,050h,05fh	; 7d50  TTTTTTP_PPPPPPP_
	defb 0c3h,0c3h,0c3h,0c3h,0c3h,0cfh,0c0h,0c0h,054h,054h,054h,054h,054h,054h,0b4h,0b4h	; 7d60  ........TTTTTT..
	defb 05fh,05fh,05fh,05fh,0b5h,0bfh,0bfh,0bfh,050h,05fh,050h,050h,0f0h,040h,0b4h,0b4h	; 7d70  ____....P_PP.@..
	defb 0f0h,0f0h,0f0h,040h,040h,0f0h,0f0h,0f0h,0b4h,0b4h,0b4h,0b4h,0b4h,040h,040h,040h	; 7d80  ...@@........@@@
	defb 0bfh,0bfh,0bfh,0bfh,0b4h,040h,040h,040h,0b4h,0b5h,0b5h,050h,050h,050h,050h,050h	; 7d90  .....@@@...PPPPP
	defb 030h,030h,030h,030h,030h,03fh,03fh,0c3h,0f0h,0f0h,0f0h,0f0h,050h,050h,050h,050h	; 7da0  00000??.....PPPP
	defb 054h,050h,05fh,050h,050h,050h,050h,0f0h,050h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; 7db0  TP_PPPP.P.......
	defb 050h,050h,050h,050h,0f0h,0f0h,0f0h,0f0h,054h,054h,054h,054h,0b5h,0b5h,0bfh,0bfh	; 7dc0  PPPP....TTTT....
	defb 054h,0b5h,0b4h,0b4h,0b4h,0b4h,0b4h,0b4h,050h,0b5h,054h,054h,054h,04fh,040h,040h	; 7dd0  T.......P.TTTO@@
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,050h,050h,050h,0b4h,0b4h,0b4h,040h,040h,050h,050h,050h	; 7de0  .....PPP...@@PPP
	defb 0b0h,0b0h,040h,040h,040h,050h,050h,050h,0f0h,0f0h,030h,030h,030h,030h,030h,030h	; 7df0  ..@@@PPP..000000
	defb 0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c4h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h	; 7e00  ................
	defb 030h,030h,030h,030h,030h,030h,030h,030h,040h,040h,040h,040h,040h,040h,040h,0f0h	; 7e10  00000000@@@@@@@.
	defb 04fh,054h,04fh,054h,04fh,04fh,04fh,0c0h,0c3h,0c5h,0c4h,0c5h,0c4h,04fh,04fh,0c0h	; 7e20  OTOTOOO......OO.
	defb 030h,030h,0c0h,0c0h,0c0h,040h,040h,0f0h,093h,093h,03fh,03fh,030h,040h,030h,030h	; 7e30  00...@@...??0@00
	defb 0c0h,030h,0c0h,030h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,030h,030h,03fh,0c3h,0c3h,0cfh	; 7e40  .0.0......00?...
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,030h,030h,0c0h,093h,093h,030h,030h,0f0h,090h,090h,0f0h	; 7e50  .....00...00....
	defb 0f0h,0f0h,0f0h,090h,090h,090h,090h,090h,090h,090h,090h,030h,030h,0f0h,0f0h,0f0h	; 7e60  ...........00...
	defb 04fh,04fh,04fh,04fh,04fh,040h,040h,0c0h,0c4h,0c4h,0c4h,0c4h,04fh,04fh,04fh,0c0h	; 7e70  OOOOO@@.....OOO.
	defb 030h,030h,030h,030h,030h,030h,03fh,03fh,030h,060h,030h,060h,030h,030h,030h,030h	; 7e80  000000??0`0`0000
	defb 0c0h,0c0h,030h,030h,030h,03fh,0c0h,0f0h,04fh,04fh,04fh,04fh,04fh,040h,040h,0c0h	; 7e90  ..000?..OOOOO@@.
	defb 03fh,030h,030h,030h,030h,043h,030h,03fh,030h,030h,030h,030h,030h,030h,030h,0c3h	; 7ea0  ?0000C0?0000000.
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,030h,0c0h,0f0h,0c4h,0c4h,0c4h,0c4h,04fh,04fh,04fh,0cfh	; 7eb0  .....0......OOO.
	defb 03fh,03fh,03fh,03fh,03fh,030h,030h,0c0h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0cfh	; 7ec0  ?????00.........
	defb 0c3h,0c3h,0c3h,0c0h,0c0h,040h,040h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0c0h,0c0h,0f0h	; 7ed0  .....@@.........
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,04fh,04fh,0cfh,0c3h,0c3h,0c3h,0c3h,0c3h,0c4h,0c4h	; 7ee0  ......OO........
	defb 0c0h,0cfh,030h,030h,0c3h,0c3h,0cfh,0c0h,0c0h,0c0h,030h,030h,030h,030h,030h,0c0h	; 7ef0  ..00......00000.
	defb 0f0h,0f0h,030h,060h,030h,0f0h,0c0h,0c0h,030h,060h,030h,060h,030h,0c3h,0c3h,03fh	; 7f00  ..0`0...0`0`0..?
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,030h,030h,030h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; 7f10  .....000........
	defb 0c0h,0c5h,040h,0c0h,0c4h,0c3h,0c3h,0c3h,03fh,03fh,043h,030h,043h,0c3h,0c3h,0c3h	; 7f20  ..@.....??C0C...
	defb 030h,030h,03fh,03fh,03fh,030h,030h,030h,0f0h,0f0h,0f0h,0f0h,030h,030h,030h,030h	; 7f30  00???000....0000
	defb 0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h	; 7f40  ................
	defb 030h,0c3h,0c3h,0cfh,0c0h,0c0h,0c0h,030h,030h,030h,030h,030h,0f0h,0f0h,0f0h,0f0h	; 7f50  0......00000....
	defb 030h,0c3h,030h,030h,030h,043h,043h,043h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h,03fh	; 7f60  0.000CCC.......?
	defb 030h,030h,030h,03fh,03fh,03fh,0c3h,0c3h,03fh,03fh,0c3h,0c3h,0c3h,0c3h,0c3h,0c3h	; 7f70  000???..??......
	defb 043h,043h,04fh,04fh,04fh,040h,040h,0c0h,03fh,0c3h,0c4h,0c4h,04fh,04fh,04fh,0cfh	; 7f80  CCOOO@@.?...OOO.
	defb 0c3h,0c3h,0c3h,0c0h,0c0h,040h,040h,0f0h,0c0h,0cfh,0cfh,0cfh,0cfh,0cfh,0c3h,0c3h	; 7f90  .....@@.........
	defb 0c0h,030h,0c0h,0f0h,0c0h,0c0h,0c0h,0c0h,0cfh,0cfh,030h,03fh,03fh,0c3h,0c3h,0cfh	; 7fa0  .0........0??...
	defb 0f0h,0f0h,0f0h,030h,030h,030h,030h,0c0h,090h,0f0h,0c0h,0c0h,0f0h,0c0h,030h,030h	; 7fb0  ...0000.......00
	defb 0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0f0h,0f0h,0f0h,0f0h,0f0h,0c0h,0c0h,0c0h	; 7fc0  ................
	defb 0f0h,0f0h,0f0h,0f0h,030h,0c3h,0c3h,03fh,0f0h,0f0h,0f0h,0f0h,030h,030h,030h,030h	; 7fd0  ....0..?....0000
	defb 0f0h,0f0h,050h,040h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c5h,0c4h,0c0h,0c4h,0c3h,0c3h	; 7fe0  ..P@............
	defb 093h,093h,03fh,03fh,030h,040h,0c0h,0c0h,093h,093h,030h,030h,090h,090h,090h,090h	; 7ff0  ..??0@....00....

; ======================================================================
; CODIGO 0x8000..0x8528  (1320 bytes)
; ======================================================================


arranque_nop:		; 16 "nop": INIT (0x4035) salta a 0x8000 y los recorre hasta el arranque
	nop			;8000   ; 16 "nop": INIT salta aqui (0x4035)
	nop			;8001   ; nop
	nop			;8002
	nop			;8003
	nop			;8004
	nop			;8005
	nop			;8006
	nop			;8007
	nop			;8008
	nop			;8009
	nop			;800a
	nop			;800b
	nop			;800c
	nop			;800d
	nop			;800e
	nop			;800f   ; el ultimo nop
arranque:		; El arranque: la RAM de 0xE000 a 0xF37F a cero, la pila, la interrupcion en H.TIMI, SCREEN 2 en negro, las letras y los sprites, sprites de 16 x 16 con la pantalla apagada, y el record a 10.000
	call 00041h		;8010   ; DISSCR
	ld hl,0e000h		;8013   ; la RAM desde 0xE000...
	ld bc,01380h		;8016   ; ...0x1380 bytes...
L_8019:
	ld (hl),000h		;8019   ; ...a cero
	inc hl			;801b
	dec c			;801c   ; 0x1380 bytes
	jr nz,L_8019		;801d
	djnz L_8019		;801f
	ld sp,0f380h		;8021   ; la pila
	ld hl,08a26h		;8024   ; la interrupcion (0x8A26)...
	ld (0fda0h),hl		;8027   ; ...en H.TIMI...
	ld a,0c3h		;802a   ; ...con su "jp"
	ld (0fd9fh),a		;802c   ; ...0xFD9F
	call 0007eh		;802f   ; SETGRP: SCREEN 2
	xor a			;8032   ; fondo y borde negros...
	ld (0f3eah),a		;8033   ; BAKCLR = 0
	ld (0f3ebh),a		;8036   ; BDRCLR = 0
	dec a			;8039   ; ...letras blancas (0xFF)
	ld (0f3e9h),a		;803a   ; FORCLR = 0xFF
	call 00062h		;803d   ; CHGCLR
	call letras		;8040   ; las letras (0x4B80) en los tres tercios
	call sprites_dibujos		;8043   ; los dibujos de los sprites (0xAA80)
	ld bc,0a201h		;8046   ; el registro 1 = 0xA2: sprites de 16 x 16, la interrupcion, la pantalla apagada
	call 00047h		;8049   ; WRTVDP
	ld a,001h		;804c   ; 0xE030 = 1
	ld (0e030h),a		;804e
	ld a,010h		;8051   ; el record: 0x001000 (10.000 en pantalla, con su cero de detras)
	ld (0e035h),a		;8053
	ei			;8056
inicio:		; El titulo: la presentacion de CASIO, TAB (0xE03A = 2: sin muerte) y CAPS (0xE039 = 2: vidas sin fin), el nombre y los textos, la musica 6; con el boton, la partida; si no, la demostracion en una escena al azar (0-3)
	call sonido_reinicia		;8057   ; el sonido a cero
	call pantalla_limpia		;805a   ; la pantalla apagada y en blanco
	call titulo_dibujos		;805d   ; los dibujos del titulo
	call 00044h		;8060   ; ENASCR
	call presentacion		;8063   ; la presentacion de CASIO
	ld a,007h		;8066   ; la fila 7...
	call 00141h		;8068   ; SNSMAT
	bit 3,a		;806b   ; TAB (bit 3)?
	jr nz,L_8074		;806d   ; suelta
	ld a,002h		;806f   ; pulsada: 0xE03A = 2 (sin muerte)
	ld (0e03ah),a		;8071
L_8074:
	ld a,006h		;8074   ; la fila 6...
	call 00141h		;8076   ; SNSMAT
	bit 3,a		;8079   ; CAPS (bit 3)?
	jr nz,titulo_textos		;807b   ; suelta
	ld a,002h		;807d   ; pulsada: 0xE039 = 2 (vidas sin fin)
	ld (0e039h),a		;807f
titulo_textos:		; El nombre (0x8D6D), CASIO (0x8DB7) en la fila 4, PUSH TRIG:1 OR SPACE (0x8DBD) en la 20, el copyright (0x8DD1) en la 16 y GAME START (0x8DAD) en la 18; la musica 6
	call titulo_nombre		;8082   ; el nombre
	ld hl,08db7h		;8085   ; CASIO...
	ld de,0188dh		;8088   ; ...en la fila 4, columna 13
	ld bc,00006h		;808b   ; 6 casillas
	call 0005ch		;808e   ; LDIRVM
	ld hl,08dbdh		;8091   ; PUSH TRIG:1 OR SPACE...
	ld de,01a86h		;8094   ; ...en la fila 20, columna 6
	ld bc,00014h		;8097   ; 20 casillas
	call 0005ch		;809a   ; LDIRVM
	ld hl,08dd1h		;809d   ; COPYRIGHT 1987 (c) CASIO...
	ld de,01a05h		;80a0   ; ...en la fila 16, columna 5
	ld bc,00016h		;80a3   ; 22 casillas
	call 0005ch		;80a6   ; LDIRVM
	ld de,01a4bh		;80a9   ; GAME START en la fila 18, columna 11
	ld hl,08dadh		;80ac   ; GAME START
	ld bc,0000ah		;80af   ; 10 casillas
	call 0005ch		;80b2   ; LDIRVM
	xor a			;80b5   ; la cuenta de cuadros a 0
	ld (0e010h),a		;80b6
	ld a,006h		;80b9   ; la musica 6 (el titulo)
	call musica_pide		;80bb   ; pedida
	call espera_musica		;80be   ; hasta que acabe o el boton
	ld a,(0e026h)		;80c1   ; el boton de empezar?
	and a			;80c4   ; pulsado?
	jr nz,partida_empieza		;80c5   ; si: la partida
	ld (0e03ah),a		;80c7   ; la demostracion: sin TAB...
	ld (0e039h),a		;80ca   ; ...ni CAPS...
	ld (0e027h),a		;80cd   ; ...0xE027 a 0 (se pone despues)...
	ld (0e051h),a		;80d0   ; ...y 0xE051 a 0
	ld a,r		;80d3   ; el registro R...
	and 003h		;80d5   ; ...de 0 a 3...
	ld (0e003h),a		;80d7   ; ...la escena al azar
	ld hl,04000h		;80da   ; los mandos de la demostracion: desde 0x4000 (la cabecera del cartucho)
	ld (0e037h),hl		;80dd   ; apuntados
	jp escena_empieza		;80e0   ; a la escena
partida_empieza:		; Una partida nueva: jugando (0xE000 = 1), dos vidas de reserva (0xE001), 0xE003-0xE02D y 0xE040-0xE05F a cero
	call sonido_reinicia		;80e3   ; el sonido a cero
	ld a,001h		;80e6   ; jugando...
	ld (0e000h),a		;80e8   ; ...0xE000 = 1
	inc a			;80eb   ; 2...
	ld (0e001h),a		;80ec   ; ...vidas de reserva
	ld hl,0e003h		;80ef   ; desde 0xE003 (la escena)...
	ld b,02bh		;80f2   ; ...43 bytes...
L_80F4:
	ld (hl),000h		;80f4   ; ...a cero
	inc hl			;80f6
	djnz L_80F4		;80f7
	ld hl,0e040h		;80f9   ; 0xE040...
	ld b,020h		;80fc   ; ...32 bytes...
L_80FE:
	ld (hl),000h		;80fe   ; ...a cero
	inc hl			;8100
	djnz L_80FE		;8101
escena_empieza:		; Una escena: la pantalla en blanco, las dos barras llenas (0xE1B5 y 0xE1B7 = 0x40), el marcador, el protagonista (0xE320 y 0xE330: Y 0x70, X 0xA0), el decorado (el del rio, 0x90F1, o el de tierra, 0x91F6, si ya se habia llegado), la musica 2 y al bucle
	call pantalla_limpia		;8103   ; la pantalla apagada y en blanco
	ld a,040h		;8106   ; las dos barras: 0x40 (8 casillas de 8)
	ld (0e1b5h),a		;8108   ; la de arriba
	ld (0e1b7h),a		;810b   ; la de abajo
	call marcador		;810e   ; el marcador
	ld ix,0e320h		;8111   ; IX: el protagonista
	ld (ix+000h),070h		;8115   ; Y 0x70
	ld (ix+001h),0a0h		;8119   ; X 0xA0
	ld (ix+002h),000h		;811d   ; el dibujo 0
	ld (ix+003h),001h		;8121   ; color 1 (el contorno)
	ld (ix+010h),070h		;8125   ; su segundo sprite: Y 0x70...
	ld (ix+011h),0a0h		;8129   ; ...X 0xA0...
	ld (ix+012h),004h		;812d   ; ...el dibujo 4...
	ld (ix+013h),00bh		;8131   ; ...color 0x0B
	ld (ix+004h),001h		;8135   ; los dos, en pantalla
	ld (ix+014h),001h		;8139
	call prota_sprites		;813d   ; los sprites del protagonista, puestos
	ld a,(0e051h)		;8140   ; 0xE051 = 2 (en tierra)?
	cp 002h		;8143
	jr nz,L_8150		;8145   ; no
	ld (ix+003h),005h		;8147   ; si: el contorno en color 5
	call tierra		;814b   ; el decorado de tierra
	jr L_8153		;814e
L_8150:
	call rio_decorado		;8150   ; el del rio
L_8153:
	call puntos_pinta		;8153   ; los puntos
	call prota_vram		;8156   ; los sprites del protagonista
	call 00044h		;8159   ; ENASCR
	ld a,002h		;815c   ; la musica 2 (la escena empieza)
	call musica_pide		;815e   ; pedida
	call espera_musica		;8161   ; hasta que acabe
	xor a			;8164   ; las cuentas y los botones a cero
	ld (0e010h),a		;8165   ; la cuenta de cuadros
	ld (0e022h),a		;8168   ; el boton 1
	ld (0e020h),a		;816b   ; el boton 2
	ld (0e026h),a		;816e   ; el de empezar
	ld (0e180h),a		;8171   ; la palanca
	ld a,(0e000h)		;8174   ; jugando?
	and a			;8177   ; jugando?
	jr nz,bucle		;8178   ; si: al bucle
	inc a			;817a   ; la demostracion: 0xE027 = 1
	ld (0e027h),a		;817b   ; la demostracion
bucle:		; El bucle de la partida: con 0xE184, la escena acabada; con 0xE183, la muerte; con 0xE1B2, la pausa; y una vez por cuadro (0xE011), el sonido de fondo y todo lo demas; fuera de partida, el boton vuelve al titulo
	ld a,(0e184h)		;817e   ; la escena acabada?
	and a			;8181
	jp nz,escena_acabada		;8182   ; si
	ld a,(0e183h)		;8185   ; muerto?
	and a			;8188
	jp nz,muerte		;8189   ; si
	ld a,(0e1b2h)		;818c   ; STOP (la pausa)?
	and a			;818f
	jp nz,pausa_cambia		;8190   ; si
bucle_cuadro:
	ld a,(0e011h)		;8193   ; un cuadro?
	cp 001h		;8196
	jp c,bucle_mira		;8198   ; no: espera
	xor a			;819b   ; la cuenta a 0
	ld (0e011h),a		;819c
	call prota_vram		;819f   ; los sprites del protagonista
	call sonido_fondo		;81a2   ; el sonido de fondo
	ld a,(0e1b4h)		;81a5   ; en pausa?
	and a			;81a8
	jr nz,pausa_parpadeo		;81a9   ; si: solo el parpadeo
	ld a,(0e051h)		;81ab   ; en tierra?
	cp 002h		;81ae
	jr z,L_81B8		;81b0   ; si: sin el rio
	call agua_mueve		;81b2
	call rio_avanza		;81b5
L_81B8:
	call protegido		;81b8   ; el protagonista
	call sonido_fondo		;81bb   ; el sonido de fondo, otra vez
	call enemigos_salen		;81be   ; los objetos
	call enemigos		;81c1   ; los enemigos
	call prota_mueve		;81c4   ; la palanca
	call arma		;81c7
	call salto		;81ca
	call prota_sprites		;81cd   ; sus sprites
	call objeto_tierra		;81d0
	call puntos_pinta		;81d3   ; los puntos
bucle_mira:
	ld a,(0e000h)		;81d6   ; jugando?
	and a			;81d9
	jr nz,bucle		;81da   ; si: otra vuelta
	ld a,(0e026h)		;81dc   ; la demostracion: el boton?
	and a			;81df
	jr z,bucle		;81e0   ; no: otra vuelta
	jp inicio		;81e2   ; si: al titulo
pausa_parpadeo:		; En pausa: el protagonista con el dibujo 8 (0xE016 de 0xE0 a 0xFF) o el 4
	ld a,(0e016h)		;81e5   ; la cuenta de la pausa
	cp 0e0h		;81e8   ; 0xE0 o mas?
	jr c,L_81F6		;81ea
	ld (ix+002h),008h		;81ec   ; el dibujo 8...
	ld (ix+012h),00ch		;81f0   ; ...y su segundo, el 0x0C
	jr bucle_mira		;81f4
L_81F6:
	ld (ix+002h),004h		;81f6   ; el dibujo 4...
	ld (ix+012h),000h		;81fa   ; ...y su segundo, el 0
	jr bucle_mira		;81fe
pausa_cambia:		; STOP: la pausa se pone o se quita (0xE1B4); al quitarla, los sprites de siempre y el protagonista donde estaba; al ponerla, otros dibujos (0x5A00)
	xor a			;8200   ; atendido
	ld (0e1b2h),a		;8201
	ld a,(0e1b4h)		;8204   ; la pausa...
	cpl			;8207   ; ...al reves
	ld (0e1b4h),a		;8208
	and a			;820b   ; puesta?
	jr nz,pausa_pon		;820c   ; si
	call sprites_de_siempre		;820e   ; quitada: los sprites de siempre
	ld a,(ix+028h)		;8211   ; la Y guardada (0xE348)...
	ld (ix-010h),a		;8214   ; ...a 0xE310
	ld a,(ix+029h)		;8217   ; la X guardada...
	ld (ix-00fh),a		;821a   ; ...a 0xE311
	ld (ix-020h),0ech		;821d   ; 0xE300 fuera
	ld (ix-00dh),001h		;8221   ; 0xE313: color 1
	jr bucle_mira		;8225
pausa_pon:
	call sprites_pausa		;8227   ; los dibujos de la pausa (0x5A00)
	ld a,(ix-010h)		;822a   ; la Y de 0xE310...
	ld (ix+028h),a		;822d   ; ...guardada en 0xE348
	ld a,(ix-00fh)		;8230   ; la X...
	ld (ix+029h),a		;8233   ; ...guardada
	ld (ix+020h),0ech		;8236   ; 0xE340 fuera
	ld (ix+002h),004h		;823a   ; el dibujo 4...
	ld (ix+012h),000h		;823e   ; ...y el 0
	ld (ix-00eh),010h		;8242   ; 0xE312: el dibujo 0x10
	ld (ix-01eh),014h		;8246   ; 0xE302: el 0x14
	ld a,(ix+000h)		;824a   ; la Y del protagonista...
	add a,010h		;824d   ; ...+16...
	ld (ix-020h),a		;824f   ; ...para 0xE300...
	ld (ix-010h),a		;8252   ; ...y 0xE310
	ld a,(ix+001h)		;8255   ; su X...
	sub 008h		;8258   ; ...-8 para 0xE310...
	ld (ix-00fh),a		;825a
	add a,010h		;825d   ; ...y +8 para 0xE300
	ld (ix-01fh),a		;825f
	ld a,009h		;8262   ; color 9...
	ld (ix-01dh),a		;8264   ; ...para los dos
	ld (ix-00dh),a		;8267
	xor a			;826a   ; la cuenta de la pausa a 0
	ld (0e016h),a		;826b
	jp bucle_mira		;826e
sonido_fondo:		; El efecto de fondo de B y C: el 7 en el rio; el 5 en tierra (0xE051 = 2)
	ld a,(0e051h)		;8271   ; en tierra?
	cp 002h		;8274
	jr z,L_827C		;8276   ; si
	ld a,007h		;8278   ; el 7
	jr L_827E		;827a
L_827C:
	ld a,005h		;827c   ; el 5
L_827E:
	call efecto_bc_pide		;827e   ; pedido
	ret			;8281
muerte:		; Muerto (0xE183): con TAB (0xE03A) no pasa nada; si no, el efecto 2, el protagonista cae dando vueltas 240 cuadros; con vidas de reserva, una menos y la escena otra vez; sin ellas, CAPS (0xE039) las pone a 2; si no, GAME OVER y al titulo
	ld a,(0e03ah)		;8282   ; TAB?
	and a			;8285
	jr z,L_828F		;8286   ; no
	xor a			;8288   ; si: 0xE183 a 0...
	ld (0e183h),a		;8289
	jp bucle_cuadro		;828c   ; ...y sigue
L_828F:
	call sonido_reinicia		;828f   ; el sonido a cero
	xor a			;8292   ; la cuenta a 0
	ld (0e010h),a		;8293
	ld a,(0e054h)		;8296   ; 0xE054 a 0...
	and a			;8299
	jr nz,L_82A7		;829a   ; no
	ld a,(0e003h)		;829c   ; ...y no es la escena 4...
	cp 004h		;829f
	jr z,L_82A7		;82a1
	xor a			;82a3   ; ...otra vez desde el rio (0xE051 = 0)
	ld (0e051h),a		;82a4
L_82A7:
	ld a,(0e010h)		;82a7   ; 2 cuadros
	cp 002h		;82aa
	jr c,L_82A7		;82ac
	ld a,002h		;82ae   ; el efecto 2 (la caida)
	call efecto_bc_pide		;82b0
	ld a,0ech		;82b3   ; fuera (Y 0xEC):
	ld (ix+010h),a		;82b5   ; 0xE330
	ld (ix-010h),a		;82b8   ; 0xE310
	ld (ix+020h),a		;82bb   ; 0xE340
	ld a,00fh		;82be   ; color 15...
	ld (ix+003h),a		;82c0   ; ...el protagonista...
	ld (ix-01dh),a		;82c3   ; ...y 0xE303
	ld a,(ix+000h)		;82c6   ; 0xE300 donde el protagonista: Y...
	ld (ix-020h),a		;82c9
	ld a,(ix+001h)		;82cc   ; ...y X
	ld (ix-01fh),a		;82cf
	ld (ix-01eh),0e8h		;82d2   ; 0xE302: el dibujo 0xE8
muerte_cuadro:
	ld a,(0e010h)		;82d6   ; un cuadro
	cp 001h		;82d9
	jr c,muerte_cuadro		;82db
	xor a			;82dd   ; a cero
	ld (0e010h),a		;82de
	ld a,(0e012h)		;82e1   ; cada 8 cuadros...
	and 008h		;82e4
	rrca			;82e6
	add a,0e8h		;82e7   ; ...0xE8 o 0xEC
	ld (ix+002h),a		;82e9   ; el dibujo del protagonista...
	ld (ix-01eh),a		;82ec   ; ...y el de 0xE302
	call prota_vram		;82ef   ; a la VRAM
	inc (ix+01eh)		;82f2   ; la cuenta (0xE33E)...
	ld a,(ix+01eh)		;82f5
	cp 0f0h		;82f8   ; ...hasta 0xF0
	jr c,muerte_cuadro		;82fa
	ld a,(0e001h)		;82fc   ; vidas de reserva?
	and a			;82ff
	jr z,sin_vidas		;8300   ; ninguna
	sub 001h		;8302   ; una menos...
	daa			;8304   ; ...en BCD
	ld (0e001h),a		;8305
	jp escena_empieza		;8308   ; la escena otra vez
sin_vidas:
	ld a,(0e039h)		;830b   ; CAPS?
	and a			;830e
	jp z,game_over		;830f   ; no: GAME OVER
	ld a,002h		;8312   ; si: 2 vidas otra vez
	ld (0e001h),a		;8314
	jp escena_empieza		;8317   ; la escena otra vez
game_over:		; GAME OVER: los sprites fuera, la pantalla se cierra por columnas, GAME OVER en la fila 11, la musica 1 y al titulo
	call sprites_fuera		;831a   ; los sprites fuera
	call pantalla_cierra		;831d   ; la pantalla se cierra
	call letras		;8320   ; las letras
	ld de,0196bh		;8323   ; en la fila 11, columna 11...
	ld hl,08df5h		;8326   ; ...GAME OVER
	ld bc,00009h		;8329   ; 9 casillas
	call 0005ch		;832c   ; LDIRVM
	xor a			;832f   ; el boton...
	ld (0e026h),a		;8330
	ld (0e000h),a		;8333   ; ...y jugando, a 0
	inc a			;8336   ; la musica 1 (GAME OVER)
	call musica_pide		;8337   ; pedida
	call espera_musica		;833a   ; hasta que acabe
	xor a			;833d
	ld (0e026h),a		;833e
	jp inicio		;8341   ; al titulo
escena_acabada:		; La escena acabada (0xE184), con el protagonista quieto (+6): la siguiente (0xE003, BCD); tras la quinta, el final: el protagonista anda a X 0x78, entra un personaje de 2 x 2 sprites por la derecha, aparecen dos sprites mas, efecto 1, el protagonista crece (los dibujos 0x3C-0x48), どんなもんだい en grande (0x8D95) y la musica 3; despues, otra vuelta (0xE004 = 1)
	ld a,(ix+006h)		;8344   ; moviendose?
	and a			;8347
	jp nz,bucle_cuadro		;8348   ; si: sigue
	ld (ix+020h),0ech		;834b   ; 0xE340 fuera
	ld a,(0e003h)		;834f   ; la escena...
	add a,001h		;8352   ; ...una mas...
	daa			;8354   ; ...en BCD
	ld (0e003h),a		;8355
	cp 005h		;8358   ; las cinco?
	jp c,escena_siguiente		;835a   ; no: a la siguiente
	xor a			;835d   ; si: la 0 otra vez...
	ld (0e003h),a		;835e
	inc a			;8361   ; ...y 0xE004 = 1 (otra vuelta)
	ld (0e004h),a		;8362
final_anda:
	ld a,(0e010h)		;8365   ; un cuadro
	cp 001h		;8368
	jr c,final_anda		;836a
	xor a			;836c   ; la cuenta a 0
	ld (0e010h),a		;836d
	ld a,(ix+001h)		;8370   ; la X del protagonista
	cp 078h		;8373   ; 0x78?
	jr z,final_llega		;8375   ; llegado
	jr c,L_8382		;8377   ; menos: a la derecha
	dec (ix+001h)		;8379   ; a la izquierda
	ld (ix+00dh),000h		;837c   ; mirando a la izquierda
	jr L_8389		;8380
L_8382:
	inc (ix+001h)		;8382   ; a la derecha
	ld (ix+00dh),080h		;8385   ; mirando a la derecha
L_8389:
	ld a,(0e012h)		;8389   ; cada 8 cuadros...
	and 008h		;838c
	ld (ix+00ch),a		;838e   ; ...el paso
	call prota_sprites		;8391   ; sus sprites
	call prota_vram		;8394   ; a la VRAM
	jr final_anda		;8397
final_llega:
	ld (ix+00dh),080h		;8399   ; mirando a la derecha
	call prota_sprites		;839d
	ld iy,0e380h		;83a0   ; IY: cuatro sprites desde 0xE380
	ld a,068h		;83a4   ; Y 0x68 los dos de arriba...
	ld (iy+000h),a		;83a6
	ld (iy+010h),a		;83a9
	add a,010h		;83ac   ; ...y 0x78 los de abajo
	ld (iy+020h),a		;83ae
	ld (iy+030h),a		;83b1
	ld (iy+001h),0f0h		;83b4   ; X 0xF0
	ld a,024h		;83b8   ; los dibujos 0x24...
	ld (iy+002h),a		;83ba
	add a,004h		;83bd   ; ...0x28...
	ld (iy+012h),a		;83bf
	add a,004h		;83c2   ; ...0x2C...
	ld (iy+022h),a		;83c4
	add a,004h		;83c7   ; ...y 0x30, que va a parar al color del cuarto (se pisa despues)
	ld (iy+033h),a		;83c9
	ld a,009h		;83cc   ; color 9...
	ld (iy+003h),a		;83ce
	ld (iy+023h),a		;83d1
	ld a,00bh		;83d4   ; ...y 0x0B
	ld (iy+013h),a		;83d6
	ld (iy+033h),a		;83d9
	ld a,001h		;83dc   ; los cuatro en pantalla
	ld (iy+004h),a		;83de
	ld (iy+014h),a		;83e1
	ld (iy+024h),a		;83e4
	ld (iy+034h),a		;83e7
	jr L_83FA		;83ea
final_llega_cuadro:
	ld a,(0e010h)		;83ec   ; 3 cuadros
	cp 003h		;83ef
	jr c,final_llega_cuadro		;83f1
	xor a			;83f3   ; la cuenta a 0
	ld (0e010h),a		;83f4
	dec (iy+001h)		;83f7   ; un paso a la izquierda
L_83FA:
	ld a,(iy+001h)		;83fa   ; la X...
	ld (iy+011h),a		;83fd   ; ...para los cuatro
	ld (iy+021h),a		;8400
	ld (iy+031h),a		;8403
	ld b,(ix+001h)		;8406   ; menos la del protagonista
	sub b			;8409
	cp 010h		;840a   ; a menos de 16?
	jr c,final_crece		;840c   ; si: llegada
	ld a,(iy+001h)		;840e   ; cada 2 pasos...
	and 002h		;8411
	rlca			;8413
	rlca			;8414
	add a,02ch		;8415   ; ...las piernas 0x2C o 0x34
	ld (iy+022h),a		;8417
	add a,004h		;841a
	ld (iy+032h),a		;841c
	call prota_vram		;841f   ; a la VRAM
	jr final_llega_cuadro		;8422
final_crece:
	call espera_musica		;8424   ; hasta que acabe la musica
	ld a,(iy+000h)		;8427   ; 16 por encima del que llega...
	sub 010h		;842a
	ld (iy+040h),a		;842c   ; ...dos sprites mas
	ld (iy+050h),a		;842f
	ld a,(iy+001h)		;8432   ; y 10 a su izquierda
	sub 00ah		;8435
	ld (iy+051h),a		;8437
	ld (iy+041h),a		;843a
	ld (iy+042h),078h		;843d   ; los dibujos 0x78...
	ld (iy+052h),07ch		;8441   ; ...y 0x7C
	ld (iy+043h),009h		;8445   ; color 9...
	ld (iy+053h),00bh		;8449   ; ...y 0x0B
	ld (iy+044h),001h		;844d   ; en pantalla
	ld (iy+054h),001h		;8451
	ld a,001h		;8455   ; el efecto 1 del canal A
	call efecto_a_pide		;8457
	ld a,068h		;845a   ; el protagonista, en grande: Y 0x68...
	ld (ix+000h),a		;845c   ; la Y del protagonista
	ld (ix+010h),a		;845f   ; la Y de su segundo sprite
	add a,010h		;8462   ; ...16 mas abajo los de abajo
	ld (ix+020h),a		;8464   ; la del tercer sprite (0xE340)
	ld (ix+030h),a		;8467
	ld a,(ix+001h)		;846a   ; la misma X para los cuatro
	ld (ix+021h),a		;846d
	ld (ix+031h),a		;8470
	ld a,03ch		;8473   ; los dibujos 0x3C...
	ld (ix+002h),a		;8475
	add a,004h		;8478   ; ...0x40...
	ld (ix+012h),a		;847a   ; ...y 0x78 los de abajo
	add a,004h		;847d   ; ...0x44...
	ld (ix+022h),a		;847f
	add a,004h		;8482   ; ...y 0x48
	ld (ix+032h),a		;8484
	ld a,001h		;8487   ; los cuatro en pantalla
	ld (ix+024h),a		;8489
	ld (ix+034h),a		;848c
	ld (ix+023h),005h		;848f   ; color 5...
	ld (ix+033h),00bh		;8493   ; ...y 0x0B
	call prota_vram		;8497   ; a la VRAM
	call espera_musica		;849a   ; hasta que acabe
	ld hl,05000h		;849d   ; las casillas del titulo (0x5000)...
	ld de,00980h		;84a0   ; ...al segundo tercio, desde la 0x30, y sus colores
	ld bc,00300h		;84a3   ; 0x300 bytes
	call dibujos_y_colores		;84a6
	ld hl,08d95h		;84a9   ; どんなもんだい: su primera fila...
	ld de,0192ah		;84ac   ; ...en la fila 9, columna 10
	ld bc,0000ch		;84af
	call 0005ch		;84b2   ; LDIRVM
	ex de,hl			;84b5   ; la siguiente fila...
	ld de,0194ah		;84b6   ; ...en la 10
	ld bc,0000ch		;84b9
	call 0005ch		;84bc   ; LDIRVM
	ld a,003h		;84bf   ; la musica 3 (el final)
	call musica_pide		;84c1
escena_siguiente:
	xor a			;84c4   ; 0xE184 a 0
	ld (0e184h),a		;84c5
	ld (0e053h),a		;84c8
	ld (0e051h),a		;84cb   ; 0xE051 a 0
	call espera_musica		;84ce   ; hasta que acabe
	call todo_fuera		;84d1   ; todo fuera
	ld a,(0e003h)		;84d4   ; la escena 4?
	cp 004h		;84d7
	jp nz,escena_empieza		;84d9   ; no: a la escena
	ld a,002h		;84dc   ; si: 0xE051 = 2: toda en tierra
	ld (0e051h),a		;84de
	jp escena_empieza		;84e1
todo_fuera:		; 0xE340-0xE4FF a cero y sus 28 sprites fuera (Y 0xEC)
	ld hl,0e340h		;84e4   ; 0xE340...
	ld bc,001c0h		;84e7   ; ...0x1C0 bytes
L_84EA:
	ld (hl),000h		;84ea
	inc hl			;84ec
	dec bc			;84ed
	ld a,c			;84ee
	or b			;84ef
	jr nz,L_84EA		;84f0
	ld hl,0e340h		;84f2   ; los 28...
	ld de,00010h		;84f5
	ld b,01ch		;84f8
L_84FA:
	ld (hl),0ech		;84fa   ; ...fuera
	add hl,de			;84fc
	djnz L_84FA		;84fd
	jp sprites_vram		;84ff
otro_borra_va:
	push iy		;8502   ; sus 16 bytes...
	pop hl			;8504   ; su principio
	ld b,010h		;8505   ; 16 bytes
otro_borra_byte:
	ld (hl),000h		;8507   ; ...a cero
	inc hl			;8509
	djnz otro_borra_byte		;850a
	ld (iy+000h),0ech		;850c   ; fuera (Y 0xEC)
	ret			;8510   ; listo
cerca_y:		; ¿Toca en Y? A = la Y de IY menos la del protagonista (IX): C (toca) si, con signo, queda entre C - 0x100 y B - 1 (B, el margen por un lado; C, 0x100 menos el del otro)
	ld a,(iy+000h)		;8511   ; la Y del otro...
	sub (ix+000h)		;8514   ; ...menos la del protagonista
cerca_mira:
	cp b			;8517   ; menos que B (de 0 a B - 1)...
	ret c			;8518   ; ...toca: C
	cp c			;8519   ; C o mas (de C - 0x100 a -1)?
	jr c,L_851E		;851a   ; no: a NC
	scf			;851c   ; si: toca (C)
	ret			;851d   ; C
L_851E:
	xor a			;851e   ; no toca: NC
	ret			;851f
cerca_x:		; ¿Toca en X? A = la X de IY menos la del protagonista (IX): C si queda entre C - 0x100 y B - 1, como cerca_y
	ld a,(iy+001h)		;8520   ; la X de IY...
	sub (ix+001h)		;8523   ; ...menos la de IX
	jr cerca_mira		;8526   ; a comparar

; ----------------------------------------------------------------------
; DATOS cerca_y2: Como cerca_y con el arma (la Y de IY menos la de IX + 0x20,
;   y a cerca_mira): 8 bytes que nadie llama
;   0x8528..0x8530  (8 bytes)
DATA_cerca_y2:
	defb 0fdh,07eh,000h,0ddh,096h,020h,018h,0e7h	; 8528  .~... ..

; ======================================================================
; CODIGO 0x8530..0x8712  (482 bytes)
; ======================================================================


cerca_x2:		; Como cerca_x, con el arma (IX + 0x21)
	ld a,(iy+001h)		;8530   ; la X de IY...
	sub (ix+021h)		;8533   ; ...menos la del arma
	jr $-31		;8536   ; a comparar (cerca_mira)
pantalla_limpia:		; La pantalla apagada, la tabla de nombres en blanco, la RAM de 0xE100 a 0xF2FF a cero, los botones a 0, las letras, las casillas de la partida (0x5300 y sus colores 0x5B00, 0x4D00 y 0x4E80) en los tres tercios y los sprites
	call 00041h		;8538   ; DISSCR
	call nombres_borra		;853b   ; la tabla de nombres a 0x10
	call ram_escena		;853e   ; la RAM de 0xE100 a cero y los sprites fuera
	xor a			;8541   ; los botones a 0
	ld (0e026h),a		;8542   ; el de empezar
	ld (0e020h),a		;8545   ; el boton 2
	ld (0e022h),a		;8548   ; el boton 1
	ld (0e024h),a		;854b   ; 0xE024
	ld (0e180h),a		;854e   ; la palanca
	call letras		;8551   ; las letras
	ld hl,05300h		;8554   ; las casillas 0x30-0xCF (0x5300)...
	ld de,00180h		;8557   ; ...desde la 0x30...
	ld bc,00500h		;855a   ; ...0x500 bytes
	call tercios_va		;855d   ; en los tres tercios
	ld hl,05b00h		;8560   ; sus colores (0x5B00)
	ld de,02180h		;8563
	ld bc,00500h		;8566
	call tercios_va		;8569   ; en los tres tercios
	ld hl,04d00h		;856c   ; las casillas 0xD0-0xFF (0x4D00)
	ld de,00680h		;856f
	ld bc,00180h		;8572
	call tercios_va		;8575   ; en los tres tercios
	ld hl,04e80h		;8578   ; sus colores (0x4E80)
	ld de,02680h		;857b
	ld bc,00180h		;857e
	call tercios_va		;8581   ; en los tres tercios
	jp sprites_dibujos		;8584   ; los sprites
decorado_dibujos:		; Las casillas del decorado: 0x6000 en el primer tercio y 0x7000 en el segundo (con sus colores, 0x800 mas alla); desde la escena 3, el segundo con 0xA280; y los sprites 0x80-0x99, los 26 primeros vueltos del reves (0xE600 y a 0x3C00)
	ld hl,06000h		;8587   ; las casillas del primer tercio (0x6000)...
	ld de,00000h		;858a   ; ...a 0x0000
	ld bc,00800h		;858d   ; 0x800 bytes
	call dibujos_y_colores		;8590   ; y sus colores
	ld hl,07000h		;8593   ; las del segundo (0x7000)...
	ld de,00800h		;8596   ; ...a 0x0800
	ld bc,00800h		;8599
	call dibujos_y_colores		;859c   ; y sus colores
	call sprites_dibujos		;859f   ; los sprites
	ld a,(0e003h)		;85a2   ; la escena...
	cp 003h		;85a5   ; ...3 o mas?
	jr c,sprites_vuelve		;85a7   ; no
	ld hl,0a280h		;85a9   ; si: 0xA280...
	ld de,00800h		;85ac   ; ...al segundo tercio
	ld bc,00400h		;85af   ; 0x400 bytes
	call 0005ch		;85b2   ; LDIRVM
	ld hl,0a680h		;85b5   ; y sus colores (0xA680)
	ld de,02800h		;85b8
	ld bc,00400h		;85bb
	call 0005ch		;85be   ; LDIRVM
sprites_vuelve:		; Los 26 primeros sprites (0xAA80, 0x340 bytes) en 0xE600, cada byte del reves y las dos mitades cambiadas: mirando al otro lado, a 0x3C00 (los dibujos 0x80-0xE7)
	ld hl,0aa80h		;85c1   ; los sprites...
	ld de,0e600h		;85c4   ; ...a 0xE600...
	ld bc,00340h		;85c7   ; ...0x340 bytes
	ldir		;85ca
	ld de,00340h		;85cc   ; 0x340 bytes
	ld hl,0e600h		;85cf
sprites_vuelve_byte:
	ld b,008h		;85d2   ; 8 bits
L_85D4:
	rrc (hl)		;85d4   ; uno a la derecha...
	rla			;85d6   ; ...entra por la izquierda
	djnz L_85D4		;85d7
	ld (hl),a			;85d9   ; el byte del reves
	inc hl			;85da
	dec de			;85db   ; uno menos
	ld a,e			;85dc
	or d			;85dd
	jr nz,sprites_vuelve_byte		;85de
	ld hl,0e600h		;85e0   ; la mitad izquierda...
	ld de,0e610h		;85e3   ; ...y la derecha (+16)
	ld bc,00019h		;85e6   ; 25 dibujos de 16 x 16
sprites_vuelve_mitad:
	push bc			;85e9
	ld b,010h		;85ea   ; 16 bytes
L_85EC:
	ld c,(hl)			;85ec   ; cambiados
	ld a,(de)			;85ed
	ld (hl),a			;85ee
	ld a,c			;85ef
	ld (de),a			;85f0
	inc hl			;85f1
	inc de			;85f2
	djnz L_85EC		;85f3
	ld bc,00010h		;85f5   ; el siguiente dibujo: +16 los dos
	add hl,bc			;85f8
	ex de,hl			;85f9
	add hl,bc			;85fa
	ex de,hl			;85fb
	pop bc			;85fc
	dec bc			;85fd
	ld a,c			;85fe
	or b			;85ff
	jr nz,sprites_vuelve_mitad		;8600
	ld hl,0e600h		;8602   ; desde 0xE600...
	ld de,03c00h		;8605   ; ...a 0x3C00 (el dibujo 0x80)
	ld bc,00340h		;8608   ; 0x340 bytes
	jp 0005ch		;860b   ; LDIRVM
marcador:		; El marcador: HISCORE (fila 22) y SCORE (fila 23) con su cero de detras, las barras, las vidas, la escena, 0xE054 y sus dibujos
	ld de,01ac0h		;860e   ; en la fila 22...
	ld hl,08de7h		;8611   ; ...HISCORE
	ld bc,00007h		;8614   ; 7 casillas
	call 0005ch		;8617   ; LDIRVM
	ld de,01ae2h		;861a   ; en la fila 23, columna 2...
	ld hl,08de9h		;861d   ; ...SCORE
	ld bc,00005h		;8620   ; 5 casillas
	call 0005ch		;8623   ; LDIRVM
	ld hl,01aceh		;8626   ; el cero de detras del record
	xor a			;8629
	call 0004dh		;862a   ; WRTVRM
	ld hl,01aeeh		;862d   ; el de los puntos
	xor a			;8630
	call 0004dh		;8631   ; WRTVRM
	call barra_arriba		;8634   ; la barra de arriba
	call barra_abajo		;8637   ; la de abajo
	call vidas_pinta		;863a   ; las vidas
	call escena_pinta		;863d   ; la escena
	call e054_pinta		;8640   ; 0xE054 y su dibujo
	ret			;8643
e054_pinta:		; El dibujo de las casillas 0x30 y 0x31 en la fila 22, columna 16, y 0xE054 debajo
	ld hl,01ad0h		;8644   ; en la fila 22, columna 16...
	ld a,030h		;8647   ; ...la casilla 0x30...
	call 0004dh		;8649   ; WRTVRM
	inc hl			;864c   ; ...y la 0x31
	inc a			;864d
	call 0004dh		;864e   ; WRTVRM
e054_cifras:		; 0xE054 (BCD) en la fila 23, columnas 16 y 17
	ld hl,01af0h		;8651   ; en la fila 23, columna 16
	ld a,(0e054h)		;8654   ; 0xE054...
	and 0f0h		;8657   ; ...la cifra alta
	rrca			;8659
	rrca			;865a
	rrca			;865b
	rrca			;865c
	call 0004dh		;865d   ; WRTVRM
	inc hl			;8660
	ld a,(0e054h)		;8661   ; la baja
	and 00fh		;8664
	call 0004dh		;8666   ; WRTVRM
	ret			;8669
e054_suma:		; 0xE054 + 1 (en BCD, hasta 99) y sus cifras
	ld a,(0e054h)		;866a   ; 0xE054
	cp 099h		;866d   ; 99: no hay mas
	ret z			;866f
	add a,001h		;8670   ; + 1...
	daa			;8672   ; ...en BCD
	ld (0e054h),a		;8673
	jr e054_cifras		;8676   ; sus cifras
e054_gasta:		; 0xE054 - 1 (si hay); al llegar a 0, 0xE33E = 0 y la palanca, 7
	ld a,(0e054h)		;8678   ; 0xE054
	and a			;867b   ; ninguno?
	ret z			;867c   ; nada
	sub 001h		;867d   ; uno menos...
	daa			;867f   ; ...en BCD
	ld (0e054h),a		;8680
	and a			;8683   ; a 0?
	jr z,e054_acaba		;8684
	jr e054_cifras		;8686   ; no: sus cifras
e054_acaba:
	ld (ix+01eh),000h		;8688   ; 0xE33E a 0
	call e054_cifras		;868c   ; sus cifras
	ld a,007h		;868f   ; la palanca: 7
	ld (0e180h),a		;8691
	jp prota_mueve		;8694
barra_arriba:		; La barra de la fila 22 (0xE1B5): 8 casillas vacias (0x36), las llenas y, en la columna 19, el rotulo de las vidas (0x8DEF)
	ld hl,01ad8h		;8697   ; en la fila 22, columna 24...
	ld bc,00008h		;869a   ; ...8 casillas...
	ld a,036h		;869d   ; ...vacias (0x36)
	call 00056h		;869f   ; FILVRM
	ld de,01ad3h		;86a2   ; en la columna 19...
	ld hl,08defh		;86a5   ; ...el rotulo de las vidas (las casillas 0x32 y 0x33)
	ld bc,00002h		;86a8   ; 2 casillas
	call 0005ch		;86ab   ; LDIRVM
	ld hl,01ad8h		;86ae   ; en la columna 24...
	ld a,(0e1b5h)		;86b1   ; ...lo que tiene
	jr barra_llena		;86b4   ; a pintarla
barra_abajo:		; Lo mismo en la fila 23 con 0xE1B7 y el rotulo de la escena (0x8DF2)
	ld hl,01af8h		;86b6   ; en la fila 23, columna 24...
	ld bc,00008h		;86b9   ; ...8 casillas...
	ld a,036h		;86bc   ; ...vacias
	call 00056h		;86be   ; FILVRM
	ld de,01af3h		;86c1   ; en la columna 19...
	ld hl,08df2h		;86c4   ; ...el rotulo de la escena (0x34 y 0x35)
	ld bc,00002h		;86c7   ; 2 casillas
	call 0005ch		;86ca   ; LDIRVM
	ld hl,01af8h		;86cd   ; en la columna 24...
	ld a,(0e1b7h)		;86d0   ; ...lo que tiene
barra_llena:		; A en octavos: A / 8 casillas llenas (0x3E) y una con el resto (0x36 + resto)
	ld b,000h		;86d3
L_86D5:
	sub 008h		;86d5   ; 8 menos
	jr c,L_86DC		;86d7
	inc b			;86d9   ; una llena mas
	jr L_86D5		;86da
L_86DC:
	add a,008h		;86dc   ; el resto
	ld c,a			;86de
	ld a,b			;86df   ; llenas?
	and a			;86e0
	jr z,L_86EB		;86e1
	ld a,03eh		;86e3   ; la llena (0x3E)
L_86E5:
	call 0004dh		;86e5   ; WRTVRM
	inc hl			;86e8
	djnz L_86E5		;86e9   ; tantas
L_86EB:
	ld a,c			;86eb   ; el resto?
	and a			;86ec
	ret z			;86ed   ; ninguno
	add a,036h		;86ee   ; 0x36 + el resto
	call 0004dh		;86f0   ; WRTVRM
	ret			;86f3
golpe:		; Un golpe al protagonista, si no esta protegido (0xE33E): el efecto 4 del canal A y la barra de arriba (0xE1B5) un octavo menos; vacia, muerto (0xE183 = 1)
	ld a,(ix+01eh)		;86f4   ; protegido?
	and a			;86f7
	ret nz			;86f8   ; si: nada
	ld a,004h		;86f9   ; el efecto 4
	call efecto_a_pide		;86fb
	ld a,(0e1b5h)		;86fe   ; la barra...
	dec a			;8701   ; ...uno menos
	cp 0ffh		;8702   ; se pasa de 0?
	jr z,L_870C		;8704   ; si: muerto
	ld (0e1b5h),a		;8706   ; apuntada
	jp barra_arriba		;8709   ; y pintada
L_870C:
	ld a,001h		;870c   ; muerto: 0xE183 = 1
	ld (0e183h),a		;870e
	ret			;8711

; ----------------------------------------------------------------------
; DATOS sobra_8712: 32 bytes que nadie lee ni ejecuta
;   0x8712..0x8732  (32 bytes)
DATA_sobra_8712:
	defb 03ah,0b6h,0e1h,03ch,032h,0b6h,0e1h,0feh,002h,0d8h,0afh,032h,0b6h,0e1h,03ah,0b5h	; 8712  :..<2......2..:.
	defb 0e1h,03ch,0feh,040h,0d0h,032h,0b5h,0e1h,03eh,002h,0cdh,0e0h,0b2h,0c3h,097h,086h	; 8722  .<.@.2..>.......

; ======================================================================
; CODIGO 0x8732..0x8744  (18 bytes)
; ======================================================================


golpe_abajo:		; El efecto 4 y la barra de abajo (0xE1B7) un octavo menos, sin pasar de 0
	ld a,004h		;8732   ; el efecto 4
	call efecto_a_pide		;8734
	ld a,(0e1b7h)		;8737   ; la barra...
	dec a			;873a   ; ...uno menos
	cp 0ffh		;873b   ; se pasa de 0?
	ret z			;873d   ; si: nada
	ld (0e1b7h),a		;873e   ; apuntada
	jp barra_abajo		;8741   ; y pintada

; ----------------------------------------------------------------------
; DATOS sobra_8744: 18 bytes que nadie lee ni ejecuta
;   0x8744..0x8756  (18 bytes)
DATA_sobra_8744:
	defb 03ah,0b7h,0e1h,03ch,0feh,040h,0d0h,032h,0b7h,0e1h,03eh,002h,0cdh,0e0h,0b2h,0c3h	; 8744  :..<.@.2..>.....
	defb 0b6h,086h	; 8754

; ======================================================================
; CODIGO 0x8756..0x8d5a  (1540 bytes)
; ======================================================================


vidas_pinta:		; Las vidas de reserva (0xE001, BCD) en la fila 22, columnas 21 y 22
	ld a,(0e001h)		;8756   ; la cifra alta
	and 0f0h		;8759
	rrca			;875b
	rrca			;875c
	rrca			;875d
	rrca			;875e
	ld hl,01ad5h		;875f   ; en la fila 22, columna 21
	call 0004dh		;8762   ; WRTVRM
	inc hl			;8765
	ld a,(0e001h)		;8766   ; la baja
	and 00fh		;8769
	call 0004dh		;876b   ; WRTVRM
	ret			;876e
escena_pinta:		; La escena (0xE003 + 1, BCD) en la fila 23, columnas 21 y 22
	ld a,(0e003h)		;876f   ; la escena...
	add a,001h		;8772   ; ...+ 1...
	daa			;8774   ; ...en BCD
	ld c,a			;8775
	and 0f0h		;8776   ; la cifra alta
	rrca			;8778
	rrca			;8779
	rrca			;877a
	rrca			;877b
	ld b,a			;877c
	ld hl,01af5h		;877d   ; en la fila 23, columna 21
	call 0004dh		;8780   ; WRTVRM
	inc hl			;8783
	ld a,c			;8784   ; la baja
	and 00fh		;8785
	ld c,a			;8787
	call 0004dh		;8788   ; WRTVRM
	ret			;878b
vida_suma:		; Una vida de reserva mas (0xE001, BCD) y pintada
	ld a,(0e001h)		;878c   ; las vidas
	add a,001h		;878f   ; + 1...
	daa			;8791   ; ...en BCD
	ld (0e001h),a		;8792
	jp vidas_pinta		;8795   ; pintadas
ram_escena:		; 0xE100-0xF2FF (0x1200 bytes) a cero; los cuatro primeros sprites fuera y lo demas tambien
	ld hl,0e100h		;8798
	ld bc,01200h		;879b   ; 0x1200 bytes
L_879E:
	ld (hl),000h		;879e   ; a cero
	inc hl			;87a0
	dec bc			;87a1
	ld a,c			;87a2
	or b			;87a3
	jr nz,L_879E		;87a4   ; 0x1200 bytes
sprites_fuera:		; Los sprites de 0xE300-0xE330 fuera y todo_fuera
	ld a,0ech		;87a6   ; Y 0xEC: fuera
	ld (0e300h),a		;87a8   ; fuera
	ld (0e310h),a		;87ab
	ld (0e320h),a		;87ae
	ld (0e330h),a		;87b1
	jp todo_fuera		;87b4
decorado_pinta:		; Las 22 filas de 0xE600 a la tabla de nombres, fila a fila
	ld hl,0e600h		;87b7   ; desde 0xE600...
	ld de,01800h		;87ba   ; ...a la tabla de nombres
	ld (0e1a0h),hl		;87bd
	ld (0e1a2h),de		;87c0
	ld b,016h		;87c4   ; 22 filas
decorado_pinta_fila:
	push bc			;87c6
	ld hl,(0e1a0h)		;87c7   ; desde
	ld de,(0e1a2h)		;87ca   ; a
	ld bc,00020h		;87ce   ; 32 casillas
	call 0005ch		;87d1   ; LDIRVM
	ld hl,(0e1a0h)		;87d4   ; la fila siguiente de la RAM
	ld de,00020h		;87d7
	add hl,de			;87da
	ld (0e1a0h),hl		;87db
	ld hl,(0e1a2h)		;87de
	ld de,00020h		;87e1   ; la de la VRAM (0x20)
	add hl,de			;87e4
	ld (0e1a2h),hl		;87e5
	pop bc			;87e8
	djnz decorado_pinta_fila		;87e9   ; una fila menos
	ret			;87eb
pantalla_cierra:		; La pantalla se borra columna a columna, una cada 2 cuadros
	ld hl,01800h		;87ec   ; desde la columna 0
	ld (0e1a0h),hl		;87ef   ; apuntada
	ld b,020h		;87f2   ; 32 columnas
	xor a			;87f4   ; la cuenta a 0
	ld (0e010h),a		;87f5
	ld de,00020h		;87f8   ; una fila
pantalla_cierra_columna:
	ld c,016h		;87fb   ; 22 filas
	ld hl,(0e1a0h)		;87fd   ; la columna
pantalla_cierra_espera:
	ld a,(0e010h)		;8800   ; la cuenta
	cp 002h		;8803   ; 2 cuadros?
	jr c,pantalla_cierra_espera		;8805
	xor a			;8807   ; la cuenta a 0
	ld (0e010h),a		;8808   ; a 0
pantalla_cierra_fila:
	ld a,010h		;880b   ; el espacio
	call 0004dh		;880d   ; WRTVRM
	add hl,de			;8810   ; la fila siguiente
	dec c			;8811   ; una fila menos
	jr nz,pantalla_cierra_fila		;8812
	ld hl,(0e1a0h)		;8814   ; la columna...
	inc hl			;8817   ; la columna siguiente
	ld (0e1a0h),hl		;8818   ; ...apuntada
	djnz pantalla_cierra_columna		;881b
	ret			;881d
nombres_borra:		; La tabla de nombres llena de la casilla 0x10 (el espacio)
	ld a,010h		;881e   ; el espacio...
	ld hl,01800h		;8820   ; ...en la tabla de nombres...
	ld bc,00800h		;8823   ; ...0x800 bytes (hasta la tabla de sprites incluida)
	jp 00056h		;8826
letras:		; Las casillas 0-0x2F (las letras, 0x4B80) en los tres tercios, blancas (0xF0)
	ld a,0f0h		;8829   ; blanco sobre transparente
	ld hl,02000h		;882b   ; los colores del primer tercio...
	ld bc,00180h		;882e   ; ...0x180 bytes
	call 00056h		;8831   ; FILVRM
	ld hl,02800h		;8834   ; los del segundo
	ld bc,00180h		;8837
	call 00056h		;883a   ; FILVRM
	ld hl,03000h		;883d   ; los del tercero
	ld bc,00180h		;8840
	call 00056h		;8843   ; FILVRM
	ld hl,04b80h		;8846   ; las letras (0x4B80)...
	ld de,00000h		;8849   ; ...a la casilla 0
	ld bc,00180h		;884c   ; 0x180 bytes
tercios_va:		; HL y BC apuntados, y a tercios_copia
	ld (0e1a0h),hl		;884f
	ld (0e1a2h),bc		;8852
tercios_copia:		; 0xE1A2 bytes de 0xE1A0 a la VRAM DE y a los otros dos tercios (+0x800)
	ld b,003h		;8856   ; tres tercios
tercios_copia_uno:
	push bc			;8858
	ld hl,(0e1a0h)		;8859   ; desde
	ld bc,(0e1a2h)		;885c   ; cuantos
	call 0005ch		;8860   ; LDIRVM
	ld bc,00800h		;8863   ; el tercio siguiente
	add hl,bc			;8866
	ex de,hl			;8867
	pop bc			;8868
	djnz tercios_copia_uno		;8869
	ret			;886b
tercios_dos:		; Como tercios_va, en dos tercios
	ld (0e1a0h),hl		;886c   ; desde
	ld (0e1a2h),bc		;886f   ; cuantos
	ld b,002h		;8873   ; dos tercios
	jr tercios_copia_uno		;8875
dibujos_y_colores:		; BC bytes de HL a la VRAM DE y, 0x800 mas alla, sus colores a DE + 0x2000
	ld (0e1a0h),hl		;8877   ; desde
	ld (0e1a2h),de		;887a   ; a
	ld (0e1a4h),bc		;887e   ; cuantos
	ld hl,(0e1a0h)		;8882
	ld de,(0e1a2h)		;8885
	ld bc,(0e1a4h)		;8889
	call 0005ch		;888d   ; LDIRVM
	ld hl,(0e1a0h)		;8890   ; los colores: 0x800 mas alla...
	ld de,00800h		;8893
	add hl,de			;8896
	ld (0e1a0h),hl		;8897   ; apuntados
	ld hl,(0e1a2h)		;889a   ; ...a DE + 0x2000
	ld de,02000h		;889d
	add hl,de			;88a0
	ld (0e1a2h),hl		;88a1   ; apuntado
	ld hl,(0e1a0h)		;88a4
	ld de,(0e1a2h)		;88a7
	ld bc,(0e1a4h)		;88ab
	jp 0005ch		;88af   ; LDIRVM
titulo_dibujos:		; Las letras, las casillas del titulo (0x5000, 0x300 bytes, desde la 0x30) y sus colores (0x5800) en los tres tercios, y las casillas 0x70-0x8F en blanco
	call letras		;88b2   ; las letras
	ld hl,05000h		;88b5   ; las casillas del titulo (0x5000)...
	ld de,00180h		;88b8   ; ...desde la 0x30...
	ld bc,00300h		;88bb   ; ...0x300 bytes
	call tercios_va		;88be   ; en los tres tercios
	ld hl,05800h		;88c1   ; sus colores
	ld de,02180h		;88c4
	ld bc,00300h		;88c7
	call tercios_va		;88ca   ; en los tres tercios
	ld hl,02380h		;88cd   ; los colores de 0x70-0x8F...
	ld bc,00100h		;88d0   ; ...0x100 bytes...
	ld a,0f0h		;88d3   ; ...blanco sobre transparente
	call 00056h		;88d5   ; FILVRM
	ld hl,02b80h		;88d8   ; en el segundo tercio
	ld bc,00100h		;88db
	call 00056h		;88de   ; FILVRM
	ld hl,03380h		;88e1   ; y en el tercero
	ld bc,00100h		;88e4
	call 00056h		;88e7   ; FILVRM
	ret			;88ea
sprites_dibujos:		; Los dibujos de los sprites (0xAA80, 0x800 bytes) a 0x3800
	ld bc,00800h		;88eb   ; 0x800 bytes
sprites_dibujos_bc:
	ld hl,0aa80h		;88ee   ; desde 0xAA80
sprites_dibujos_va:
	ld de,03800h		;88f1   ; a 0x3800
	jp 0005ch		;88f4   ; LDIRVM
sprites_pausa:		; Los 8 primeros dibujos de los sprites desde 0x5A00 (los de la pausa)
	ld hl,05a00h		;88f7   ; desde 0x5A00
	ld bc,00100h		;88fa   ; 0x100 bytes
	jr sprites_dibujos_va		;88fd
sprites_de_siempre:		; Los 8 primeros dibujos, los de siempre (0xAA80)
	ld bc,00100h		;88ff   ; 0x100 bytes
	jr sprites_dibujos_bc		;8902
sonido_reinicia:		; 0xE002 = 0xFF: la interrupcion pone el sonido a cero
	ld a,0ffh		;8904
	ld (0e002h),a		;8906
	ret			;8909
sprites_vram:		; Los 32 sprites de 0xE300 (16 bytes cada uno: los 4 primeros son sus atributos) a 0xE100 y a la VRAM (0x1B00, 0x58 bytes: 22 sprites)
	ld hl,0e300h		;890a   ; desde 0xE300
	ld de,0e100h		;890d   ; a 0xE100
	ld b,020h		;8910   ; 32
sprites_vram_uno:
	push bc			;8912
	ld bc,00004h		;8913   ; cuatro bytes
	ldir		;8916   ; los atributos
	ld bc,0000ch		;8918   ; el siguiente (+16)
	add hl,bc			;891b
	pop bc			;891c
	djnz sprites_vram_uno		;891d
	ld de,01b00h		;891f   ; la tabla de atributos
	ld hl,0e100h		;8922
	ld bc,00058h		;8925   ; 0x58 bytes: 22 sprites
	jp 0005ch		;8928   ; LDIRVM
prota_vram:		; Los dos primeros (0xE300 y 0xE310) a 0xE100 y los 22 primeros de 0xE100 a la VRAM (los demas, de la interrupcion)
	ld hl,0e300h		;892b   ; desde 0xE300
	ld de,0e100h		;892e   ; a 0xE100
	ld b,002h		;8931   ; dos
	jr sprites_vram_uno		;8933   ; a copiar
puntos_pinta:		; Las seis cifras de los puntos (0xE006) en la fila 23 y las del record (0xE02E) en la 22
	ld hl,0e006h		;8935   ; las cifras de los puntos...
	ld de,01ae8h		;8938   ; ...en la fila 23, columna 8
	ld bc,00006h		;893b   ; seis
	call 0005ch		;893e   ; LDIRVM
	ld hl,0e02eh		;8941   ; las del record...
	ld de,01ac8h		;8944   ; ...en la fila 22, columna 8
	ld bc,00006h		;8947   ; seis
	jp 0005ch		;894a   ; LDIRVM
puntos_suma:		; Jugando, los puntos + A (BCD, las dos ultimas cifras, 0xE00E) con su acarreo; al pasar de 999999 el record se queda con los puntos; desde 0x1000 (10.000 en pantalla) una vida de reserva mas, una vez (0xE02D); y las cifras, el record y el marcador
	ld b,a			;894d   ; lo que se suma
	ld a,(0e000h)		;894e   ; jugando?
	and a			;8951
	ret z			;8952   ; no: nada
	ld a,(0e00eh)		;8953   ; las dos ultimas
	add a,b			;8956
	daa			;8957   ; en BCD
	ld (0e00eh),a		;8958   ; apuntadas
	jr nc,puntos_mira		;895b   ; sin acarreo
	ld a,001h		;895d   ; acarreo
puntos_suma_cien:
	ld b,a			;895f
	ld a,(0e00dh)		;8960   ; las centenas
	add a,b			;8963
	daa			;8964
	ld (0e00dh),a		;8965   ; apuntadas
	jr nc,puntos_mira		;8968
	ld a,001h		;896a   ; acarreo
	ld b,a			;896c   ; 1
	ld a,(0e00ch)		;896d   ; las decenas de millar
	add a,b			;8970
	daa			;8971   ; en BCD
	ld (0e00ch),a		;8972   ; apuntadas
	jr nc,puntos_mira		;8975
	ld a,(0e00eh)		;8977   ; se pasa: el record = los puntos
	ld (0e036h),a		;897a   ; el record
	ld a,(0e00dh)		;897d   ; las centenas
	ld (0e035h),a		;8980
	ld a,(0e00ch)		;8983   ; las de arriba
	ld (0e034h),a		;8986
puntos_mira:
	ld a,(0e00dh)		;8989   ; 0x1000 o mas (10.000 en pantalla)?
	cp 010h		;898c   ; 0x10
	jr c,L_899D		;898e   ; no
	ld a,(0e02dh)		;8990   ; ya dada?
	and a			;8993
	jr nz,L_899D		;8994   ; si
	inc a			;8996   ; dada
	ld (0e02dh),a		;8997
	call vida_suma		;899a   ; una vida mas
L_899D:
	call puntos_cifras		;899d   ; las cifras
	call record_mira		;89a0   ; el record
	jp puntos_pinta		;89a3   ; y al marcador
puntos_cifras:		; Los tres bytes BCD de los puntos (0xE00C) en cifras (0xE006)
	ld hl,0e006h		;89a6
	ld de,0e00ch		;89a9   ; los bytes BCD
	ld b,003h		;89ac   ; tres
cifras_bcd:		; B bytes BCD de DE a cifras en HL (dos por byte)
	ld a,(de)			;89ae   ; un byte
	ld c,a			;89af   ; guardado
	and 0f0h		;89b0   ; la cifra alta
	rrca			;89b2
	rrca			;89b3
	rrca			;89b4
	rrca			;89b5
	ld (hl),a			;89b6   ; apuntada
	inc hl			;89b7   ; la siguiente
	ld a,c			;89b8   ; la baja
	and 00fh		;89b9   ; la baja
	ld (hl),a			;89bb   ; la baja
	inc hl			;89bc   ; la siguiente
	inc de			;89bd   ; el siguiente
	djnz cifras_bcd		;89be   ; tres bytes
	ret			;89c0
record_mira:		; Si los puntos (0xE00C) pasan del record (0xE034), son el record nuevo y sus cifras (0xE02E)
	ld de,0e034h		;89c1   ; el record
	ld hl,0e00ch		;89c4   ; los puntos
	ld a,(de)			;89c7   ; el byte alto...
	ld b,a			;89c8
	ld a,(hl)			;89c9   ; ...contra el de los puntos
	cp b			;89ca   ; menos: nada
	ret c			;89cb   ; menor: nada
	jr nz,record_nuevo_3		;89cc   ; mayor: record nuevo
	inc de			;89ce   ; iguales: el siguiente
	inc hl			;89cf
	ld a,(de)			;89d0   ; el siguiente
	ld b,a			;89d1
	ld a,(hl)			;89d2
	cp b			;89d3   ; menos?
	ret c			;89d4   ; menor: nada
	jr nz,record_nuevo_2		;89d5   ; mas: record
	inc de			;89d7   ; el bajo
	inc hl			;89d8
	ld a,(de)			;89d9   ; el siguiente
	ld b,a			;89da
	ld a,(hl)			;89db
	cp b			;89dc   ; menos?
	ret c			;89dd   ; menor: nada
	jr record_nuevo		;89de   ; igual o mas: record
record_nuevo_3:
	inc de			;89e0
	inc hl			;89e1
record_nuevo_2:
	inc de			;89e2
	inc hl			;89e3
record_nuevo:		; Los tres bytes, hacia atras
	ld bc,00003h		;89e4   ; tres bytes...
	lddr		;89e7   ; ...hacia atras
	ld hl,0e02eh		;89e9   ; sus cifras
	ld de,0e034h		;89ec   ; el record
	ld b,003h		;89ef   ; tres bytes
	jr cifras_bcd		;89f1   ; sus cifras
espera_musica:		; Espera 8 cuadros, despues hasta que la musica acabe (0xE2BD y 0xE2BE a 0; en el titulo, el boton la corta) y despues 16 cuadros mas
	xor a			;89f3   ; la cuenta a 0
	ld (0e010h),a		;89f4
espera_ocho:
	ld a,(0e010h)		;89f7   ; 8 cuadros
	cp 008h		;89fa
	jr c,espera_ocho		;89fc
espera_musica_va:
	call prota_vram		;89fe   ; los sprites del protagonista
	ld a,(0e000h)		;8a01   ; jugando?
	and a			;8a04
	jr nz,espera_musica_mira		;8a05
	ld a,(0e026h)		;8a07   ; el boton?
	and a			;8a0a
	ret nz			;8a0b
espera_musica_mira:
	ld a,(0e2bdh)		;8a0c   ; sonando?
	and a			;8a0f
	jr nz,espera_musica_va		;8a10
	ld a,(0e2beh)		;8a12   ; pedida?
	and a			;8a15
	jr nz,espera_musica_va		;8a16
	ld (0e010h),a		;8a18   ; la cuenta a 0
	call sonido_reinicia		;8a1b   ; el sonido, a cero
espera_dieciseis:
	ld a,(0e010h)		;8a1e   ; 16 cuadros mas
	cp 010h		;8a21
	jr c,espera_dieciseis		;8a23
	ret			;8a25
interrupcion:		; La interrupcion (H.TIMI): el sonido a cero si se pidio (0xE002); los sprites rotan (0x8B59); sin musica ni efectos, el canal C callado; el motor; 8 cuentas (0xE010-0xE017) + 1; jugando, STOP (la pausa, 0xE1B2), los botones y la palanca; si no, la demostracion o el titulo
	ld a,(0e002h)		;8a26   ; se pidio el sonido a cero?
	cp 0ffh		;8a29   ; 0xFF?
	jr nz,interrupcion_sigue		;8a2b
	call sonido_cero		;8a2d   ; a cero
	xor a			;8a30   ; atendido
	ld (0e002h),a		;8a31
interrupcion_sigue:
	call sprites_rota		;8a34   ; los sprites rotan
	ld a,(0e2bdh)		;8a37   ; una musica sonando?
	and a			;8a3a
	jr nz,interrupcion_motor		;8a3b   ; si
	ld a,(0e2bfh)		;8a3d   ; un efecto de B y C?
	and a			;8a40
	jr nz,interrupcion_motor		;8a41   ; si
	ld e,0ffh		;8a43   ; no: el volumen del canal C...
	ld a,008h		;8a45   ; ...(el registro 8)...
	call 00093h		;8a47   ; ...WRTPSG
interrupcion_motor:
	call sonido		;8a4a   ; el motor de sonido
	ld hl,0e010h		;8a4d   ; las cuentas de 0xE010...
	ld b,008h		;8a50   ; ...ocho...
L_8A52:
	inc (hl)			;8a52   ; ...+ 1
	inc hl			;8a53
	djnz L_8A52		;8a54
	ld a,(0e000h)		;8a56   ; jugando?
	and a			;8a59
	jr z,interrupcion_quieto		;8a5a   ; no
	ld a,007h		;8a5c   ; la fila 7: STOP (bit 4)?
	call 00141h		;8a5e   ; SNSMAT
	bit 4,a		;8a61   ; STOP?
	jr z,L_8A6B		;8a63
	xor a			;8a65   ; suelta
	ld (0e1b3h),a		;8a66
	jr L_8A78		;8a69
L_8A6B:
	ld a,(0e1b3h)		;8a6b   ; ya atendida?
	and a			;8a6e
	jr nz,L_8A78		;8a6f
	inc a			;8a71   ; recien pulsada: la pausa (0xE1B2)
	ld (0e1b2h),a		;8a72   ; recien pulsada: la pausa (0xE1B2)
	ld (0e1b3h),a		;8a75
L_8A78:
	ld de,0e020h		;8a78   ; el boton 2 del mando (GTTRIG 3)...
	ld hl,0e021h		;8a7b   ; ...sostenido en 0xE021
	ld a,003h		;8a7e
	call boton_mando		;8a80
	ld de,0e022h		;8a83   ; el boton 1 del mando (GTTRIG 1)...
	ld hl,0e023h		;8a86   ; ...sostenido en 0xE023
	ld a,001h		;8a89
	call boton_mando		;8a8b
	ld a,001h		;8a8e   ; el boton 1 del mando...
	call 000d8h		;8a90   ; GTTRIG
	ld (0e03bh),a		;8a93   ; ...en 0xE03B
	ld de,0e020h		;8a96   ; GRAPH y la barra
	ld hl,0e02bh		;8a99
	call botones_teclado		;8a9c
palanca:		; La palanca: los cursores o el mando 1 (GTSTCK 0 y 1), en 0xE180
	xor a			;8a9f
	call 000d5h		;8aa0   ; GTSTCK 0: los cursores
	ld (0e181h),a		;8aa3
	ld a,001h		;8aa6
	call 000d5h		;8aa8   ; GTSTCK 1: el mando 1
	ld c,a			;8aab
	ld a,(0e181h)		;8aac
	or c			;8aaf   ; uno u otro
	ld (0e180h),a		;8ab0   ; la palanca
	ret			;8ab3
interrupcion_quieto:		; Fuera de partida: en la demostracion (0xE027), cada 16 cuadros un byte de la lista de 0xE037 (desde 0x4000, la cabecera y el arranque del cartucho): la mitad baja es la palanca y la alta los botones (0x10 el 2, 0x20 el 1, otra los dos); en el titulo, el boton de empezar (0xE026) y la palanca
	ld a,(0e027h)		;8ab4   ; la demostracion?
	and a			;8ab7
	jr z,interrupcion_titulo		;8ab8
	ld a,(0e014h)		;8aba   ; cada 16 cuadros
	cp 010h		;8abd
	jr c,empezar_lee		;8abf
	xor a			;8ac1
	ld (0e014h),a		;8ac2
	ld hl,(0e037h)		;8ac5   ; la lista
	ld a,(hl)			;8ac8   ; un byte
	inc hl			;8ac9   ; el siguiente
	ld (0e037h),hl		;8aca
	ld b,a			;8acd   ; guardado
	and 00fh		;8ace   ; la palanca
	ld (0e180h),a		;8ad0
	ld a,b			;8ad3
	and 0f0h		;8ad4   ; los botones
	and a			;8ad6
	jr z,empezar_lee		;8ad7
	cp 010h		;8ad9   ; 0x10: el boton 2 (0xE020)
	jr nz,demo_boton1		;8adb
	ld (0e020h),a		;8add
	jr empezar_lee		;8ae0
demo_boton1:		; 0x20: el boton 1 (0xE022)
	cp 020h		;8ae2   ; 0x20: el boton 1
	jr nz,demo_los_dos		;8ae4
	ld (0e022h),a		;8ae6
	jr empezar_lee		;8ae9
demo_los_dos:		; Los dos botones
	ld (0e020h),a		;8aeb   ; otro: los dos
	ld (0e022h),a		;8aee
	jr empezar_lee		;8af1
interrupcion_titulo:
	call empezar_lee		;8af3
	jr palanca		;8af6
empezar_lee:		; El boton de empezar (0xE026): la barra o el boton 1 del mando
	ld de,0e026h		;8af8   ; la barra: recien pulsada en 0xE026...
	ld hl,0e025h		;8afb   ; ...sostenida en 0xE025
	call barra_lee		;8afe   ; la barra
	ld a,(de)			;8b01   ; recien pulsada...
	ld (0e181h),a		;8b02   ; ...guardada
	ld hl,0e021h		;8b05   ; el boton 1 del mando: sostenido en 0xE021
	ld a,001h		;8b08   ; GTTRIG 1
	call boton_mando		;8b0a   ; el boton
	ld a,(de)			;8b0d   ; ...o lo del mando
	ld b,a			;8b0e
	ld a,(0e181h)		;8b0f   ; una...
	or b			;8b12   ; ...u otro
	ld (de),a			;8b13
	ret			;8b14
boton_mando:		; GTTRIG A: lo recien pulsado en (DE) y lo sostenido en (HL)
	call 000d8h		;8b15   ; GTTRIG
	and a			;8b18
boton_mira:
	jr nz,boton_pulsado		;8b19   ; pulsado?
boton_suelto:
	ld (hl),000h		;8b1b   ; suelto
	ret			;8b1d
boton_pulsado:
	ld a,(hl)			;8b1e   ; ya sostenido?
	and a			;8b1f
	ret nz			;8b20
	inc a			;8b21   ; recien pulsado
	ld (hl),a			;8b22   ; sostenido
	ld (de),a			;8b23   ; recien pulsado
	ret			;8b24
barra_lee:		; La barra (fila 8, bit 0): lo mismo
	ld a,008h		;8b25   ; la fila 8...
	call 00141h		;8b27   ; SNSMAT
	rrca			;8b2a   ; el bit 0: pulsada = 0
	jr nc,boton_pulsado		;8b2b
	jr boton_suelto		;8b2d
botones_teclado:		; La barra como boton 1 y GRAPH (fila 6, bit 2) como boton 2
	ld a,006h		;8b2f   ; la fila 6
	call 00141h		;8b31   ; SNSMAT
	cpl			;8b34   ; pulsada = 1
	bit 2,a		;8b35   ; GRAPH (bit 2)
	call boton_mira		;8b37
	inc hl			;8b3a   ; los siguientes
	inc de			;8b3b
	inc de			;8b3c
	ld a,008h		;8b3d   ; la fila 8
	call 00141h		;8b3f   ; SNSMAT
	cpl			;8b42
	push af			;8b43
	rrca			;8b44   ; la barra: el bit 0
	jr nc,barra_suelta		;8b45
	ld a,0ffh		;8b47   ; sostenida: 0xFF
	jr barra_sostenida		;8b49
barra_suelta:
	xor a			;8b4b   ; suelta: 0
barra_sostenida:
	ld b,a			;8b4c
	ld a,(0e03bh)		;8b4d   ; con el boton 1 del mando, sostenido
	or b			;8b50
	ld (0e03bh),a		;8b51
	pop af			;8b54   ; la fila 8
	bit 0,a		;8b55   ; la barra
	jr boton_mira		;8b57   ; recien pulsada?
sprites_rota:		; Cada cuadro, desde la interrupcion: los sprites 4-25 (0xE110) fuera; los de 0xE320-0xE470 que estan en pantalla (+4) se copian alli empezando cada vez por uno distinto (0xE185), para que con mas de cuatro en una linea parpadeen y no desaparezcan
	ld hl,0e110h		;8b59   ; 0xE110...
	ld (hl),0ech		;8b5c   ; ...fuera (Y 0xEC)...
	ld de,0e111h		;8b5e
	ld bc,00057h		;8b61   ; ...0x58 bytes
	ldir		;8b64
	ld hl,0e324h		;8b66   ; los de 0xE324 (16 bytes cada uno)
	ld bc,01400h		;8b69   ; ...20 de ellos; C, la cuenta
	ld de,00010h		;8b6c
sprites_cuenta:
	ld a,(hl)			;8b6f   ; en pantalla?
	and a			;8b70
	jr z,sprites_cuenta_sig		;8b71
	inc c			;8b73   ; uno mas
sprites_cuenta_sig:
	add hl,de			;8b74
	djnz sprites_cuenta		;8b75
	ld a,c			;8b77   ; ninguno?
	and a			;8b78
	ret z			;8b79
	ld a,(0e185h)		;8b7a   ; el primero de esta vez...
	inc a			;8b7d
	ld (0e185h),a		;8b7e
	cp c			;8b81   ; pasa de los que hay?
	jr c,L_8B88		;8b82
	xor a			;8b84   ; si: desde el primero
	ld (0e185h),a		;8b85
L_8B88:
	ld hl,0e324h		;8b88   ; desde 0xE324
	ld a,(0e185h)		;8b8b   ; el primero de esta vez
	and a			;8b8e
	jr z,sprites_rota_copia		;8b8f   ; el 0: desde aqui
	ld b,a			;8b91   ; saltar tantos
	ld de,00010h		;8b92
sprites_rota_salta:
	ld a,(hl)			;8b95   ; en pantalla?
	and a			;8b96
	jr z,sprites_rota_vacio		;8b97
	add hl,de			;8b99   ; el siguiente
	djnz sprites_rota_salta		;8b9a   ; uno menos que saltar
	jr sprites_rota_copia		;8b9c
sprites_rota_vacio:
	add hl,de			;8b9e   ; el siguiente, sin contar
	jr sprites_rota_salta		;8b9f
sprites_rota_copia:
	ld de,0e110h		;8ba1   ; a 0xE110
	ld b,c			;8ba4
sprites_rota_uno:
	ld a,(hl)			;8ba5   ; en pantalla?
	and a			;8ba6
	jr z,sprites_rota_libre		;8ba7
	push bc			;8ba9
	dec hl			;8baa   ; sus atributos (-4)
	dec hl			;8bab
	dec hl			;8bac
	dec hl			;8bad
	ld bc,00004h		;8bae   ; cuatro bytes
	ldir		;8bb1
	ld bc,00010h		;8bb3   ; el siguiente
	add hl,bc			;8bb6
	ld a,h			;8bb7   ; el final (0xE484)?
	cp 0e4h		;8bb8
	jr nz,sprites_rota_sig		;8bba
	ld a,l			;8bbc
	cp 084h		;8bbd
	jr z,sprites_rota_vuelta		;8bbf
sprites_rota_sig:
	pop bc			;8bc1
	djnz sprites_rota_uno		;8bc2
	ret			;8bc4
sprites_rota_libre:
	push bc			;8bc5   ; no esta: el siguiente
	ld bc,00010h		;8bc6
	add hl,bc			;8bc9
	pop bc			;8bca
	ld a,h			;8bcb   ; el final (0xE484)?
	cp 0e4h		;8bcc   ; el final (0xE484)?
	jr nz,sprites_rota_uno		;8bce
	ld a,l			;8bd0
	cp 084h		;8bd1
	jr nz,sprites_rota_uno		;8bd3
	ld hl,0e324h		;8bd5   ; la vuelta: desde el primero
	jr sprites_rota_uno		;8bd8
sprites_rota_vuelta:
	ld hl,0e324h		;8bda   ; la vuelta: desde el primero
	jr sprites_rota_sig		;8bdd
titulo_nombre:		; El nombre (一寸法師の どんなもんだい, 0x8D6D): tres filas de 12 casillas en las filas 7-9 (columna 8), の en las 10 y 11 (columna 15) y dos de 12 en las 12 y 13 (columna 12)
	ld hl,08d6dh		;8bdf   ; el nombre...
	ld de,018e8h		;8be2   ; ...en la fila 7, columna 8
	ld bc,0000ch		;8be5   ; 12 casillas
	call 0005ch		;8be8   ; LDIRVM
	ex de,hl			;8beb   ; lo que sigue
	ld de,01908h		;8bec   ; la fila 8
	ld bc,0000ch		;8bef
	call 0005ch		;8bf2   ; LDIRVM
	ex de,hl			;8bf5
	ld de,01928h		;8bf6   ; la fila 9
	ld bc,0000ch		;8bf9
	call 0005ch		;8bfc   ; LDIRVM
	ex de,hl			;8bff
	ld de,0194fh		;8c00   ; の, en la fila 10, columna 15
	ld bc,00002h		;8c03   ; 2 casillas
	call 0005ch		;8c06   ; LDIRVM
	ex de,hl			;8c09
	ld de,0196fh		;8c0a   ; en la fila 11
	ld bc,00002h		;8c0d
	call 0005ch		;8c10   ; LDIRVM
	ex de,hl			;8c13
	ld de,0198ch		;8c14   ; どんなもんだい: la fila 12, columna 12
	ld bc,0000ch		;8c17   ; 12 casillas
	call 0005ch		;8c1a   ; LDIRVM
	ex de,hl			;8c1d
	ld de,019ach		;8c1e   ; la fila 13
	ld bc,0000ch		;8c21
	call 0005ch		;8c24   ; LDIRVM
	ret			;8c27
presentacion:		; La presentacion de CASIO: cada 3 cuadros, dos CASIO entran por los lados (filas 11 y 12) y, desde el paso 9, otros dos bajan y suben hacia el centro; con el paso 21, la musica 4 y SOFTWARE (0x8B14) debajo; 128 cuadros o el boton y la pantalla en blanco
	ld a,001h		;8c28   ; el paso 1
	ld (0e187h),a		;8c2a
	ld hl,0180ch		;8c2d   ; el que baja: la fila 0, columna 12
	ld (0e189h),hl		;8c30
	ld hl,01aech		;8c33   ; el que sube: la fila 23
	ld (0e18bh),hl		;8c36
presentacion_cuadro:
	ld a,(0e010h)		;8c39   ; 3 cuadros
	cp 003h		;8c3c
	jr c,presentacion_cuadro		;8c3e
	xor a			;8c40
	ld (0e010h),a		;8c41
	call presentacion_centro		;8c44   ; los de arriba y abajo
	call presentacion_lados		;8c47
	ld hl,0e187h		;8c4a   ; un paso mas
	inc (hl)			;8c4d
	ld a,(hl)			;8c4e
	cp 015h		;8c4f   ; 21?
	jr nc,presentacion_junta		;8c51
	cp 009h		;8c53   ; desde el 9...
	jr c,presentacion_sigue		;8c55
	ld hl,(0e189h)		;8c57   ; ...el de arriba baja una fila...
	ld bc,00020h		;8c5a
	add hl,bc			;8c5d
	ld (0e189h),hl		;8c5e
	ld hl,(0e18bh)		;8c61   ; ...y el de abajo sube
	sbc hl,bc		;8c64
	ld (0e18bh),hl		;8c66
presentacion_sigue:
	jr presentacion_cuadro		;8c69
presentacion_junta:
	ld a,004h		;8c6b   ; la musica 4
	call musica_pide		;8c6d   ; pide la musica
	ld hl,08e0eh		;8c70
	ld de,019cch		;8c73   ; ...en la fila 14, columna 12
	ld bc,00007h		;8c76
	call 0005ch		;8c79   ; LDIRVM
presentacion_espera:
	ld a,(0e026h)		;8c7c   ; el boton?
	and a			;8c7f
	jr nz,presentacion_fin		;8c80
	ld a,(0e010h)		;8c82   ; 128 cuadros?
	cp 080h		;8c85
	jr c,presentacion_espera		;8c87
presentacion_fin:
	xor a			;8c89
	ld (0e026h),a		;8c8a
	call sonido_reinicia		;8c8d   ; el sonido a cero
	call nombres_borra		;8c90
	ret			;8c93
presentacion_centro:		; Desde el paso 9: el CASIO que baja (0xE189) y el que sube (0xE18B), cada uno con una fila en blanco detras para borrar su rastro
	ld a,(0e187h)		;8c94   ; el paso...
	cp 009h		;8c97   ; ...9?
	ret c			;8c99   ; antes: nada
	ld bc,00008h		;8c9a   ; 8 casillas
	ld hl,08d64h		;8c9d   ; la fila de abajo de CASIO (0x8D64)...
	ld de,(0e189h)		;8ca0   ; ...donde va el que baja
	call 0005ch		;8ca4   ; LDIRVM
	ld de,00020h		;8ca7   ; una fila arriba
	and a			;8caa
	sbc hl,de		;8cab
	ex de,hl			;8cad
	ld hl,08d5bh		;8cae   ; la de arriba (0x8D5B)
	ld bc,00008h		;8cb1
	call 0005ch		;8cb4   ; LDIRVM
	ld de,00020h		;8cb7   ; otra fila arriba
	and a			;8cba
	sbc hl,de		;8cbb
	ex de,hl			;8cbd
	ld hl,08dfeh		;8cbe   ; en blanco (0x8DFE)
	ld bc,00008h		;8cc1
	call 0005ch		;8cc4   ; LDIRVM
	ld bc,00008h		;8cc7   ; el que sube: 8 casillas
	ld hl,08d5bh		;8cca   ; la fila de arriba...
	ld de,(0e18bh)		;8ccd   ; ...donde va
	call 0005ch		;8cd1   ; LDIRVM
	ld de,00020h		;8cd4   ; una fila abajo
	add hl,de			;8cd7
	ex de,hl			;8cd8
	ld hl,08d64h		;8cd9   ; la de abajo
	ld bc,00008h		;8cdc
	call 0005ch		;8cdf   ; LDIRVM
	ld de,00020h		;8ce2   ; otra fila abajo
	add hl,de			;8ce5
	ex de,hl			;8ce6
	ld hl,08dfeh		;8ce7   ; en blanco
	ld bc,00008h		;8cea
	call 0005ch		;8ced   ; LDIRVM
	ret			;8cf0
presentacion_lados:		; Los dos CASIO de los lados en las filas 11 y 12: uno entra por la derecha casilla a casilla y el otro por la izquierda, leido desde el final
	ld a,(0e187h)		;8cf1   ; el paso
	ld c,a			;8cf4
	cp 009h		;8cf5   ; ...no mas de 9
	jr c,presentacion_arriba		;8cf7
	ld c,009h		;8cf9   ; 9 como mucho
presentacion_arriba:
	ld hl,01980h		;8cfb   ; en la fila 12, columna 0, menos el paso
	ld b,a			;8cfe   ; la columna, hacia la izquierda
	ld a,l			;8cff
	sub b			;8d00
	ld l,a			;8d01
	ex de,hl			;8d02
	ld hl,08d5bh		;8d03   ; la fila de arriba de CASIO...
	ld b,000h		;8d06
	call 0005ch		;8d08
	ld de,00020h		;8d0b
	add hl,de			;8d0e
	ex de,hl			;8d0f
	ld hl,08d64h		;8d10
	ld a,(0e187h)		;8d13
	cp 009h		;8d16
	jr c,presentacion_arriba_pon		;8d18
	ld a,009h		;8d1a
presentacion_arriba_pon:
	ld c,a			;8d1c   ; C casillas
	call 0005ch		;8d1d   ; LDIRVM
	ld hl,01960h		;8d20   ; el otro: la fila 11
	ld a,(0e187h)		;8d23
	ld c,a			;8d26
	cp 009h		;8d27   ; 9 o mas?
	jr c,presentacion_izq		;8d29
	sub 009h		;8d2b   ; pasado el 9, se mueve
	add a,l			;8d2d
	ld l,a			;8d2e
	ld c,009h		;8d2f   ; 9
presentacion_izq:
	ex de,hl			;8d31   ; DE: la VRAM
	ld hl,08d63h		;8d32   ; la fila de arriba, desde el final
	ld a,l			;8d35
	sub c			;8d36   ; - C
	jr nc,presentacion_izq_pon		;8d37
	dec h			;8d39
presentacion_izq_pon:
	ld l,a			;8d3a
	call 0005ch		;8d3b   ; LDIRVM
	ld de,00020h		;8d3e   ; una fila abajo
	add hl,de			;8d41
	ex de,hl			;8d42
	ld a,(0e187h)		;8d43   ; el paso
	ld c,a			;8d46
	cp 009h		;8d47
	jr c,presentacion_izq_abajo		;8d49
	ld c,009h		;8d4b
presentacion_izq_abajo:
	ld hl,08d6ch		;8d4d
	ld a,l			;8d50
	sub c			;8d51
	jr nc,L_8D55		;8d52
	dec h			;8d54
L_8D55:
	ld l,a			;8d55
	call 0005ch		;8d56
	ret			;8d59

; ----------------------------------------------------------------------
; DATOS textos: Los textos: CASIO en dos filas (0x8D5B y 0x8D64, de la
;   presentacion), el nombre (0x8D6D, 64 casillas; sus dos ultimas filas,
;   0x8D95, salen en grande en el final), GAME START (0x8DAD), CASIO (0x8DB7),
;   PUSH TRIG:1 OR SPACE (0x8DBD), COPYRIGHT 1987 (c) CASIO (0x8DD1), HISCORE
;   (0x8DE7), los rotulos de las vidas y de la escena (0x8DEF y 0x8DF2), GAME
;   OVER (0x8DF5), espacios (0x8DFE) y SOFTWARE (0x8E0E); letras desde la
;   casilla 0x11 (A), cifras desde la 0
;   0x8d5a..0x8e15  (187 bytes)
DATA_textos:
	defb 010h,070h,072h,074h,076h,078h,07ah,07ch,07eh,010h,071h,073h,075h,077h,079h,07bh	; 8d5a  .prtvxz|~.qsuwy{
	defb 07dh,07fh,010h,050h,051h,052h,053h,030h,031h,05ch,05dh,05eh,05fh,03ch,03dh,054h	; 8d6a  }..PQRS01\]^_<=T
	defb 055h,056h,057h,034h,035h,060h,061h,062h,063h,040h,041h,058h,059h,05ah,05bh,038h	; 8d7a  UVW45`abc@AXYZ[8
	defb 039h,064h,065h,066h,067h,044h,045h,032h,033h,036h,037h,068h,069h,06ah,06bh,048h	; 8d8a  9defgDE2367hijkH
	defb 049h,04ah,04bh,03ah,03bh,042h,043h,06ch,06dh,06eh,06fh,04ch,04dh,04eh,04fh,03eh	; 8d9a  IJK:;BClmnoLMNO>
	defb 03fh,046h,047h,017h,011h,01dh,015h,010h,023h,024h,011h,022h,024h,08ah,08bh,08ch	; 8daa  ?FG.....#$."$...
	defb 08dh,08eh,08fh,020h,025h,023h,018h,010h,024h,022h,019h,017h,00ah,001h,010h,01fh	; 8dba  ... %#..$"......
	defb 022h,010h,023h,020h,011h,013h,015h,013h,01fh,020h,029h,022h,019h,017h,018h,024h	; 8dca  ".# ..... )"...$
	defb 010h,001h,009h,008h,007h,010h,089h,010h,013h,011h,023h,019h,01fh,018h,019h,023h	; 8dda  ..........#....#
	defb 013h,01fh,022h,015h,00ah,032h,033h,00dh,034h,035h,00dh,017h,011h,01dh,015h,010h	; 8dea  .."..23.45......
	defb 01fh,026h,015h,022h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h,010h	; 8dfa  .&."............
	defb 010h,010h,010h,010h,080h,081h,082h,083h,084h,085h,086h	; 8e0a  ...........

; ======================================================================
; CODIGO 0x8e15..0x8f4e  (313 bytes)
; ======================================================================


protegido:		; Protegido (+0x1E): la cuenta (+0x1F) sube cada cuadro; cada 2 cuadros, los colores de siempre (5 y 0x0B) y, en los otros, transparente o, desde 0xB0, el 9: parpadea; en 0xD0 se acaba
	ld a,(ix+01eh)		;8e15   ; protegido?
	and a			;8e18
	ret z			;8e19   ; no: nada
	inc (ix+01fh)		;8e1a   ; la cuenta + 1
	ld a,(ix+01fh)		;8e1d
	cp 0d0h		;8e20   ; 0xD0?
	jr nc,protegido_fin		;8e22   ; si: se acaba
	and 002h		;8e24   ; cada 2 cuadros...
	and a			;8e26
	jr nz,protegido_colores		;8e27   ; ...los colores de siempre
	ld a,(ix+01fh)		;8e29   ; 0xB0 o mas?
	cp 0b0h		;8e2c
	jr c,L_8E39		;8e2e   ; no
	ld a,009h		;8e30   ; si: color 9...
	ld (ix+003h),a		;8e32   ; ...los dos sprites
	ld (ix+013h),a		;8e35
	ret			;8e38
L_8E39:
	xor a			;8e39   ; transparente...
	ld (ix+003h),a		;8e3a   ; ...los dos
	ld (ix+013h),a		;8e3d
	ret			;8e40
protegido_fin:
	xor a			;8e41   ; se acaba...
	ld (ix+01eh),a		;8e42   ; ...la proteccion
	ld (ix+01fh),a		;8e45   ; y la cuenta
protegido_colores:
	ld (ix+003h),005h		;8e48   ; color 5...
	ld (ix+013h),00bh		;8e4c   ; ...y 0x0B
	ret			;8e50
arma:		; El arma (0xE340, IX + 0x20): con el boton 1, si no esta agachado (+0x0A) ni llegando a la orilla (0xE051 = 1), el efecto 7, sale 3 pixeles por cuadro hasta 12 delante del protagonista (a la izquierda; en tierra, al lado al que mira) y vuelve de 2 en 2
	ld a,(ix+024h)		;8e51   ; ya fuera?
	and a			;8e54
	jr nz,arma_mueve		;8e55   ; si
	ld a,(0e022h)		;8e57   ; el boton 1?
	and a			;8e5a
	ret z			;8e5b   ; no
	xor a			;8e5c   ; atendido
	ld (0e022h),a		;8e5d
	ld a,(ix+00ah)		;8e60   ; agachado?
	and a			;8e63
	ret nz			;8e64   ; si: nada
	ld a,(0e051h)		;8e65   ; llegando a la orilla?
	cp 001h		;8e68
	ret z			;8e6a   ; si: nada
	ld a,007h		;8e6b   ; el efecto 7 del canal A
	call efecto_a_pide		;8e6d
	inc (ix+024h)		;8e70   ; fuera
	ld (ix+00ch),010h		;8e73   ; el protagonista, con el dibujo de atacar (+0x10)
arma_mueve:
	ld a,(ix+026h)		;8e77   ; volviendo?
	and a			;8e7a
	jr nz,arma_vuelve		;8e7b   ; si
	ld a,(ix+025h)		;8e7d   ; 3 pixeles mas...
	add a,003h		;8e80
	ld (ix+025h),a		;8e82
	cp 00ch		;8e85   ; ...hasta 12
	jr c,arma_sitio		;8e87   ; no
	inc (ix+026h)		;8e89   ; llegado: vuelve
	ret			;8e8c
arma_sitio:
	ld a,(ix+000h)		;8e8d   ; la Y del protagonista + 9...
	add a,009h		;8e90
	ld (ix+020h),a		;8e92   ; ...la del arma
	ld a,(0e051h)		;8e95   ; en el rio?
	and a			;8e98
	jr z,arma_izquierda		;8e99   ; 0: a la izquierda
	ld a,(ix+00dh)		;8e9b   ; mirando a la derecha?
	and a			;8e9e
	jr z,arma_izquierda		;8e9f   ; no
	ld b,(ix+025h)		;8ea1   ; a la derecha: la X + lo que ha salido...
	ld a,(ix+001h)		;8ea4
	add a,b			;8ea7
	add a,005h		;8ea8   ; ...+ 5
	jr arma_pon		;8eaa
arma_izquierda:
	ld b,(ix+025h)		;8eac   ; a la izquierda: la X - lo que ha salido...
	ld a,(ix+001h)		;8eaf
	sub b			;8eb2
	sub 005h		;8eb3   ; ...- 5
arma_pon:
	ld (ix+021h),a		;8eb5   ; la X del arma
	ld (ix+022h),018h		;8eb8   ; el dibujo 0x18
	ld (ix+023h),00fh		;8ebc   ; color 15
	ret			;8ec0
arma_vuelve:
	dec (ix+025h)		;8ec1   ; 2 pixeles menos
	jr z,arma_guarda		;8ec4   ; en casa?
	dec (ix+025h)		;8ec6
	jr nz,arma_sitio		;8ec9   ; no: a su sitio
arma_guarda:
	xor a			;8ecb   ; todo a 0:
	ld (ix+026h),a		;8ecc   ; volviendo
	ld (ix+024h),a		;8ecf   ; fuera
	ld (ix+00ch),a		;8ed2   ; el dibujo del protagonista
	ld (ix+025h),a		;8ed5   ; lo que ha salido
	ld (ix+020h),0ech		;8ed8   ; y el sprite fuera
	ret			;8edc
salto:		; El salto (+6): con el boton 2, si no esta llegando a la orilla (0xE051 = 1), el efecto 9 y 48 pasos de la tabla de 0x8F4E (lo que sube o baja la Y en cada uno); en tierra, con la palanca, hacia un lado (+8: 0 recto, 1 a la derecha, 2 a la izquierda)
	ld a,(ix+006h)		;8edd   ; saltando?
	and a			;8ee0
	jr nz,salto_paso		;8ee1   ; si
	ld a,(0e020h)		;8ee3   ; el boton 2?
	and a			;8ee6
	ret z			;8ee7   ; no
	xor a			;8ee8   ; atendido
	ld (0e020h),a		;8ee9
	ld a,(0e051h)		;8eec   ; llegando a la orilla?
	cp 001h		;8eef
	ret z			;8ef1   ; si: nada
	inc (ix+006h)		;8ef2   ; saltando
	ld a,009h		;8ef5   ; el efecto 9 del canal A
	call efecto_a_pide		;8ef7
	ld a,(0e051h)		;8efa   ; en tierra?
	cp 002h		;8efd
	jr z,salto_lado		;8eff   ; si
	ld c,000h		;8f01   ; recto
	jr salto_lado_pon		;8f03
salto_lado:
	ld c,002h		;8f05   ; a la izquierda (2)...
	ld a,(0e180h)		;8f07   ; ...con la palanca a la izquierda (7)...
	cp 007h		;8f0a
	jr z,salto_lado_pon		;8f0c
	cp 008h		;8f0e   ; ...o arriba a la izquierda (8)
	jr z,salto_lado_pon		;8f10
	dec c			;8f12   ; a la derecha (1)...
	cp 002h		;8f13   ; ...con la palanca arriba a la derecha (2)...
	jr z,salto_lado_pon		;8f15
	cp 003h		;8f17   ; ...o a la derecha (3)
	jr z,salto_lado_pon		;8f19
	dec c			;8f1b   ; si no, recto (0)
salto_lado_pon:
	ld (ix+008h),c		;8f1c   ; el lado
salto_paso:
	xor a			;8f1f   ; el boton 2, atendido
	ld (0e020h),a		;8f20
	ld a,(ix+007h)		;8f23   ; el paso...
	cp 030h		;8f26   ; ...48?
	jr nz,salto_tabla		;8f28   ; no
salto_fin:
	ld (ix+006h),000h		;8f2a   ; en el suelo:
	ld (ix+007h),000h		;8f2e   ; el paso a 0
	ld (ix+008h),000h		;8f32   ; el lado a 0
	ret			;8f36
salto_tabla:
	ld hl,08f4eh		;8f37   ; la tabla (0x8F4E)...
	ld a,(ix+007h)		;8f3a   ; ...el paso...
	inc (ix+007h)		;8f3d   ; ...y el siguiente
	add a,l			;8f40
	jr nc,L_8F44		;8f41
	inc h			;8f43
L_8F44:
	ld l,a			;8f44
	ld a,(hl)			;8f45   ; lo que se mueve
	ld b,(ix+000h)		;8f46   ; la Y...
	add a,b			;8f49   ; ...+ eso
	ld (ix+000h),a		;8f4a
	ret			;8f4d

; ----------------------------------------------------------------------
; DATOS salto_tabla_y: Los 48 pasos del salto: lo que se suma a la Y del
;   protagonista en cada uno (negativo, sube)
;   0x8f4e..0x8f7e  (48 bytes)
DATA_salto_tabla_y:
	defb 0fdh,0fdh,0fdh,0fdh,0fdh,0fdh,0fdh,0feh,0feh,0feh,0feh,0feh,0ffh,0ffh,0ffh,000h	; 8f4e  ................
	defb 0ffh,000h,0ffh,000h,000h,0ffh,000h,000h,000h,000h,001h,000h,000h,001h,000h,001h	; 8f5e  ................
	defb 000h,001h,001h,001h,002h,002h,002h,002h,002h,003h,003h,003h,003h,003h,003h,003h	; 8f6e  ................

; ======================================================================
; CODIGO 0x8f7e..0x91c1  (579 bytes)
; ======================================================================


prota_sprites:		; Los sprites del protagonista: en el rio, su cuenco (0xE300/0xE310): el dibujo 0x80 o 0x84 (cada 16 cuadros), una X menos y, si no salta, 11 por debajo; y el dibujo del protagonista: el paso (+0x0C) + el lado (+0x0D, 0 o 0x80)
	ld a,(0e051h)		;8f7e   ; en tierra?
	cp 002h		;8f81
	jr z,prota_dibujo		;8f83   ; si: sin cuenco
	ld a,(0e012h)		;8f85   ; cada 16 cuadros...
	and 010h		;8f88
	rrca			;8f8a
	rrca			;8f8b
	add a,080h		;8f8c   ; ...0x80 o 0x84
	ld (ix-00eh),a		;8f8e   ; el dibujo de 0xE312
	ld a,(ix+001h)		;8f91   ; una X menos que el protagonista...
	sub 001h		;8f94
	ld (ix-00fh),a		;8f96   ; ...para 0xE311
	ld a,(ix+006h)		;8f99   ; saltando?
	and a			;8f9c
	jr nz,prota_dibujo		;8f9d   ; si: se queda en el agua
	ld a,(ix+000h)		;8f9f   ; la Y del protagonista + 11...
	add a,00bh		;8fa2
	ld (ix-010h),a		;8fa4   ; ...para 0xE310
	ld (ix-00dh),001h		;8fa7   ; color 1
prota_dibujo:
	ld a,(ix+00ch)		;8fab   ; el paso...
	ld b,(ix+00dh)		;8fae   ; ...+ el lado
	add a,b			;8fb1
	ld (ix+002h),a		;8fb2   ; en el primer sprite
	add a,004h		;8fb5   ; el +4...
	ld (ix+012h),a		;8fb7   ; ...en el segundo
sprites_sitio:		; El segundo sprite, en la misma Y y X
	ld a,(ix+000h)		;8fba   ; la Y
	ld (ix+010h),a		;8fbd
	ld a,(ix+001h)		;8fc0   ; la X
	ld (ix+011h),a		;8fc3
	ret			;8fc6
prota_mueve:		; El protagonista con la palanca (no llegando a la orilla, 0xE051 = 1): en el rio, la corriente lo lleva a la derecha, un pixel cada 3 cuadros, y contra el borde (X 0xF4) es un golpe; saltando a un lado, ese lado; con el arma fuera, quieto; arriba y abajo cambia de Y (0x68-0x98), a los lados de X (0x19-0xE0); en tierra, arriba gasta uno de 0xE054 (protegido un rato) y abajo se agacha (+0x0A)
	ld a,(0e051h)		;8fc7   ; llegando a la orilla?
	cp 001h		;8fca
	ret z			;8fcc   ; si: nada
	cp 002h		;8fcd   ; en tierra?
	jr z,prota_palanca		;8fcf   ; si: sin corriente
	inc (ix+009h)		;8fd1   ; la corriente: cada 3 cuadros...
	ld a,(ix+009h)		;8fd4
	cp 003h		;8fd7
	jr c,prota_palanca		;8fd9
	ld (ix+009h),000h		;8fdb   ; ...a 0
	ld a,(ix+001h)		;8fdf   ; la X...
	cp 0f4h		;8fe2   ; ...0xF4 o mas?
	jr nc,prota_borde		;8fe4   ; si: contra el borde
	inc (ix+001h)		;8fe6   ; un pixel a la derecha
	jr prota_palanca		;8fe9
prota_borde:
	call golpe		;8feb   ; un golpe
prota_palanca:
	ld (ix+00ah),000h		;8fee   ; de pie
	ld a,(ix+008h)		;8ff2   ; saltando a la derecha?
	cp 001h		;8ff5
	jp z,prota_derecha		;8ff7   ; si
	cp 002h		;8ffa   ; a la izquierda?
	jp z,prota_izquierda		;8ffc   ; si
	ld a,(ix+024h)		;8fff   ; el arma fuera?
	and a			;9002
	ret nz			;9003   ; si: quieto
	ld a,(0e180h)		;9004   ; la palanca
	and a			;9007   ; suelta?
	jr z,prota_quieto		;9008   ; si
	cp 001h		;900a   ; arriba?
	jr z,prota_arriba		;900c
	cp 005h		;900e   ; arriba a la derecha, derecha o abajo a la derecha?
	jp c,prota_derecha		;9010
	jr z,prota_abajo		;9013   ; abajo?
	jp prota_izquierda		;9015   ; si no, a la izquierda
prota_quieto:
	ld a,(ix+024h)		;9018   ; el arma fuera?
	and a			;901b
	ret nz			;901c   ; si
	ld (ix+00ch),000h		;901d   ; el paso 0
	ret			;9021
prota_arriba:
	ld a,(0e051h)		;9022   ; en tierra?
	cp 002h		;9025
	jr z,prota_gasta		;9027   ; si: gastar uno
	ld a,(ix+006h)		;9029   ; saltando?
	and a			;902c
	ret nz			;902d   ; si: nada
	ld a,(ix+000h)		;902e   ; la Y...
	cp 068h		;9031   ; ...0x68 o menos?
	ret c			;9033   ; si: no sube mas
	dec (ix+000h)		;9034   ; sube
prota_paso:
	ld a,(0e012h)		;9037   ; cada 8 cuadros...
	and 008h		;903a
	ld (ix+00ch),a		;903c   ; ...el paso
	ret			;903f
prota_gasta:		; En tierra, arriba: con uno de 0xE054, sin estar protegido y con algo en la barra de abajo, sale el objeto de tipo 5 (0xE380) delante, uno menos y protegido; la cuenta empieza en la escena x 16 (en la segunda vuelta, 0x50)
	ld a,(0e054h)		;9040   ; 0xE054?
	and a			;9043
	ret z			;9044   ; ninguno: nada
	ld a,(ix+01eh)		;9045   ; protegido?
	and a			;9048
	ret nz			;9049   ; si: nada
	ld a,(0e1b7h)		;904a   ; la barra de abajo...
	and a			;904d
	ret z			;904e   ; ...vacia: nada
	ld a,(ix+000h)		;904f   ; la Y del protagonista...
	ld (0e380h),a		;9052   ; ...para 0xE380
	ld a,(ix+001h)		;9055   ; su X + 16...
	add a,010h		;9058
	ld (0e381h),a		;905a   ; ...para 0xE380
	ld a,005h		;905d   ; el tipo 5...
	ld (0e384h),a		;905f   ; ...en pantalla
	call e054_gasta		;9062   ; uno menos
	ld (ix+01eh),001h		;9065   ; protegido
	ld a,(0e004h)		;9069   ; la segunda vuelta?
	and a			;906c
	jr z,prota_gasta_cuenta		;906d   ; no
	ld (ix+01fh),050h		;906f   ; si: la cuenta desde 0x50
	ret			;9073
prota_gasta_cuenta:
	ld a,(0e003h)		;9074   ; la escena...
	rlca			;9077   ; ...x 16...
	rlca			;9078
	rlca			;9079
	rlca			;907a
	ld (ix+01fh),a		;907b   ; ...la cuenta
	ret			;907e
prota_abajo:
	ld a,(0e051h)		;907f   ; en tierra?
	cp 002h		;9082
	jr z,prota_agacha		;9084   ; si: se agacha
	ld a,(ix+006h)		;9086   ; saltando?
	and a			;9089
	ret nz			;908a   ; si: nada
	ld a,(ix+000h)		;908b   ; la Y...
	cp 098h		;908e   ; ...0x98 o mas?
	ret nc			;9090   ; si: no baja mas
	inc (ix+000h)		;9091   ; baja
	jr prota_paso		;9094   ; y el paso
prota_agacha:
	ld a,(ix+006h)		;9096   ; saltando?
	and a			;9099
	ret nz			;909a   ; si: nada
	ld a,(ix+024h)		;909b   ; el arma fuera?
	and a			;909e
	ret nz			;909f   ; si: nada
	ld (ix+00ah),001h		;90a0   ; agachado
	ld (ix+00ch),01ch		;90a4   ; el dibujo 0x1C
	ret			;90a8
prota_derecha:
	ld a,(0e051h)		;90a9   ; en el rio?
	and a			;90ac
	jr z,prota_derecha_va		;90ad   ; si: mira a la izquierda igual
	ld (ix+00dh),080h		;90af   ; mirando a la derecha
prota_derecha_va:
	ld a,(ix+024h)		;90b3   ; el arma fuera?
	and a			;90b6
	jr nz,prota_derecha_x		;90b7   ; si: sin paso
	ld a,(0e012h)		;90b9   ; cada 8 cuadros...
	and 008h		;90bc
	ld (ix+00ch),a		;90be   ; ...el paso
prota_derecha_x:
	ld a,(ix+001h)		;90c1   ; la X...
	cp 0e0h		;90c4   ; ...0xE0 o mas?
	jr nc,prota_lado_fin		;90c6   ; si: no pasa
	inc (ix+001h)		;90c8   ; a la derecha
prota_lado_fin:
	ld a,(0e051h)		;90cb   ; en tierra?
	cp 002h		;90ce
	ret z			;90d0   ; si: listo
	jp prota_paso		;90d1   ; el paso
prota_izquierda:
	ld (ix+00dh),000h		;90d4   ; mirando a la izquierda
	ld a,(ix+024h)		;90d8   ; el arma fuera?
	and a			;90db
	jr nz,prota_izquierda_x		;90dc   ; si: sin paso
	ld a,(0e012h)		;90de   ; cada 8 cuadros...
	and 008h		;90e1
	ld (ix+00ch),a		;90e3   ; ...el paso
prota_izquierda_x:
	ld a,(ix+001h)		;90e6   ; la X...
	cp 019h		;90e9   ; ...menos de 0x19?
	ret c			;90eb   ; si: no pasa
	dec (ix+001h)		;90ec   ; a la izquierda
	jr prota_lado_fin		;90ef
rio_decorado:		; El decorado del rio: el agua (0x91C1: filas 14-21, casillas 0x90-0x93) en la pantalla; el mapa de 192 x 14 casillas (0xE600, filas de 0xC0) en blanco y con los dibujos de la escena (la lista de 0x4460: fila, columna y dibujo, hasta 0xFF), la fila de abajo de 0xA1 y 0xA0, las columnas 0-0x3F copiadas en 0x40-0x7F, y pintado desde el principio
	ld hl,0e7c0h		;90f1   ; (HL no sirve: lo pone trozo_rect2)
	ld de,091c1h		;90f4   ; el agua (0x91C1)
	call trozo_rect2		;90f7   ; en 0xE600
	call decorado_pinta		;90fa   ; a la pantalla
	ld hl,0e600h		;90fd   ; el mapa...
	ld bc,00a80h		;9100   ; ...0xA80 bytes (14 filas de 192)...
L_9103:
	ld (hl),010h		;9103   ; ...en blanco (0x10)
	inc hl			;9105
	dec bc			;9106
	ld a,c			;9107
	or b			;9108
	jr nz,L_9103		;9109
	ld hl,0e600h		;910b
	ld a,(0e003h)		;910e   ; la escena...
	ld hl,04460h		;9111   ; ...en la tabla de 0x4460
	add a,a			;9114   ; x 2
	add a,l			;9115
	jr nc,L_9119		;9116
	inc h			;9118
L_9119:
	ld l,a			;9119
	ld e,(hl)			;911a   ; su lista
	inc hl			;911b
	ld d,(hl)			;911c
rio_decorado_uno:
	ld a,(de)			;911d   ; el final?
	cp 0ffh		;911e
	jr z,rio_decorado_suelo		;9120   ; si
	call mapa_sitio		;9122   ; su sitio en el mapa
	call mapa_dibujo		;9125   ; el dibujo
	jr rio_decorado_uno		;9128
rio_decorado_suelo:
	ld hl,0efc0h		;912a   ; la fila 13 del mapa...
	ld b,060h		;912d   ; ...96 veces...
L_912F:
	ld (hl),0a1h		;912f   ; ...0xA1...
	inc hl			;9131
	ld (hl),0a0h		;9132   ; ...y 0xA0
	inc hl			;9134
	djnz L_912F		;9135
	ld hl,0e600h		;9137   ; las columnas 0-0x3F...
	ld (0e1a0h),hl		;913a
	ld de,0e640h		;913d   ; ...copiadas en 0x40-0x7F
	ld (0e1a2h),de		;9140
	ld b,00eh		;9144   ; 14 filas
rio_decorado_copia:
	ld hl,(0e1a0h)		;9146
	ld de,(0e1a2h)		;9149
	push bc			;914d
	ld bc,00040h		;914e   ; 0x40 casillas
	ldir		;9151   ; copiadas
	pop bc			;9153
	ld hl,(0e1a0h)		;9154   ; la fila siguiente (+0xC0)
	ld de,000c0h		;9157
	add hl,de			;915a
	ld (0e1a0h),hl		;915b
	ld hl,(0e1a2h)		;915e
	add hl,de			;9161
	ld (0e1a2h),hl		;9162
	djnz rio_decorado_copia		;9165   ; una fila menos
	xor a			;9167   ; el avance a 0...
	ld (0e190h),a		;9168
	ld (0e191h),a		;916b   ; ...su cuenta...
	ld (0e192h),a		;916e   ; ...la del agua...
	ld (0e193h),a		;9171   ; ...y su paso
	call agua_dibuja		;9174   ; el agua
	jp rio_pinta		;9177   ; y el mapa en pantalla
mapa_sitio:		; HL = 0xE600 + la fila (A) x 0xC0 + la columna (DE + 1); DE, detras
	ld hl,0e600h		;917a   ; el mapa
	and a			;917d   ; la fila 0?
	jr z,L_9189		;917e
	push de			;9180
	ld de,000c0h		;9181   ; filas de 0xC0
	ld b,a			;9184
L_9185:
	add hl,de			;9185   ; x la fila
	djnz L_9185		;9186
	pop de			;9188
L_9189:
	inc de			;9189   ; la columna
	ld a,(de)			;918a
	inc de			;918b
	add a,l			;918c   ; + la columna
	jr nc,L_9190		;918d
	inc h			;918f
L_9190:
	ld l,a			;9190
	ret			;9191
mapa_dibujo:		; El dibujo de la direccion de (DE) en HL, con filas de 0xC0; DE, detras
	ld a,(de)			;9192   ; la direccion...
	ld c,a			;9193
	inc de			;9194
	ld a,(de)			;9195   ; ...del dibujo
	ld b,a			;9196
	inc de			;9197
	push de			;9198
	ld e,c			;9199
	ld d,b			;919a
	call dibujo_pon		;919b   ; a pintarlo
	pop de			;919e
	ret			;919f
dibujo_pon:		; Un dibujo de casillas (ancho, alto y las casillas; 0, transparente) en HL, en el mapa del rio (filas de 0xC0)
	ld a,(de)			;91a0   ; el ancho
	ld (0e1a0h),a		;91a1
	inc de			;91a4
	ld a,(de)			;91a5   ; el alto
	ld b,a			;91a6
	inc de			;91a7
dibujo_fila:
	ld a,(0e1a0h)		;91a8
	ld c,a			;91ab
	push hl			;91ac
dibujo_casilla:
	ld a,(de)			;91ad   ; una casilla
	and a			;91ae   ; 0: se deja lo que habia
	jr z,L_91B2		;91af
	ld (hl),a			;91b1
L_91B2:
	inc de			;91b2   ; la siguiente
	inc hl			;91b3
	dec c			;91b4   ; una menos
	jr nz,dibujo_casilla		;91b5   ; la fila entera
	pop hl			;91b7   ; su principio
	push de			;91b8
	ld de,000c0h		;91b9   ; una fila abajo: +0xC0
	add hl,de			;91bc
	pop de			;91bd
	djnz dibujo_fila		;91be
	ret			;91c0

; ----------------------------------------------------------------------
; DATOS rio_agua: El agua del rio para trozo_rect2: la fila 14, columna 0, 32
;   x 8 casillas desde la 0x90; y 0xFF
;   0x91c1..0x91c7  (6 bytes)
DATA_rio_agua:
	defb 00eh,000h,020h,008h,090h,0ffh	; 91c1

; ======================================================================
; CODIGO 0x91c7..0x9445  (638 bytes)
; ======================================================================


orilla_llega:		; Acabado el mapa del rio, la orilla (0xE051 = 1)
	ld a,001h		;91c7   ; llegando a la orilla
	ld (0e051h),a		;91c9
orilla:		; Llegando a la orilla (0xE051 = 1): la orilla (0x4A1E) en la fila 13 y el protagonista, solo, hacia la izquierda hasta X 0x10; alli, a tierra (0xE051 = 2)
	ld hl,019a0h		;91cc   ; la orilla, en la fila 13...
	ld de,04a1eh		;91cf   ; ...(0x4A1E)
	call dibujo_mapa		;91d2   ; en la pantalla
	ld a,(ix+001h)		;91d5   ; la X del protagonista
	cp 010h		;91d8   ; menos de 0x10?
	jr c,orilla_mira		;91da   ; si: a tierra
	dec (ix+001h)		;91dc   ; a la izquierda
	ld (ix+002h),000h		;91df   ; el dibujo 0...
	ld (ix+012h),004h		;91e3   ; ...y el 4
	ld (ix+020h),0ech		;91e7   ; el arma fuera
	ret			;91eb
orilla_mira:
	ld a,(0e051h)		;91ec   ; llegando a la orilla?
	cp 001h		;91ef
	ret nz			;91f1   ; no: nada
	inc a			;91f2   ; en tierra (2)
	ld (0e051h),a		;91f3
tierra:		; En tierra: los sprites fuera, el salto acabado, la pantalla se cierra, las casillas del decorado y el de tierra de la escena, el protagonista en Y 0x70 y X 0xA0 mirando a la izquierda y los objetos de tierra (0x9B04)
	ld (ix+000h),0ech		;91f6   ; fuera: el protagonista...
	ld (ix+010h),0ech		;91fa   ; ...su segundo sprite...
	ld (ix-010h),0ech		;91fe   ; ...y el cuenco
	ld (ix-020h),0ech		;9202
	call salto_fin		;9206   ; sin salto
	call todo_fuera		;9209   ; todo fuera
	call pantalla_cierra		;920c   ; la pantalla se cierra
	call decorado_dibujos		;920f   ; las casillas
	call tierra_decorado		;9212   ; el decorado de tierra
	call decorado_pinta		;9215   ; a la pantalla
	ld a,007h		;9218   ; la palanca: a la izquierda (7)
	ld (0e180h),a		;921a
	ld (ix+000h),070h		;921d   ; Y 0x70
	call arma_guarda		;9221   ; sin arma
	xor a			;9224   ; los botones a 0
	ld (0e020h),a		;9225
	ld (0e022h),a		;9228
	ld (ix+003h),005h		;922b   ; color 5
	ld (ix+00ch),000h		;922f   ; el paso 0
	ld (ix+001h),0a0h		;9233   ; X 0xA0
	call prota_mueve		;9237   ; una vez con la palanca
	call prota_sprites		;923a   ; sus sprites
	call jefe_pon		;923d   ; los objetos de tierra
	ret			;9240
rio_avanza:		; El rio avanza: cada 0x30 cuadros (0xE191) el mapa una columna (0xE190); al llegar a 0x7F, la orilla; fuera del rio, la orilla
	ld a,(0e051h)		;9241   ; en el rio?
	and a			;9244
	jp nz,orilla		;9245   ; no
	ld a,(0e191h)		;9248   ; la cuenta...
	inc a			;924b   ; ...+ 1
	ld (0e191h),a		;924c
	cp 030h		;924f   ; 0x30?
	ret c			;9251   ; no
	xor a			;9252   ; a 0
	ld (0e191h),a		;9253
	ld a,(0e190h)		;9256   ; el avance...
	cp 07fh		;9259   ; ...0x7F?
	jp nc,orilla_llega		;925b   ; si: la orilla
	inc a			;925e   ; una columna mas
	ld (0e190h),a		;925f
rio_pinta:		; Las 14 filas de arriba de la pantalla desde el mapa (0xE61F + el avance), cada fila al reves: la columna 0 de la pantalla es la 31 del tramo; el decorado corre hacia la derecha
	ld hl,0e61fh		;9262   ; la columna 31...
	ld a,(0e190h)		;9265   ; ...+ el avance
	add a,l			;9268
	jr nc,L_926C		;9269
	inc h			;926b
L_926C:
	ld l,a			;926c
	ld (0e1a0h),hl		;926d   ; apuntada
	ld hl,01800h		;9270   ; desde la fila 0
	ld b,00eh		;9273   ; 14 filas
rio_pinta_fila:
	ld c,020h		;9275   ; 32 casillas
	ld de,(0e1a0h)		;9277   ; desde
rio_pinta_casilla:
	ld a,(de)			;927b   ; una
	call 0004dh		;927c   ; WRTVRM
	dec de			;927f   ; la de la izquierda del mapa
	inc hl			;9280   ; la de la derecha de la pantalla
	dec c			;9281   ; una menos
	jr nz,rio_pinta_casilla		;9282
	push hl			;9284
	ld hl,(0e1a0h)		;9285   ; la fila siguiente del mapa...
	ld de,000c0h		;9288   ; ...+0xC0
	add hl,de			;928b
	ld (0e1a0h),hl		;928c
	pop hl			;928f
	djnz rio_pinta_fila		;9290   ; una fila menos
	ret			;9292
agua_mueve:		; El agua se mueve, en el rio: cada 9 cuadros (0xE192) el paso (0xE193) uno menos (de 0 a 3) y los dibujos de las casillas 0xA0 y 0xA1 (16 bytes desde 0x5680, o 0x56C0 en las escenas impares) y 0x90-0x93 (32 bytes desde 0x5600) de ese paso, con sus colores, en los dos tercios de abajo
	ld a,(0e051h)		;9293   ; en tierra?
	cp 002h		;9296
	ret z			;9298   ; si: nada
	ld a,(0e192h)		;9299   ; la cuenta...
	inc a			;929c
	ld (0e192h),a		;929d
	cp 009h		;92a0   ; ...9?
	ret c			;92a2   ; no
agua_dibuja:
	xor a			;92a3   ; la cuenta a 0
	ld (0e192h),a		;92a4
	ld a,(0e193h)		;92a7   ; el paso...
	dec a			;92aa   ; ...uno menos (0-3)
	and 003h		;92ab
	ld (0e193h),a		;92ad
	ld b,a			;92b0
	ld a,(0e003h)		;92b1   ; la escena...
	bit 0,a		;92b4   ; ...impar?
	jr z,agua_par		;92b6   ; no
	push bc			;92b8
	ld a,b			;92b9   ; el paso x 16...
	rlca			;92ba
	rlca			;92bb
	rlca			;92bc
	rlca			;92bd
	ld hl,056c0h		;92be   ; ...+ 0x56C0
	add a,l			;92c1
	ld l,a			;92c2
	ld de,00d00h		;92c3   ; a la casilla 0xA0 del segundo tercio
	ld bc,00010h		;92c6   ; 16 bytes
	call tercios_dos		;92c9   ; en los dos de abajo
	pop bc			;92cc
	push bc			;92cd
	ld a,b			;92ce   ; el paso x 16...
	rlca			;92cf
	rlca			;92d0
	rlca			;92d1
	rlca			;92d2
	ld hl,05ec0h		;92d3   ; ...+ 0x5EC0: sus colores
	add a,l			;92d6
	ld l,a			;92d7
	ld de,02d00h		;92d8
	ld bc,00010h		;92db   ; 16 bytes
	call tercios_dos		;92de   ; en los dos de abajo
	jr agua_olas		;92e1
agua_par:
	push bc			;92e3
	ld a,b			;92e4   ; el paso x 16...
	rlca			;92e5
	rlca			;92e6
	rlca			;92e7
	rlca			;92e8
	ld hl,05680h		;92e9   ; ...+ 0x5680
	add a,l			;92ec
	ld l,a			;92ed
	ld de,00d00h		;92ee   ; a la casilla 0xA0 del segundo tercio
	ld bc,00010h		;92f1   ; 16 bytes
	call tercios_dos		;92f4   ; en los dos de abajo
	pop bc			;92f7
	push bc			;92f8
	ld a,b			;92f9   ; el paso x 16...
	rlca			;92fa
	rlca			;92fb
	rlca			;92fc
	rlca			;92fd
	ld hl,05e80h		;92fe   ; ...+ 0x5E80: sus colores
	add a,l			;9301
	ld l,a			;9302
	ld de,02d00h		;9303
	ld bc,00010h		;9306   ; 16 bytes
	call tercios_dos		;9309   ; en los dos de abajo
agua_olas:
	pop bc			;930c
	push bc			;930d
	ld a,b			;930e   ; el paso x 32...
	rlca			;930f
	rlca			;9310
	rlca			;9311
	rlca			;9312
	rlca			;9313
	ld hl,05600h		;9314   ; ...+ 0x5600
	add a,l			;9317
	ld l,a			;9318
	ld de,00c80h		;9319   ; a la casilla 0x90 del segundo tercio
	ld bc,00020h		;931c   ; 32 bytes
	call tercios_dos		;931f   ; en los dos de abajo
	pop bc			;9322
	ld a,b			;9323   ; el paso x 32...
	rlca			;9324
	rlca			;9325
	rlca			;9326
	rlca			;9327
	rlca			;9328
	ld hl,05e00h		;9329   ; ...+ 0x5E00: sus colores
	add a,l			;932c
	ld l,a			;932d
	ld de,02c80h		;932e
	ld bc,00020h		;9331   ; 32 bytes
	call tercios_dos		;9334   ; en los dos de abajo
	ret			;9337
tierra_decorado:		; El decorado de tierra en 0xE600 (22 filas de 32): en blanco, los rectangulos de la escena (la tabla de 0x4038) y, detras, sus dibujos (fila, columna y dibujo, hasta 0xFF)
	ld hl,0e600h		;9338   ; 0xE600...
	ld bc,002c0h		;933b   ; ...0x2C0 bytes...
L_933E:
	ld (hl),010h		;933e   ; ...en blanco (0x10)
	inc hl			;9340
	dec bc			;9341
	ld a,c			;9342
	or b			;9343
	jr nz,L_933E		;9344
	ld a,(0e003h)		;9346   ; la escena...
	ld hl,04038h		;9349   ; ...en la tabla de 0x4038
	add a,a			;934c   ; x 2
	add a,l			;934d
	jr nc,L_9351		;934e
	inc h			;9350
L_9351:
	ld l,a			;9351
	ld e,(hl)			;9352   ; su lista
	inc hl			;9353
	ld d,(hl)			;9354
	call trozo_rect1		;9355   ; los rectangulos
	inc de			;9358   ; detras del 0xFF
tierra_decorado_uno:
	ld a,(de)			;9359   ; el final?
	cp 0ffh		;935a   ; 0xFF
	ret z			;935c
	call trozo_sitio		;935d   ; su sitio
	call tierra_dibujo		;9360   ; el dibujo
	jr tierra_decorado_uno		;9363
tierra_dibujo:		; El dibujo de la direccion de (DE) en HL (filas de 32); DE, detras
	ld a,(de)			;9365   ; la direccion...
	ld c,a			;9366
	inc de			;9367
	ld a,(de)			;9368   ; ...del dibujo
	ld b,a			;9369
	inc de			;936a
	push de			;936b
	ld e,c			;936c
	ld d,b			;936d
	call tierra_dibujo_pon		;936e   ; a pintarlo
	pop de			;9371
	ret			;9372
tierra_dibujo_pon:		; Un dibujo de casillas (ancho, alto y las casillas) en HL, en filas de 32
	ld a,(de)			;9373   ; el ancho
	ld (0e1a0h),a		;9374   ; apuntado
	inc de			;9377
	ld a,(de)			;9378   ; el alto
	ld b,a			;9379   ; las filas
	inc de			;937a
L_937B:
	ld a,(0e1a0h)		;937b   ; el ancho
	ld c,a			;937e
	push hl			;937f   ; su principio
L_9380:
	ld a,(de)			;9380   ; una casilla
	ld (hl),a			;9381   ; en el mapa
	inc de			;9382
	inc hl			;9383
	dec c			;9384   ; una menos
	jr nz,L_9380		;9385   ; la fila entera
	pop hl			;9387   ; la fila
	push de			;9388
	ld de,00020h		;9389   ; la fila siguiente
	add hl,de			;938c
	pop de			;938d
	djnz L_937B		;938e   ; una fila menos
	ret			;9390
trozo_rect2:		; Hasta 0xFF: la fila, la columna, el ancho, el alto y una casilla N: filas alternas de N, N+1 y de N+2, N+3
	ld a,(de)			;9391   ; el final?
	cp 0ffh		;9392   ; 0xFF: el final
	ret z			;9394
	call trozo_sitio		;9395   ; su sitio
	ld a,(de)			;9398   ; el ancho
	ld (0e1a0h),a		;9399   ; apuntado
	inc de			;939c   ; el alto
	ld a,(de)			;939d   ; el alto
	inc de			;939e   ; detras
	ld b,a			;939f   ; las filas
	ld (0e1a1h),hl		;93a0   ; su sitio
	ld a,(de)			;93a3   ; la casilla N
	ld (0e1a4h),a		;93a4   ; apuntada
	inc de			;93a7   ; detras
	xor a			;93a8   ; la primera fila, par
	ld (0e1a3h),a		;93a9   ; la primera fila, par
trozo_rect2_fila:		; Una fila: las pares N, N+1, N, N+1...; las impares N+2, N+3...
	ld hl,(0e1a1h)		;93ac   ; su sitio
	ld a,(0e1a0h)		;93af   ; el ancho
	ld c,a			;93b2
	ld a,(0e1a3h)		;93b3   ; fila par o impar?
	and a			;93b6
	jr nz,trozo_rect2_impar		;93b7
	cpl			;93b9   ; la siguiente, impar
	ld (0e1a3h),a		;93ba
trozo_rect2_par:
	ld a,(0e1a4h)		;93bd   ; N y N+1
	ld (hl),a			;93c0   ; N
	inc hl			;93c1   ; la siguiente
	dec c			;93c2
	jr z,trozo_rect2_sigue		;93c3
	ld a,(0e1a4h)		;93c5   ; N + 1
	inc a			;93c8
	ld (hl),a			;93c9
	inc hl			;93ca   ; la siguiente
	dec c			;93cb
	jr nz,trozo_rect2_par		;93cc   ; la fila entera
	jr trozo_rect2_sigue		;93ce
trozo_rect2_impar:
	cpl			;93d0   ; la siguiente, par
	ld (0e1a3h),a		;93d1
trozo_rect2_impar_par:
	ld a,(0e1a4h)		;93d4   ; N+2 y N+3
	add a,002h		;93d7   ; N + 2
	ld (hl),a			;93d9
	inc hl			;93da   ; la siguiente
	dec c			;93db
	jr z,trozo_rect2_sigue		;93dc
	ld a,(0e1a4h)		;93de   ; N + 3
	add a,003h		;93e1
	ld (hl),a			;93e3
	inc hl			;93e4   ; la siguiente
	dec c			;93e5
	jr nz,trozo_rect2_impar_par		;93e6   ; la fila entera
	jr trozo_rect2_sigue		;93e8
trozo_rect2_sigue:
	ld hl,(0e1a1h)		;93ea   ; la fila siguiente
	push de			;93ed
	ld de,00020h		;93ee   ; una fila abajo
	add hl,de			;93f1
	pop de			;93f2
	ld (0e1a1h),hl		;93f3
	djnz trozo_rect2_fila		;93f6   ; una fila menos
	jr trozo_rect2		;93f8   ; el siguiente
trozo_rect1:		; Hasta 0xFF: la fila, la columna, el ancho, el alto y la casilla con que se llena
	ld a,(de)			;93fa   ; el final?
	cp 0ffh		;93fb   ; 0xFF: el final
	ret z			;93fd
	call trozo_sitio		;93fe   ; su sitio
	ld (0e1a2h),hl		;9401   ; apuntado
	ld a,(de)			;9404   ; el ancho
	ld (0e1a0h),a		;9405
	inc de			;9408
	ld a,(de)			;9409   ; el alto
	ld b,a			;940a   ; las filas
	inc de			;940b
	ld a,(de)			;940c   ; la casilla
	ld (0e1a1h),a		;940d   ; apuntada
	inc de			;9410
trozo_rect1_fila:
	ld a,(0e1a0h)		;9411   ; el ancho
	ld c,a			;9414
trozo_rect1_casilla:
	ld a,(0e1a1h)		;9415   ; la casilla
	ld (hl),a			;9418   ; puesta
	inc hl			;9419   ; la siguiente
	dec c			;941a
	jr nz,trozo_rect1_casilla		;941b   ; la fila entera
	push de			;941d
	ld de,00020h		;941e   ; una fila abajo
	ld hl,(0e1a2h)		;9421
	add hl,de			;9424
	ld (0e1a2h),hl		;9425
	pop de			;9428
	djnz trozo_rect1_fila		;9429   ; una fila menos
	jr trozo_rect1		;942b   ; el siguiente
trozo_sitio:		; HL = 0xE600 + la fila (A) x 32 + la columna (DE + 1); DE, al dato siguiente
	ld hl,0e600h		;942d   ; en 0xE600
	and a			;9430   ; la fila 0?
	jr z,trozo_sitio_col		;9431
	ld b,a			;9433   ; las filas
	push de			;9434
	ld de,00020h		;9435   ; x 32
trozo_sitio_fila:
	add hl,de			;9438
	djnz trozo_sitio_fila		;9439
	pop de			;943b
trozo_sitio_col:
	inc de			;943c   ; la columna
	ld a,(de)			;943d   ; + la columna
	add a,l			;943e
	jr nc,L_9442		;943f
	inc h			;9441
L_9442:
	ld l,a			;9442
	inc de			;9443
	ret			;9444   ; DE, al dato siguiente

; ----------------------------------------------------------------------
; DATOS sobra_9445: 3 bytes de codigo (ld (hl),a; inc hl; dec c) que nadie
;   ejecuta
;   0x9445..0x9448  (3 bytes)
DATA_sobra_9445:
	defb 077h,023h,00dh	; 9445

; ======================================================================
; CODIGO 0x9448..0x947f  (55 bytes)
; ======================================================================


objeto_tierra:		; El objeto de 0xE500, si esta (+4): a su rutina (0x9B9F)
	ld iy,0e500h		;9448   ; IY: 0xE500
	ld a,(iy+004h)		;944c   ; esta?
	and a			;944f
	ret z			;9450   ; no: nada
	jp jefe		;9451   ; a su rutina
enemigos:		; Los 16 de 0xE380 (+4 el tipo): cada uno a su rutina por la tabla de 0x947F; y el objeto de 0xE500
	ld iy,0e380h		;9454   ; 16
	ld b,010h		;9458   ; 16
enemigo_uno:
	push bc			;945a
	ld a,(iy+004h)		;945b   ; esta?
	and a			;945e
	jr nz,L_946C		;945f
enemigo_sig:
	ld de,00010h		;9461   ; el siguiente (+16)
	add iy,de		;9464
	pop bc			;9466
	djnz enemigo_uno		;9467
	jp objeto_tierra		;9469   ; y el de 0xE500
L_946C:
	call enemigo_rutina		;946c   ; a su rutina
	jr enemigo_sig		;946f
enemigo_rutina:		; La rutina del tipo A en la tabla de 0x947F
	ld hl,0947fh		;9471   ; la tabla
	add a,a			;9474   ; x 2
	add a,l			;9475
	jr nc,L_9479		;9476
	inc h			;9478
L_9479:
	ld l,a			;9479
	ld e,(hl)			;947a   ; la rutina
	inc hl			;947b
	ld d,(hl)			;947c
	ex de,hl			;947d
	jp (hl)			;947e   ; a ella

; ----------------------------------------------------------------------
; DATOS enemigos_tabla: Las rutinas de los 16 tipos de 0xE380 (+4): 1 y 2
;   peces (0x956B), 3 el verde de la orilla (0x9771), 4 el pajaro (0x969E), 5
;   y 8 lo que se recoge (0x97E1), 6 el jefe vencido que se va (0x94FE), 7 el
;   tronco (0x9898), 9, 11 y 12 lo que tira el jefe (0x98FA, 0x9938 y 0x9997);
;   10, 13, 14 y 15, nada (0x99B4)
;   0x947f..0x949f  (32 bytes)
DATA_enemigos_tabla:
	defb 06bh,095h,06bh,095h,06bh,095h,071h,097h,09eh,096h,0e1h,097h,0feh,094h,098h,098h	; 947f  k.k.k.q.........
	defb 0e1h,097h,0fah,098h,0b4h,099h,038h,099h,097h,099h,0b4h,099h,0b4h,099h,0b4h,099h	; 948f  ......8.........

; ======================================================================
; CODIGO 0x949f..0x9566  (199 bytes)
; ======================================================================


enemigo_tocado:		; Tocado por el arma (+5 distinto de 1): 0x20 cuadros el dibujo 0x74 en colores 8 y 10; despues, al azar (R), desaparece o deja algo que recoger: el verde (3) y el pajaro (4) el tipo 5, los demas el 8 (entre 2 y 12 de cada 32 veces)
	inc (iy+006h)		;949f   ; la cuenta...
	ld a,(iy+006h)		;94a2
	cp 020h		;94a5   ; ...0x20?
	jr c,enemigo_chispazo		;94a7   ; no: el chispazo
	ld a,r		;94a9   ; al azar...
	and 01fh		;94ab   ; ...de 0 a 31
	ld c,a			;94ad
	ld b,014h		;94ae   ; el pajaro: menos de 20 se va
	ld a,(iy+004h)		;94b0   ; el tipo
	cp 004h		;94b3   ; el pajaro?
	jr z,enemigo_suerte		;94b5
	ld b,01bh		;94b7   ; el verde: menos de 27
	cp 003h		;94b9   ; el verde?
	jr z,enemigo_suerte		;94bb
	ld b,01eh		;94bd   ; los demas: menos de 30
enemigo_suerte:
	ld a,c			;94bf   ; el azar...
	cp b			;94c0   ; ...contra eso
	jr nc,enemigo_deja		;94c1   ; mas: deja algo
	jp enemigo_borra		;94c3   ; menos: se va
enemigo_chispazo:
	ld (iy+002h),074h		;94c6   ; el dibujo 0x74
	ld a,(0e012h)		;94ca   ; cada 4 cuadros...
	and 004h		;94cd
	rrca			;94cf
	add a,008h		;94d0   ; ...color 8 o 10
	ld (iy+003h),a		;94d2
	ret			;94d5
enemigo_deja:		; Deja algo: 8 a la izquierda y 8 abajo, el tipo 5 (del verde y el pajaro) o el 8 (de los demas), desde el principio
	ld a,(iy+001h)		;94d6   ; 8 a la izquierda
	sub 008h		;94d9
	ld (iy+001h),a		;94db
	ld a,(iy+000h)		;94de   ; 8 abajo
	add a,008h		;94e1
	ld (iy+000h),a		;94e3
	ld a,(iy+004h)		;94e6   ; el tipo...
	cp 003h		;94e9   ; ...el verde o el pajaro?
	jr c,enemigo_deja_8		;94eb   ; no
	ld (iy+004h),005h		;94ed   ; si: el tipo 5
enemigo_deja_va:
	ld (iy+005h),000h		;94f1   ; desde el principio
	jp cosa		;94f5   ; a su rutina
enemigo_deja_8:
	ld (iy+004h),008h		;94f8   ; el tipo 8
	jr enemigo_deja_va		;94fc
jefe_se_va:		; El tipo 6: el jefe vencido, en pequeno (los dibujos 0xF0-0xFC, del color de la escena: 0x9566), anda hacia la izquierda un pixel cada 2 cuadros; a los 0xE0 pasos, la escena acabada (0xE184) y 200 puntos (2.000 en pantalla)
	ld a,(iy+005h)		;94fe   ; la primera vez?
	and a			;9501
	jr nz,jefe_se_va_paso		;9502   ; no
	inc (iy+005h)		;9504   ; ya puesto
	ld (iy+008h),000h		;9507   ; la cuenta a 0
	ld (iy+000h),060h		;950b   ; Y 0x60...
	ld (iy+010h),060h		;950f   ; ...los dos sprites
	ld (iy+013h),00eh		;9513   ; el segundo, color 14...
	ld (iy+014h),00fh		;9517   ; ...y en pantalla
	ld hl,09566h		;951b   ; el color de la escena (0x9566)
	ld a,(0e003h)		;951e
	add a,l			;9521
	ld l,a			;9522
	ld a,(hl)			;9523
	ld (iy+003h),a		;9524   ; el primero
jefe_se_va_paso:
	inc (iy+008h)		;9527   ; cada 2 cuadros
	ld a,(iy+008h)		;952a
	cp 002h		;952d
	ret c			;952f
	ld a,(iy+001h)		;9530   ; la X...
	cp 002h		;9533   ; ...menos de 2?
	jr c,jefe_se_va_dibujo		;9535   ; si: quieto
	dec (iy+001h)		;9537   ; a la izquierda...
	dec (iy+011h)		;953a   ; ...los dos
jefe_se_va_dibujo:
	ld (iy+008h),000h		;953d   ; la cuenta a 0
	ld a,(0e012h)		;9541   ; cada 4 cuadros...
	and 004h		;9544
	rlca			;9546
	add a,0f0h		;9547   ; ...0xF0 o 0xF8
	ld (iy+002h),a		;9549   ; el primero
	add a,004h		;954c   ; +4...
	ld (iy+012h),a		;954e   ; ...el segundo
	inc (iy+007h)		;9551   ; un paso mas
	ld a,(iy+007h)		;9554
	cp 0e0h		;9557   ; 0xE0?
	ret c			;9559   ; no
	ld a,001h		;955a   ; la escena acabada
	ld (0e184h),a		;955c
	inc a			;955f   ; 2 en las centenas: 200 puntos
	call puntos_suma_cien		;9560   ; sumados
	jp enemigo_borra		;9563   ; fuera

; ----------------------------------------------------------------------
; DATOS jefe_colores: El color del jefe vencido en cada escena (0-4)
;   0x9566..0x956b  (5 bytes)
DATA_jefe_colores:
	defb 006h,005h,003h,004h,00fh	; 9566

; ======================================================================
; CODIGO 0x956b..0x966c  (257 bytes)
; ======================================================================


pez:		; Los tipos 1 y 2, peces: entran por la izquierda en una de las cuatro calles (Y 0x6C + 12 x n, al azar y distinta de la de antes, 0xE19A); el 1 (dibujo 0x88, color 6, 50 puntos en pantalla, dos golpes) avanza un pixel cada 4 - escena cuadros y desde la escena 2 sube y baja (0x966C); el 2 (dibujo 0x98, color 1, 13 desde la escena 2; 100 en pantalla) avanza 1, 2 o 3 pixeles por cuadro segun la escena y desde la 2 va hacia la Y del protagonista
	ld a,(iy+005h)		;956b   ; la primera vez?
	and a			;956e
	jr nz,pez_mueve		;956f   ; no
	ld a,r		;9571   ; al azar...
	and 003h		;9573   ; ...una calle (0-3)
	ld b,a			;9575
	ld a,(0e19ah)		;9576   ; la de antes?
	cp b			;9579
	jr nz,pez_calle		;957a   ; no
	inc b			;957c   ; si: la siguiente
	ld a,b			;957d
	and 003h		;957e
	ld b,a			;9580
pez_calle:
	ld a,b			;9581
	ld (0e19ah),a		;9582   ; apuntada
	and a			;9585   ; la 0?
	jr z,pez_pon		;9586
	ld b,a			;9588
	xor a			;9589
L_958A:
	add a,00ch		;958a   ; 12 por calle
	djnz L_958A		;958c
pez_pon:
	add a,06ch		;958e   ; + 0x6C: la Y
	ld (iy+000h),a		;9590
	ld (iy+001h),000h		;9593   ; X 0
	ld (iy+003h),006h		;9597   ; color 6
	ld (iy+013h),00fh		;959b   ; el segundo sprite: color 15...
	ld (iy+014h),00fh		;959f   ; ...en pantalla
	ld (iy+007h),088h		;95a3   ; el dibujo 0x88
	ld (iy+00eh),005h		;95a7   ; 5 puntos (50 en pantalla)
	inc (iy+005h)		;95ab   ; ya puesto
	ld a,(iy+004h)		;95ae   ; el tipo 1?
	cp 001h		;95b1
	jr z,pez_1_color		;95b3   ; si
	ld (iy+007h),098h		;95b5   ; el 2: el dibujo 0x98...
	ld (iy+003h),001h		;95b9   ; ...color 1...
	ld (iy+00eh),010h		;95bd   ; ...0x10 puntos (100 en pantalla)
	ld a,(0e003h)		;95c1   ; desde la escena 2...
	cp 002h		;95c4
	jr c,pez_va		;95c6
	ld (iy+003h),00dh		;95c8   ; ...color 13
	jr pez_va		;95cc
pez_1_color:
	ld a,(0e003h)		;95ce   ; desde la escena 2...
	cp 002h		;95d1
	jr c,pez_va		;95d3
	ld (iy+003h),001h		;95d5   ; ...color 1
pez_va:
	jp enemigo_paso		;95d9   ; sus sprites y los choques
pez_mueve:
	cp 001h		;95dc   ; 1: nadando
	jp nz,enemigo_tocado		;95de   ; si no, tocado
	ld a,(iy+004h)		;95e1   ; el tipo...
	cp 002h		;95e4   ; ...2?
	jr z,pez_2_mueve		;95e6   ; si
	ld a,(0e003h)		;95e8   ; el 1: cada 4 - escena cuadros...
	ld b,a			;95eb
	ld a,004h		;95ec
	sub b			;95ee
	ld b,a			;95ef
	inc (iy+006h)		;95f0   ; la cuenta
	ld a,(iy+006h)		;95f3
	cp b			;95f6
	jr c,pez_onda		;95f7   ; no
	ld (iy+006h),000h		;95f9   ; a 0
	inc (iy+001h)		;95fd   ; un pixel a la derecha
	jr pez_onda		;9600
pez_2_mueve:
	ld a,(0e003h)		;9602   ; la escena...
	cp 002h		;9605   ; ...0 o 1: un pixel
	jr c,pez_2_uno		;9607
	cp 003h		;9609   ; 3: tres
	jr nz,pez_2_dos		;960b
	inc (iy+001h)		;960d   ; uno...
pez_2_dos:
	inc (iy+001h)		;9610   ; ...otro...
pez_2_uno:
	inc (iy+001h)		;9613   ; ...y otro
pez_onda:
	ld a,(0e003h)		;9616   ; la escena...
	cp 002h		;9619   ; ...0 o 1: nada mas
	jp c,enemigo_paso		;961b
	ld a,(iy+004h)		;961e   ; el tipo...
	cp 002h		;9621   ; ...2?
	jp z,pez_persigue		;9623   ; si: hacia el protagonista
	inc (iy+00ah)		;9626   ; el paso...
	ld hl,0966ch		;9629   ; ...en la tabla de 0x966C...
	ld a,(iy+00ah)		;962c
	cp 032h		;962f   ; ...de 50
	jr c,pez_onda_paso		;9631   ; no
	ld (iy+00ah),000h		;9633   ; la vuelta
	xor a			;9637
pez_onda_paso:
	add a,l			;9638
	jr nc,L_963C		;9639
	inc h			;963b
L_963C:
	ld l,a			;963c
	ld b,(hl)			;963d   ; lo que sube o baja
	ld a,(iy+000h)		;963e   ; la Y...
	add a,b			;9641   ; ...+ eso
	ld (iy+000h),a		;9642
	jp enemigo_paso		;9645
pez_persigue:
	inc (iy+00bh)		;9648   ; cada 2 cuadros
	ld a,(iy+00bh)		;964b
	cp 002h		;964e
	jr c,pez_fin		;9650
	ld (iy+00bh),000h		;9652   ; a 0
	ld a,(ix+000h)		;9656   ; la Y del protagonista + 9...
	add a,009h		;9659
	ld b,(iy+000h)		;965b   ; ...contra la suya
	cp b			;965e
	jr c,pez_sube		;965f   ; menos: sube
	inc (iy+000h)		;9661   ; baja
	jr pez_fin		;9664
pez_sube:
	dec (iy+000h)		;9666   ; sube
pez_fin:
	jp enemigo_paso		;9669   ; sus sprites y los choques

; ----------------------------------------------------------------------
; DATOS pez_onda_tabla: Los 50 pasos de la onda del pez 1: lo que sube o baja
;   su Y en cada uno
;   0x966c..0x969e  (50 bytes)
DATA_pez_onda_tabla:
	defb 0fdh,0fdh,000h,0fdh,000h,0feh,000h,0feh,000h,000h,0ffh,000h,0ffh,000h,0ffh,000h	; 966c  ................
	defb 0ffh,000h,000h,0ffh,000h,0ffh,000h,000h,000h,000h,000h,000h,001h,000h,001h,000h	; 967c  ................
	defb 000h,001h,000h,001h,000h,001h,000h,001h,000h,000h,002h,000h,002h,000h,003h,000h	; 968c  ................
	defb 003h,003h	; 969c

; ======================================================================
; CODIGO 0x969e..0x9757  (185 bytes)
; ======================================================================


pajaro:		; El tipo 4, el pajaro: a la altura de 0x48, por la izquierda o (al azar, +8 = 2 o 3) por la derecha; dibujo 0xD8, color 7, 200 puntos en pantalla; en las escenas impares, el dibujo 0xB8 en color 9 (Y 0x50) o el 0xA8 en color 13, y sube y baja (0x9757); 1 pixel por cuadro, 2 desde la escena 2
	ld a,(iy+005h)		;969e   ; la primera vez?
	and a			;96a1
	jr nz,pajaro_vuela		;96a2   ; no
	inc (iy+005h)		;96a4   ; ya puesto
	ld (iy+000h),048h		;96a7   ; Y 0x48
	ld (iy+003h),007h		;96ab   ; color 7
	ld (iy+001h),000h		;96af   ; X 0
	ld (iy+013h),001h		;96b3   ; el segundo sprite: color 1
	ld (iy+007h),0d8h		;96b7   ; el dibujo 0xD8
	ld (iy+014h),00fh		;96bb   ; el segundo, en pantalla
	ld (iy+00eh),020h		;96bf   ; 0x20 puntos (200 en pantalla)
	ld a,r		;96c3   ; al azar...
	and 003h		;96c5   ; ...el lado (0-3)
	ld (iy+008h),a		;96c7
	cp 002h		;96ca   ; 2 o 3?
	jp c,pajaro_izq		;96cc   ; no: por la izquierda
	ld (iy+001h),0f0h		;96cf   ; si: por la derecha
	ld a,(0e003h)		;96d3   ; la escena...
	bit 0,a		;96d6   ; ...impar?
	jp z,enemigo_paso		;96d8   ; no
	ld (iy+007h),0b8h		;96db   ; el dibujo 0xB8...
	ld (iy+003h),009h		;96df   ; ...color 9...
	ld (iy+013h),00eh		;96e3   ; ...y 14...
	ld (iy+000h),050h		;96e7   ; ...Y 0x50
	jp enemigo_paso		;96eb
pajaro_izq:
	ld a,(0e003h)		;96ee   ; la escena...
	bit 0,a		;96f1   ; ...impar?
	jp z,enemigo_paso		;96f3   ; no
	ld (iy+007h),0a8h		;96f6   ; el dibujo 0xA8...
	ld (iy+003h),00dh		;96fa   ; ...color 13...
	ld (iy+013h),00fh		;96fe   ; ...y 15
	jp enemigo_paso		;9702
pajaro_vuela:
	cp 001h		;9705   ; 1: volando
	jp nz,enemigo_tocado		;9707   ; si no, tocado
	ld a,(iy+008h)		;970a   ; el lado...
	cp 002h		;970d   ; ...por la derecha?
	jr c,pajaro_derecha		;970f   ; no
	ld a,(0e003h)		;9711   ; desde la escena 2...
	cp 002h		;9714
	jr c,L_971B		;9716
	dec (iy+001h)		;9718   ; ...dos
L_971B:
	dec (iy+001h)		;971b   ; a la izquierda
	jr pajaro_onda		;971e
pajaro_derecha:
	ld a,(0e003h)		;9720   ; desde la escena 2...
	cp 002h		;9723
	jr c,L_972A		;9725
	inc (iy+001h)		;9727   ; ...dos
L_972A:
	inc (iy+001h)		;972a   ; a la derecha
pajaro_onda:
	ld a,(0e003h)		;972d   ; la escena...
	bit 0,a		;9730   ; ...impar?
	jp z,enemigo_paso		;9732   ; no
	inc (iy+00ah)		;9735   ; el paso...
	ld a,(iy+00ah)		;9738
	cp 01ah		;973b   ; ...de 26
	jr nz,pajaro_onda_paso		;973d
	ld (iy+00ah),000h		;973f   ; la vuelta
	xor a			;9743
pajaro_onda_paso:
	ld hl,09757h		;9744   ; la tabla (0x9757)
	add a,l			;9747
	jr nc,L_974B		;9748
	inc h			;974a
L_974B:
	ld l,a			;974b
	ld b,(hl)			;974c   ; lo que sube o baja
	ld a,(iy+000h)		;974d   ; la Y...
	add a,b			;9750   ; ...+ eso
	ld (iy+000h),a		;9751
	jp enemigo_paso		;9754

; ----------------------------------------------------------------------
; DATOS pajaro_onda_tabla: Los 26 pasos de la onda del pajaro en las escenas
;   impares
;   0x9757..0x9771  (26 bytes)
DATA_pajaro_onda_tabla:
	defb 000h,000h,001h,001h,001h,001h,002h,002h,002h,003h,003h,003h,003h,0fdh,0fdh,0fdh	; 9757  ................
	defb 0fdh,0feh,0feh,0feh,0ffh,0ffh,0ffh,0ffh,000h,000h	; 9767  ..........

; ======================================================================
; CODIGO 0x9771..0x9858  (231 bytes)
; ======================================================================


verde:		; El tipo 3, el verde de la orilla (como mucho dos a la vez: 0xE19B): por la izquierda a la altura de 0x42 a 0x50 (al azar), dibujo 0xC8, color 12 y 3, 300 puntos en pantalla; en las escenas impares, el 0xA8 en color 9; avanza un pixel cada 2 cuadros
	ld a,(iy+005h)		;9771   ; la primera vez?
	and a			;9774
	jr nz,verde_anda		;9775   ; no
	ld a,(0e19bh)		;9777   ; los que hay...
	inc a			;977a   ; ...+ 1...
	cp 003h		;977b   ; ...3?
	jp z,otro_borra_va		;977d   ; si: no sale
	ld (0e19bh),a		;9780   ; uno mas
	inc (iy+005h)		;9783   ; ya puesto
	ld (iy+000h),040h		;9786
	ld (iy+001h),000h		;978a   ; X 0
	ld (iy+003h),00ch		;978e   ; color 12...
	ld (iy+013h),003h		;9792   ; ...y 3
	ld (iy+014h),00fh		;9796   ; el segundo, en pantalla
	ld (iy+007h),0c8h		;979a   ; el dibujo 0xC8
	ld (iy+00eh),030h		;979e   ; 0x30 puntos (300 en pantalla)
	ld a,r		;97a2   ; al azar...
	and 01fh		;97a4
	add a,042h		;97a6   ; ...+ 0x42...
	cp 050h		;97a8   ; ...hasta 0x50
	jr c,verde_y		;97aa
	ld a,050h		;97ac
verde_y:
	ld (iy+000h),a		;97ae   ; la Y
	ld a,(0e003h)		;97b1   ; la escena...
	bit 0,a		;97b4   ; ...impar?
	jp z,enemigo_paso		;97b6   ; no
	ld (iy+007h),0a8h		;97b9   ; el dibujo 0xA8...
	ld (iy+003h),009h		;97bd   ; ...color 9...
	ld (iy+013h),00fh		;97c1   ; ...y 15
	jp enemigo_paso		;97c5
verde_anda:
	cp 001h		;97c8   ; 1: andando
	jp nz,enemigo_tocado		;97ca   ; si no, tocado
enemigo_e_baja:		; Cada 2 cuadros, un pixel a la derecha
	inc (iy+006h)		;97cd   ; la cuenta...
	ld a,(iy+006h)		;97d0
	cp 002h		;97d3   ; ...cada 2 cuadros
	jr c,L_97DE		;97d5
	ld (iy+006h),000h		;97d7   ; a cero
	inc (iy+001h)		;97db   ; a la derecha
L_97DE:
	jp enemigo_paso		;97de
cosa:		; Los tipos 5 y 8, lo que se recoge (dibujos 0x78 y 0x7C, colores 11 y 9; el 8 pasa a ser el 5 con el segundo en color 15): el efecto 2, salta con la tabla de 0x9858 y avanza un pixel cada 3 cuadros; a los 0x40 pasos, fuera; tocarlo da 500 puntos en pantalla y, en el rio, una mas en 0xE054 (tres si era el 8)
	ld a,(iy+005h)		;97e1   ; la primera vez?
	and a			;97e4
	jr nz,cosa_salta		;97e5   ; no
	ld (iy+002h),078h		;97e7   ; el dibujo 0x78...
	ld (iy+003h),00bh		;97eb   ; ...color 11
	ld (iy+012h),07ch		;97ef   ; el segundo: 0x7C...
	ld (iy+013h),009h		;97f3   ; ...color 9...
	ld (iy+014h),00fh		;97f7   ; ...en pantalla
	ld (iy+00eh),050h		;97fb   ; 0x50 puntos (500 en pantalla)
	ld (iy+006h),000h		;97ff   ; la cuenta a 0
	ld a,002h		;9803   ; el efecto 2 del canal A
	call efecto_a_pide		;9805
	inc (iy+005h)		;9808   ; ya puesto
	ld a,(iy+004h)		;980b   ; el tipo 8?
	cp 008h		;980e
	jr nz,cosa_va		;9810   ; no
	ld (iy+013h),00fh		;9812   ; si: el segundo en color 15...
	ld (iy+004h),005h		;9816   ; ...y el tipo 5
	jr cosa_va		;981a
cosa_salta:
	cp 001h		;981c   ; 1: saltando?
	jr nz,cosa_fuera		;981e   ; no: fuera
	inc (iy+006h)		;9820   ; un paso mas
	ld a,(iy+006h)		;9823
	cp 040h		;9826   ; 0x40?
	jr c,cosa_paso		;9828   ; no
cosa_fuera:
	ld (iy+010h),0ech		;982a   ; el segundo sprite fuera...
	ld (iy+014h),000h		;982e   ; ...y no esta
	jp enemigo_borra		;9832   ; fuera
cosa_paso:
	ld hl,09858h		;9835   ; la tabla (0x9858)
	add a,l			;9838
	jr nc,L_983C		;9839
	inc h			;983b
L_983C:
	ld l,a			;983c
	ld b,(hl)			;983d   ; lo que sube o baja
	ld a,(iy+000h)		;983e   ; la Y...
	add a,b			;9841   ; ...+ eso
	ld (iy+000h),a		;9842
	inc (iy+008h)		;9845   ; cada 3 cuadros...
	ld a,(iy+008h)		;9848
	cp 003h		;984b
	jr c,cosa_va		;984d
	ld (iy+008h),a		;984f
	inc (iy+001h)		;9852   ; ...un pixel a la derecha
cosa_va:
	jp enemigo_choques		;9855   ; sus sprites y los choques

; ----------------------------------------------------------------------
; DATOS cosa_salto_tabla: Los 64 pasos del salto de lo que se recoge: lo que
;   sube o baja su Y
;   0x9858..0x9898  (64 bytes)
DATA_cosa_salto_tabla:
	defb 0fch,0fch,000h,0fch,000h,0fch,000h,0fdh,0fdh,000h,0fdh,000h,0fdh,000h,0fdh,000h	; 9858  ................
	defb 0fdh,000h,0fdh,000h,0feh,000h,0feh,000h,0ffh,000h,0ffh,000h,0ffh,000h,000h,000h	; 9868  ................
	defb 000h,000h,000h,001h,000h,001h,000h,001h,000h,002h,000h,002h,000h,003h,000h,003h	; 9878  ................
	defb 000h,003h,000h,003h,000h,003h,000h,003h,003h,000h,004h,000h,004h,000h,004h,004h	; 9888  ................

; ======================================================================
; CODIGO 0x9898..0x9b65  (717 bytes)
; ======================================================================


tronco:		; El tipo 7, el tronco (dibujos 0x60 y 0x64, colores 6 y 11): por la izquierda, a la altura del protagonista + 6 (0x70 como poco); avanza un pixel por cuadro (dos desde la escena 2) y sube y baja un pixel cada 3 cuadros; el arma no le hace nada y tocarlo sin saltar es la muerte
	ld a,(iy+005h)		;9898   ; la primera vez?
	and a			;989b
	jr nz,tronco_mueve		;989c   ; no
	inc (iy+005h)		;989e   ; ya puesto
	ld (iy+002h),060h		;98a1   ; el dibujo 0x60...
	ld (iy+003h),006h		;98a5   ; ...color 6
	ld (iy+012h),064h		;98a9   ; el segundo: 0x64...
	ld (iy+013h),00bh		;98ad   ; ...color 11...
	ld (iy+014h),00fh		;98b1   ; ...en pantalla
	ld (iy+001h),000h		;98b5   ; X 0
	ld a,(ix+000h)		;98b9   ; la Y del protagonista...
	add a,006h		;98bc   ; ...+ 6
	ld (iy+000h),a		;98be
	cp 070h		;98c1   ; 0x70 o mas?
	ret nc			;98c3   ; si: esa
	ld (iy+000h),070h		;98c4   ; no: 0x70
	ret			;98c8
tronco_mueve:
	ld a,(0e003h)		;98c9   ; desde la escena 2...
	cp 002h		;98cc
	jr c,L_98D3		;98ce
	inc (iy+001h)		;98d0   ; ...uno mas
L_98D3:
	inc (iy+001h)		;98d3   ; a la derecha
	inc (iy+009h)		;98d6   ; cada 3 cuadros...
	ld a,(iy+009h)		;98d9
	cp 003h		;98dc
	jr c,tronco_va		;98de
	ld (iy+009h),000h		;98e0   ; a 0
	inc (iy+008h)		;98e4   ; el paso...
	ld a,(iy+008h)		;98e7   ; ...cada 4: abajo o arriba
	and 004h		;98ea
	and a			;98ec
	jr nz,tronco_sube		;98ed
	inc (iy+000h)		;98ef   ; abajo
	jr tronco_va		;98f2
tronco_sube:
	dec (iy+000h)		;98f4   ; arriba
tronco_va:
	jp enemigo_choques		;98f7   ; sus sprites y los choques
cae_del_cielo:		; El tipo 9: desde arriba (Y 0) en la X del jefe, el dibujo 0x70 en color 9 o 10; baja 4 pixeles por cuadro yendo hacia la X del protagonista; tocarlo es un golpe
	ld a,(iy+005h)		;98fa   ; la primera vez?
	and a			;98fd
	jr nz,cae_mueve		;98fe   ; no
	ld a,(0e501h)		;9900   ; la X del jefe
	ld (iy+001h),a		;9903
	ld (iy+000h),000h		;9906   ; Y 0
	ld (iy+002h),070h		;990a   ; el dibujo 0x70
	inc (iy+005h)		;990e   ; ya puesto
	ret			;9911
cae_mueve:
	ld a,(0e012h)		;9912   ; cada 4 cuadros...
	and 004h		;9915
	rrca			;9917
	add a,009h		;9918   ; ...color 9 o 10
	ld (iy+003h),a		;991a
	ld a,(iy+000h)		;991d   ; la Y...
	add a,004h		;9920   ; ...4 abajo
	ld (iy+000h),a		;9922
	ld a,(ix+001h)		;9925   ; hacia la X del protagonista
	ld b,(iy+001h)		;9928   ; la suya
	cp b			;992b
	jr c,cae_izq		;992c   ; menos: a la izquierda
	inc (iy+001h)		;992e   ; a la derecha
	jr tiro_choca		;9931
cae_izq:
	dec (iy+001h)		;9933   ; a la izquierda
	jr tiro_choca		;9936
tiro_jefe:		; El tipo 11: sale del jefe (16 por encima), el dibujo 0x74, color 9 u 11; 4 pixeles a la derecha y 2 abajo por cuadro; tocarlo es un golpe
	ld a,(iy+005h)		;9938   ; la primera vez?
	and a			;993b
	jr nz,tiro_vuela		;993c   ; no
	ld (iy+002h),074h		;993e   ; el dibujo 0x74
tiro_sale:
	ld a,(0e500h)		;9942   ; 16 por encima del jefe
	sub 010h		;9945
	ld (iy+000h),a		;9947
	ld a,(0e501h)		;994a   ; en su X
	ld (iy+001h),a		;994d
	inc (iy+005h)		;9950   ; ya puesto
	ret			;9953
tiro_vuela:
	ld a,(0e012h)		;9954   ; cada 8 cuadros...
	and 008h		;9957
	rrca			;9959
	rrca			;995a
	add a,009h		;995b   ; ...color 9 u 11
	ld (iy+003h),a		;995d
tiro_mueve:
	ld a,(iy+001h)		;9960   ; 4 a la derecha
	add a,004h		;9963
	ld (iy+001h),a		;9965
	inc (iy+000h)		;9968   ; 2 abajo
	inc (iy+000h)		;996b
tiro_choca:
	ld bc,008f8h		;996e   ; el margen: 8 por un lado y 8 por el otro
	call cerca_y		;9971   ; en Y?
	jr nc,tiro_fuera		;9974   ; no
	ld bc,008f8h		;9976   ; en X?
	call cerca_x		;9979   ; toca?
	jr nc,tiro_fuera		;997c   ; no
	call golpe		;997e   ; un golpe
	ld a,004h		;9981   ; y el efecto 4
	call efecto_a_pide		;9983
tiro_fuera:
	ld a,(iy+001h)		;9986   ; la X...
	cp 0f0h		;9989   ; ...0xF0 o mas: fuera
	jp nc,otro_borra_va		;998b
	ld a,(iy+000h)		;998e   ; la Y...
	cp 080h		;9991   ; ...0x80 o mas: fuera
	jp nc,otro_borra_va		;9993
	ret			;9996
tiro_jefe2:		; El tipo 12: como el 11, con los dibujos 0x68 y 0x6C (cada 4 cuadros) en color 6
	ld a,(iy+005h)		;9997   ; la primera vez?
	and a			;999a
	jr nz,tiro_jefe2_vuela		;999b   ; no
	ld (iy+002h),068h		;999d   ; el dibujo 0x68...
	ld (iy+003h),006h		;99a1   ; ...color 6
	jp tiro_sale		;99a5   ; sale del jefe
tiro_jefe2_vuela:
	ld a,(0e012h)		;99a8   ; cada 4 cuadros...
	and 004h		;99ab
	add a,068h		;99ad   ; ...0x68 o 0x6C
	ld (iy+002h),a		;99af
	jr tiro_mueve		;99b2   ; a moverse
nada:		; Los tipos 10, 13, 14 y 15: nada
	ret			;99b4
enemigo_paso:		; El dibujo: el suyo (+7) + 8 cada 8 cuadros, y el del segundo sprite + 4
	ld a,(0e012h)		;99b5   ; cada 8 cuadros...
	and 008h		;99b8
	ld b,(iy+007h)		;99ba   ; ...+ el suyo
	add a,b			;99bd
	ld (iy+002h),a		;99be   ; el primero
	add a,004h		;99c1   ; +4...
	ld (iy+012h),a		;99c3   ; ...el segundo
enemigo_choques:		; El segundo sprite en su sitio y los choques: con el protagonista (12 por un lado y 12 por el otro en Y, 8 y 8 en X), lo que se recoge se recoge; llegando a la orilla nada; el tronco, la muerte si no salta; los demas, dos golpes; con el arma (no el tronco; de 3 a 12 por debajo de ella, 6 a los lados), los puntos (+0x0E), el efecto 6 y tocado; el pez 1 aguanta un golpe; fuera por la derecha (X 0xF8), fuera
	ld a,(iy+000h)		;99c6   ; el segundo sprite...
	ld (iy+010h),a		;99c9
	ld a,(iy+001h)		;99cc   ; ...en su sitio
	ld (iy+011h),a		;99cf
	ld bc,00cf4h		;99d2   ; el margen en Y: 12 y 12
	call cerca_y		;99d5   ; toca?
	jr nc,enemigo_arma		;99d8   ; no
	ld bc,008f8h		;99da   ; en X: 8 y 8
	call cerca_x		;99dd   ; toca?
	jr nc,enemigo_arma		;99e0   ; no
	ld a,(iy+004h)		;99e2   ; lo que se recoge?
	cp 005h		;99e5   ; si: recogido
	jr z,enemigo_puntos		;99e7
	ld a,(0e051h)		;99e9   ; llegando a la orilla?
	cp 001h		;99ec
	ret z			;99ee   ; si: nada
	ld a,(iy+004h)		;99ef   ; el tronco?
	cp 007h		;99f2
	jr nz,enemigo_toca		;99f4   ; no
	ld a,(ix+006h)		;99f6   ; saltando?
	and a			;99f9
	ret nz			;99fa   ; si: nada
	ld a,001h		;99fb   ; no: muerto
	ld (0e183h),a		;99fd
	ret			;9a00
enemigo_toca:
	call golpe		;9a01   ; dos golpes
	call golpe		;9a04
enemigo_arma:
	ld a,(iy+004h)		;9a07   ; el tronco?
	cp 007h		;9a0a
	jr z,enemigo_fuera		;9a0c   ; si: el arma no le hace nada
	ld a,(ix+024h)		;9a0e   ; el arma fuera?
	and a			;9a11
	jr z,enemigo_fuera		;9a12   ; no
	ld b,(iy+000h)		;9a14   ; la Y del arma...
	ld a,(ix+020h)		;9a17   ; ...menos la suya
	sub b			;9a1a
	cp 003h		;9a1b   ; menos de 3?
	jr c,enemigo_fuera		;9a1d   ; si: no le da
	cp 00dh		;9a1f   ; 13 o mas?
	jr nc,enemigo_fuera		;9a21   ; si: no le da
	ld bc,006fah		;9a23   ; en X: 6 y 6
	call cerca_x2		;9a26   ; le da?
	jr nc,enemigo_fuera		;9a29   ; no
	ld a,(iy+004h)		;9a2b   ; el pez 1?
	cp 001h		;9a2e
	jr nz,enemigo_puntos		;9a30   ; no: tocado
	call arma_guarda		;9a32   ; el arma vuelve
	inc (iy+008h)		;9a35   ; un golpe mas
	ld a,(iy+008h)		;9a38
	cp 002h		;9a3b   ; el segundo?
	jr c,enemigo_fuera		;9a3d   ; no: aguanta
	ld (iy+008h),000h		;9a3f   ; a 0
enemigo_puntos:		; Tocado o recogido: sus puntos (+0x0E), el efecto 6, tocado (+5 = 10) y el segundo sprite fuera; si es lo que se recoge, el efecto 1 y, en el rio, una mas en 0xE054 (tres si su segundo sprite es de color 15)
	ld a,(iy+00eh)		;9a43   ; sus puntos
	call puntos_suma		;9a46   ; sumados
	ld a,006h		;9a49   ; el efecto 6
	call efecto_a_pide		;9a4b
	ld (iy+005h),00ah		;9a4e   ; tocado
	ld (iy+010h),0ech		;9a52   ; el segundo sprite fuera
	ld a,(iy+004h)		;9a56   ; lo que se recoge?
	cp 005h		;9a59
	ret nz			;9a5b   ; no: listo
	ld a,001h		;9a5c   ; el efecto 1
	call efecto_a_pide		;9a5e
	ld a,(0e051h)		;9a61   ; en tierra?
	cp 002h		;9a64
	ret z			;9a66   ; si: nada mas
	call e054_suma		;9a67   ; una mas en 0xE054
	ld a,(iy+013h)		;9a6a   ; el segundo, color 15 (era el tipo 8)?
	cp 00fh		;9a6d
	ret nz			;9a6f   ; no
	call e054_suma		;9a70   ; dos mas
	call e054_suma		;9a73
	ret			;9a76
enemigo_fuera:
	ld a,(iy+000h)		;9a77   ; la Y...
	cp 0b4h		;9a7a   ; ...0xB4 o mas: escondido, se queda
	jr c,L_9A7F		;9a7c
	ret			;9a7e
L_9A7F:
	ld a,(iy+001h)		;9a7f   ; la X...
	cp 0f8h		;9a82   ; ...0xF8 o mas: fuera
	ret c			;9a84
enemigo_borra:		; Fuera: si es el verde, uno menos (0xE19B); el segundo sprite fuera y sus 16 bytes a cero
	ld a,(iy+004h)		;9a85   ; el verde?
	cp 003h		;9a88
	jr nz,L_9A93		;9a8a   ; no
	ld a,(0e19bh)		;9a8c   ; uno menos
	dec a			;9a8f
	ld (0e19bh),a		;9a90
L_9A93:
	ld (iy+010h),0ech		;9a93   ; el segundo sprite fuera...
	ld (iy+014h),000h		;9a97   ; ...y no esta
	ld (iy+015h),000h		;9a9b
	jp otro_borra_va		;9a9f   ; y fuera
enemigos_salen:		; En el rio, cada 0x30 - escena x 8 + (0-63) cuadros (0xE199), uno nuevo en el primer hueco de 4 (5 en las escenas 2 y 3) de 0xE380, de 32 en 32: por el paso del agua (0xE192), un pez (1 o 2 al azar), el tronco, el verde o el pajaro
	ld a,(0e051h)		;9aa2   ; en el rio?
	and a			;9aa5
	ret nz			;9aa6   ; no: nada
	ld a,(0e199h)		;9aa7   ; la cuenta...
	and a			;9aaa
	jr z,enemigos_sale_uno		;9aab   ; ...a 0?
	dec a			;9aad   ; no: una menos
	ld (0e199h),a		;9aae
	ret			;9ab1
enemigos_sale_uno:
	ld a,r		;9ab2   ; al azar...
	and 03fh		;9ab4   ; ...de 0 a 63...
	ld c,a			;9ab6
	ld a,(0e003h)		;9ab7   ; ...+ 0x30 - la escena x 8
	rlca			;9aba
	rlca			;9abb
	rlca			;9abc
	ld b,a			;9abd
	ld a,030h		;9abe
	sub b			;9ac0
	add a,c			;9ac1
	ld (0e199h),a		;9ac2   ; la cuenta nueva
	ld iy,0e380h		;9ac5   ; desde 0xE380
	ld a,(0e003h)		;9ac9   ; la escena...
	and 002h		;9acc   ; ...2 o 3: 5 huecos...
	rrca			;9ace
	add a,004h		;9acf   ; ...si no, 4
	ld b,a			;9ad1
enemigos_hueco:
	ld a,(iy+004h)		;9ad2   ; libre?
	and a			;9ad5
	jp z,enemigos_tipo		;9ad6   ; si
	ld de,00020h		;9ad9   ; el siguiente (+32)
	add iy,de		;9adc
	djnz enemigos_hueco		;9ade   ; ninguno: nada
	ret			;9ae0
enemigos_tipo:
	ld a,(0e192h)		;9ae1   ; el paso del agua...
	and 006h		;9ae4   ; ...(0, 2, 4 o 6)...
	rrca			;9ae6   ; ...entre 2...
	inc a			;9ae7   ; ...+ 1 (1-4)
	cp 002h		;9ae8   ; 2?
	jr nz,enemigos_pez		;9aea   ; no
	ld a,007h		;9aec   ; si: el tronco (7)
	jr enemigos_pon		;9aee
enemigos_pez:
	cp 001h		;9af0   ; 1?
	jr nz,enemigos_pon		;9af2   ; no: el 3 (el verde) o el 4 (el pajaro)
	ld a,r		;9af4   ; al azar...
	bit 3,a		;9af6   ; ...el bit 3
	jr nz,enemigos_pez2		;9af8
	ld a,001h		;9afa   ; el pez 1
	jr enemigos_pon		;9afc
enemigos_pez2:
	ld a,002h		;9afe   ; el pez 2
enemigos_pon:
	ld (iy+004h),a		;9b00   ; el tipo
	ret			;9b03
jefe_pon:		; En tierra, el jefe (0xE500): en la VRAM 0x1908 (la fila 8, columna 8), Y 0x68 y X 0x50; su sitio en blanco (8 x 8 casillas) y su dibujo de la escena (0x9B6D)
	ld hl,01908h		;9b04   ; la fila 8, columna 8
	ld iy,0e500h		;9b07   ; IY: el jefe
	ld (iy+004h),001h		;9b0b   ; esta
	ld (iy+005h),l		;9b0f   ; su sitio en la pantalla
	ld (iy+006h),h		;9b12
	ld (iy+000h),068h		;9b15   ; Y 0x68
	ld (iy+001h),050h		;9b19   ; X 0x50
	call jefe_blanco		;9b1d   ; en blanco
	ld (iy+004h),001h		;9b20   ; esta
	ld hl,09b6dh		;9b24   ; sus dibujos (0x9B6D)
	jr jefe_dibujo		;9b27
jefe_blanco:		; Las 8 x 8 casillas del jefe (desde +5) en blanco (0x10)
	ld l,(iy+005h)		;9b29   ; su sitio...
	ld h,(iy+006h)		;9b2c   ; ...en la pantalla
	ld b,008h		;9b2f   ; 8 filas
jefe_blanco_fila:
	ld c,008h		;9b31   ; 8 casillas
jefe_blanco_casilla:
	ld a,010h		;9b33   ; en blanco
	call 0004dh		;9b35   ; WRTVRM
	inc hl			;9b38
	dec c			;9b39   ; una menos
	jr nz,jefe_blanco_casilla		;9b3a
	ld de,00018h		;9b3c   ; la fila siguiente: +24
	add hl,de			;9b3f
	djnz jefe_blanco_fila		;9b40   ; una fila menos
	ret			;9b42
jefe_dibujo:		; El dibujo de la escena en la tabla HL (un puntero por escena) en su sitio (una fila mas abajo, salvo en la escena 4)
	ld a,(0e003h)		;9b43   ; la escena...
	add a,a			;9b46   ; ...x 2
	add a,l			;9b47
	jr nc,L_9B4B		;9b48
	inc h			;9b4a
L_9B4B:
	ld l,a			;9b4b
	ld e,(hl)			;9b4c   ; su dibujo
	inc hl			;9b4d
	ld d,(hl)			;9b4e
	ld l,(iy+005h)		;9b4f   ; su sitio
	ld h,(iy+006h)		;9b52
	ld a,(0e003h)		;9b55   ; la escena 4?
	cp 004h		;9b58
	jr z,L_9B62		;9b5a   ; si: ahi
	push de			;9b5c
	ld de,00020h		;9b5d   ; si no, una fila abajo
	add hl,de			;9b60
	pop de			;9b61
L_9B62:
	jp dibujo_mapa		;9b62   ; a la pantalla

; ----------------------------------------------------------------------
; DATOS jefe_dibujos: 8 casillas en blanco (0x9B65) y cinco tablas de los
;   dibujos del jefe, un puntero por escena (0x9B6D, 0x9B77, 0x9B81, 0x9B8B y
;   0x9B95)
;   0x9b65..0x9b9f  (58 bytes)
DATA_jefe_dibujos:
	defb 010h,010h,010h,010h,010h,010h,010h,010h,055h,09fh,0c3h,04ah,02ah,0a0h,0e3h,0a0h	; 9b65  ........U..J*...
	defb 09ch,0a1h,07ah,09fh,0e1h,04ah,04fh,0a0h,008h,0a1h,0beh,0a1h,09fh,09fh,057h,04bh	; 9b75  ..z..JO.......WK
	defb 074h,0a0h,02dh,0a1h,0e8h,0a1h,0cbh,09fh,024h,04bh,099h,0a0h,052h,0a1h,012h,0a2h	; 9b85  t.-.....$K..R...
	defb 0feh,09fh,0ffh,04ah,0beh,0a0h,077h,0a1h,034h,0a2h	; 9b95  ...J..w.4.

; ======================================================================
; CODIGO 0x9b9f..0x9e54  (693 bytes)
; ======================================================================


jefe:		; El jefe (0xE500): con su barra (0xE1B7, la de abajo) a su rutina (0x9C1A); vacia, vencido: el protagonista protegido y, cada 4 cuadros, el efecto 3 y sus dos dibujos alternando 32 veces; despues, el tipo 6 (en pequeno, 0xE400) en su X - 16, el jefe fuera y la musica 3
	ld a,(0e1b7h)		;9b9f   ; su barra...
	and a			;9ba2   ; ...vacia?
	jp nz,jefe_piensa		;9ba3   ; no: a su rutina
	ld (ix+003h),005h		;9ba6   ; el protagonista: sus colores...
	ld (ix+013h),00bh		;9baa
	ld (ix+01fh),0f8h		;9bae   ; ...y protegido
	call prota_vram		;9bb2   ; a la VRAM
	ld a,(0e010h)		;9bb5   ; un cuadro
	cp 001h		;9bb8
	jr c,jefe		;9bba
	xor a			;9bbc   ; la cuenta a 0
	ld (0e010h),a		;9bbd
	inc (iy+02ah)		;9bc0   ; cada 4 cuadros
	ld a,(iy+02ah)		;9bc3
	cp 004h		;9bc6
	jr c,jefe		;9bc8
	ld (iy+02ah),000h		;9bca   ; a 0
	ld a,003h		;9bce   ; el efecto 3
	call efecto_a_pide		;9bd0
	call jefe_blanco		;9bd3   ; en blanco
	inc (iy+02bh)		;9bd6   ; una vez mas
	ld a,(iy+02bh)		;9bd9
	cp 020h		;9bdc   ; 32?
	jr nc,jefe_vencido_fin		;9bde   ; si: se acabo
	and 001h		;9be0   ; par o impar
	and a			;9be2
	jr nz,jefe_vencido_otro		;9be3
	call jefe_columna_menos		;9be5   ; un dibujo...
	ld hl,09b6dh		;9be8   ; ...(0x9B6D)
	jr jefe_vencido_pinta		;9beb
jefe_vencido_otro:
	call jefe_columna_mas		;9bed   ; ...u otro...
	ld hl,09b77h		;9bf0   ; ...(0x9B77)
jefe_vencido_pinta:
	call jefe_dibujo		;9bf3   ; pintado
	jr jefe		;9bf6
jefe_vencido_fin:
	ld a,006h		;9bf8   ; el tipo 6...
	ld (0e404h),a		;9bfa   ; ...en 0xE400...
	xor a			;9bfd
	ld (0e405h),a		;9bfe   ; ...desde el principio
	ld (0e504h),a		;9c01   ; el jefe fuera
	ld a,(0e501h)		;9c04   ; su X - 16...
	sub 010h		;9c07
	ld (0e401h),a		;9c09   ; ...para los dos sprites
	ld (0e411h),a		;9c0c
	ld a,00fh		;9c0f   ; el segundo, en pantalla
	ld (0e414h),a		;9c11
	ld a,003h		;9c14   ; la musica 3
	call musica_pide		;9c16
	ret			;9c19
jefe_piensa:		; El jefe con su barra: cada 16 - escena cuadros (+7) un paso (+9); con una accion pendiente (+8), la hace; si no, segun su modo (+0x0B) y lo lejos que este el protagonista (su X menos la del jefe): 0 decide; 1 y 5 atacan unas veces (+0x15); 2 se acerca o se aparta; 3 y 4 van hacia el; 6 retrocede (+0x1A); 7 avanza hasta X 0x50
	ld a,(0e003h)		;9c1a   ; la escena...
	ld b,a			;9c1d
	ld a,010h		;9c1e   ; ...16 - eso
	sub b			;9c20
	ld b,a			;9c21
	inc (iy+007h)		;9c22   ; la cuenta...
	ld a,(iy+007h)		;9c25
	cp b			;9c28   ; ...llega?
	jp c,jefe_choques		;9c29   ; no: solo los choques
	ld (iy+007h),000h		;9c2c   ; a 0
	inc (iy+009h)		;9c30   ; un paso mas
	ld a,(iy+008h)		;9c33   ; una accion pendiente?
	and a			;9c36
	jp nz,jefe_hace		;9c37   ; si: a hacerla
	ld a,(iy+00bh)		;9c3a   ; el modo...
	and a			;9c3d   ; ...0?
	jr nz,jefe_modo		;9c3e   ; no
	ld a,(ix+001h)		;9c40   ; la X del protagonista...
	ld b,(iy+001h)		;9c43   ; ...menos la del jefe
	sub b			;9c46
	cp 010h		;9c47   ; a 16 o mas?
	jp nc,jefe_lejos_mira		;9c49   ; si
	ld a,(0e1b7h)		;9c4c   ; pegado: su barra...
	cp 020h		;9c4f   ; ...por debajo de la mitad?
	jr nc,jefe_pegado		;9c51   ; no
	ld (iy+00bh),002h		;9c53   ; si: el modo 2
	jp jefe_ataca		;9c57   ; a atacar
jefe_pegado:
	ld a,r		;9c5a   ; al azar...
	and 003h		;9c5c
	inc a			;9c5e   ; ...1-4 veces
	ld (iy+015h),a		;9c5f
	inc (iy+00bh)		;9c62   ; el modo 1
	jr jefe_ataca		;9c65   ; a atacar
jefe_modo:
	cp 001h		;9c67   ; 1?
	jr z,jefe_modo1		;9c69   ; si
	cp 002h		;9c6b   ; 2?
	jr nz,jefe_modo3		;9c6d   ; no
	call jefe_lejos		;9c6f   ; lo lejos
	cp 030h		;9c72   ; menos de 0x30?
	jr c,jefe_cerca		;9c74   ; si
jefe_decide:
	ld (iy+00bh),000h		;9c76   ; el modo 0
	jp jefe_choques		;9c7a   ; y los choques
jefe_modo3:
	cp 003h		;9c7d   ; 3?
	jr nz,jefe_modo4		;9c7f   ; no
	call jefe_lejos		;9c81   ; lo lejos
	cp 010h		;9c84   ; 16 o mas?
	jr nc,jefe_derecha		;9c86   ; si: a la derecha
	jr jefe_decide		;9c88   ; no: decide
jefe_modo4:
	cp 004h		;9c8a   ; 4?
	jr nz,jefe_modo5		;9c8c   ; no
	call jefe_lejos		;9c8e   ; lo lejos
	cp 050h		;9c91   ; 0x50 o mas?
	jr nc,jefe_izquierda		;9c93   ; si: a la izquierda
	jr jefe_decide		;9c95   ; no: decide
jefe_lejos:		; A = la X del protagonista menos la del jefe
	ld a,(ix+001h)		;9c97   ; la del protagonista...
	ld b,(iy+001h)		;9c9a   ; ...menos la del jefe
	sub b			;9c9d
	ret			;9c9e
jefe_modo5:
	cp 005h		;9c9f   ; 5?
	jr nz,jefe_modo6		;9ca1   ; no
	dec (iy+015h)		;9ca3   ; una vez menos
	jr z,jefe_decide		;9ca6   ; ninguna: decide
	ld (iy+008h),001h		;9ca8   ; la accion 1
	jp jefe_hace		;9cac   ; hecha
jefe_modo6:
	cp 006h		;9caf   ; 6?
	jr nz,jefe_modo7		;9cb1   ; no
	dec (iy+01ah)		;9cb3   ; un paso atras menos
	jr nz,jefe_izquierda		;9cb6   ; quedan: a la izquierda
	jr jefe_decide		;9cb8   ; no: decide
jefe_modo7:
	ld a,(0e501h)		;9cba   ; su X...
	cp 050h		;9cbd   ; ...0x50 o mas?
	jr nc,jefe_decide		;9cbf   ; si: decide
	jr jefe_derecha		;9cc1   ; no: a la derecha
jefe_cerca:
	ld a,(iy+001h)		;9cc3   ; su X...
	cp 040h		;9cc6   ; ...0x40 o mas?
	jr nc,jefe_izquierda		;9cc8   ; si: a la izquierda
	ld a,(iy+009h)		;9cca   ; cada 2 pasos...
	and 002h		;9ccd
	and a			;9ccf
	jr z,jefe_ataca		;9cd0   ; ...ataca...
	jr jefe_derecha		;9cd2   ; ...o a la derecha
jefe_modo1:
	dec (iy+015h)		;9cd4   ; una vez menos
	jr nz,jefe_ataca		;9cd7   ; quedan: ataca
	ld (iy+00bh),000h		;9cd9   ; si no: decide
jefe_ataca:		; Al azar, la accion 4 o la 5 (los dos ataques)
	ld a,r		;9cdd   ; al azar...
	and 001h		;9cdf
	and a			;9ce1
	jr nz,jefe_ataca5		;9ce2   ; ...el 5
	ld a,004h		;9ce4   ; el 4
	jr jefe_accion		;9ce6
jefe_ataca5:
	ld a,005h		;9ce8   ; el 5
jefe_accion:
	ld (iy+008h),a		;9cea   ; la accion
	jp jefe_hace		;9ced   ; hecha
jefe_izquierda:
	ld a,003h		;9cf0   ; la accion 3: a la izquierda
	jr jefe_accion		;9cf2
jefe_derecha:
	ld a,002h		;9cf4   ; la accion 2: a la derecha
	jr jefe_accion		;9cf6
jefe_lejos_mira:
	cp 030h		;9cf8   ; 0x30 o mas?
	jr nc,jefe_muy_lejos		;9cfa   ; si
	cp 020h		;9cfc   ; 0x20 o mas?
	jr nc,jefe_derecha		;9cfe   ; si: a la derecha
jefe_modo_azar:
	ld a,r		;9d00   ; al azar...
	and 003h		;9d02
	inc a			;9d04   ; ...el modo 1-4...
	ld (iy+00bh),a		;9d05
	ld (iy+015h),a		;9d08   ; ...y tantas veces
	jp jefe_choques		;9d0b   ; y los choques
jefe_muy_lejos:
	ld a,r		;9d0e   ; al azar...
	and 002h		;9d10
	and a			;9d12
	jr nz,jefe_muy_lejos_azar		;9d13   ; ...un modo al azar
	ld (iy+00bh),003h		;9d15   ; o el 3
	jp jefe_choques		;9d19
jefe_muy_lejos_azar:
	jr jefe_modo_azar		;9d1c
jefe_hace:		; La accion (+8): el jefe en blanco y 1, respirar (sus dos dibujos por el paso); 2, 8 pixeles (una columna) a la derecha hasta X 0xD8; 3, a la izquierda hasta X 0x17 (alli se vuelve); 4, el primer ataque (los dibujos de 0x9B81 y 0x9B8B; desde la escena 2 tira el tipo 12); 5, el segundo (0x9B95; tira el 11 desde la escena 2, el 9 en la 4)
	call jefe_blanco		;9d1e   ; en blanco
	ld a,(iy+008h)		;9d21   ; la accion...
	cp 001h		;9d24   ; ...1?
	jr nz,jefe_accion2		;9d26   ; no
	ld a,(iy+009h)		;9d28   ; cada 2 pasos...
	and 002h		;9d2b
jefe_dibujo_par:
	and a			;9d2d
	jr nz,jefe_dibujo_b		;9d2e   ; ...el otro dibujo
jefe_dibujo_a:
	ld (iy+00eh),000h		;9d30   ; el dibujo 0...
	ld hl,09b6dh		;9d34   ; ...(0x9B6D)
jefe_accion_fin:
	ld (iy+008h),000h		;9d37   ; sin accion
jefe_pinta:
	call jefe_dibujo		;9d3b   ; pintado
	jp jefe_choques		;9d3e   ; y los choques
jefe_dibujo_b:
	ld (iy+00eh),001h		;9d41   ; el dibujo 1...
	ld hl,09b77h		;9d45   ; ...(0x9B77)
	jr jefe_accion_fin		;9d48
jefe_accion2:
	cp 002h		;9d4a   ; 2?
	jr nz,jefe_accion3		;9d4c   ; no
	ld (iy+008h),000h		;9d4e   ; hecha
jefe_a_derecha:
	ld a,(iy+001h)		;9d52   ; su X...
	cp 0d8h		;9d55   ; ...0xD8 o mas?
	jr nc,jefe_vuelve_izq		;9d57   ; si: se vuelve
	add a,008h		;9d59   ; 8 a la derecha
	call jefe_columna_mas		;9d5b   ; una columna a la derecha
jefe_x:
	ld (iy+001h),a		;9d5e   ; la X
	ld a,l			;9d61   ; la columna, par o impar...
	and 001h		;9d62
	jr jefe_dibujo_par		;9d64   ; ...su dibujo
jefe_columna_mas:		; Su sitio en la pantalla (+5), una columna a la derecha
	ld l,(iy+005h)		;9d66   ; su sitio...
	ld h,(iy+006h)		;9d69
	inc hl			;9d6c   ; ...+ 1
jefe_columna_pon:
	ld (iy+005h),l		;9d6d   ; apuntado
	ld (iy+006h),h		;9d70
	ret			;9d73
jefe_columna_menos:		; Su sitio en la pantalla, una columna a la izquierda
	ld l,(iy+005h)		;9d74   ; su sitio...
	ld h,(iy+006h)		;9d77
	dec hl			;9d7a   ; ...- 1
	jr jefe_columna_pon		;9d7b
jefe_vuelve_izq:
	ld (iy+008h),003h		;9d7d   ; la accion 3
	jr jefe_a_izquierda		;9d81
jefe_accion3:
	cp 003h		;9d83   ; 3?
	jr nz,jefe_accion4		;9d85   ; no
	ld (iy+008h),000h		;9d87   ; hecha
jefe_a_izquierda:
	ld a,(iy+001h)		;9d8b   ; su X...
	cp 017h		;9d8e   ; ...menos de 0x17?
	jr c,jefe_vuelve_der		;9d90   ; si: se vuelve
	sub 008h		;9d92   ; 8 a la izquierda
	call jefe_columna_menos		;9d94   ; una columna a la izquierda
	jr jefe_x		;9d97
jefe_vuelve_der:
	ld (iy+008h),004h		;9d99   ; la accion 4...
	jr jefe_a_derecha		;9d9d   ; ...y a la derecha
jefe_accion4:
	cp 004h		;9d9f   ; 4?
	jr nz,jefe_accion5		;9da1   ; no: la 5
	ld a,(iy+00ah)		;9da3   ; su paso...
	inc (iy+00ah)		;9da6   ; ...y el siguiente
	and a			;9da9   ; el primero?
	jr nz,jefe_ataque1_b		;9daa   ; no
	ld (iy+00eh),002h		;9dac   ; el dibujo 2...
	ld hl,09b81h		;9db0   ; ...(0x9B81)
	jr jefe_pinta		;9db3
jefe_ataque1_b:
	cp 001h		;9db5   ; el segundo?
	jr nz,jefe_ataque1_fin		;9db7   ; no: se acabo
	ld a,(0e003h)		;9db9   ; desde la escena 2...
	cp 002h		;9dbc
	jr c,jefe_ataque1_dibujo		;9dbe
	ld c,00ch		;9dc0   ; ...el tipo 12...
	call jefe_tira		;9dc2   ; ...sale
jefe_ataque1_dibujo:
	ld (iy+00eh),003h		;9dc5   ; el dibujo 3...
	ld hl,09b8bh		;9dc9   ; ...(0x9B8B)
	ld (iy+00ah),000h		;9dcc   ; el paso a 0
	ld (iy+007h),008h		;9dd0   ; 8 cuadros mas
	jp jefe_accion_fin		;9dd4
jefe_ataque1_fin:
	ld (iy+008h),000h		;9dd7   ; sin accion
	ld (iy+00ah),000h		;9ddb   ; el paso a 0
	jp jefe_dibujo_a		;9ddf   ; el dibujo 0
jefe_accion5:
	ld a,(iy+00ah)		;9de2   ; su paso...
	inc (iy+00ah)		;9de5   ; ...y el siguiente
	and a			;9de8   ; el primero?
	jr nz,jefe_ataque2_fin		;9de9   ; no: se acabo
	ld a,(0e003h)		;9deb   ; la escena...
	cp 004h		;9dee   ; ...4?
	jr nz,jefe_ataque2_tiro		;9df0   ; no
	ld c,009h		;9df2   ; el tipo 9...
	call jefe_tira		;9df4   ; ...sale
	jr jefe_ataque2_dibujo		;9df7
jefe_ataque2_tiro:
	cp 002h		;9df9   ; desde la escena 2...
	jr c,jefe_ataque2_dibujo		;9dfb
	ld c,00bh		;9dfd   ; ...el tipo 11...
	call jefe_tira		;9dff   ; ...sale
jefe_ataque2_dibujo:
	ld (iy+00ah),000h		;9e02   ; el paso a 0
	ld (iy+00eh),004h		;9e06   ; el dibujo 4...
	ld hl,09b95h		;9e0a   ; ...(0x9B95)
	jp jefe_accion_fin		;9e0d
jefe_ataque2_fin:
	ld (iy+00ah),000h		;9e10   ; el paso a 0
	ld (iy+008h),000h		;9e14   ; sin accion
	jp jefe_dibujo_a		;9e18   ; el dibujo 0
jefe_choques:		; Los choques del jefe con su dibujo (+0x0E), por las cajas de 0x9F2D (8 bytes por dibujo): su cuerpo de lado, un golpe, el protagonista 16 a la derecha y el efecto 4; la caja de su ataque (Y y X desde las suyas), dos golpes; el arma en su caja, un golpe al jefe (su barra), el efecto 3, la accion 4 y el arma vuelve; con poca barra o al azar, se retira (modo 6, de 2 a 5 pasos) o, pegado a la izquierda, avanza (modo 7)
	ld hl,09f23h		;9e1b   ; las cajas (0x9F23)...
	ld a,(0e003h)		;9e1e   ; ...de la escena
	add a,a			;9e21
	add a,l			;9e22
	jr nc,L_9E26		;9e23
	inc h			;9e25
L_9E26:
	ld l,a			;9e26
	ld e,(hl)			;9e27   ; su tabla
	inc hl			;9e28
	ld d,(hl)			;9e29
	ex de,hl			;9e2a
	ld a,(iy+00eh)		;9e2b   ; el dibujo...
	add a,a			;9e2e   ; ...x 8
	add a,a			;9e2f
	add a,a			;9e30
	add a,l			;9e31
	jr nc,L_9E35		;9e32
	inc h			;9e34
L_9E35:
	ld l,a			;9e35
	ld c,(hl)			;9e36   ; la caja en X
	inc hl			;9e37
	ld b,(hl)			;9e38
	inc hl			;9e39
	call caja_x		;9e3a   ; toca?
	jr nc,$+25		;9e3d   ; no
	call golpe		;9e3f   ; un golpe
	ld a,(ix+001h)		;9e42   ; el protagonista...
	add a,010h		;9e45   ; ...16 a la derecha
	ld (ix+001h),a		;9e47
	call prota_sprites		;9e4a   ; sus sprites
	ld a,004h		;9e4d   ; el efecto 4
	call efecto_a_pide		;9e4f
	jr $+4		;9e52   ; a la caja del ataque

; ----------------------------------------------------------------------
; DATOS sobra_9e54: 2 bytes que el salto de 0x9E52 pasa por encima
;   0x9e54..0x9e56  (2 bytes)
DATA_sobra_9e54:
	defb 023h,023h	; 9e54

; ======================================================================
; CODIGO 0x9e56..0x9f23  (205 bytes)
; ======================================================================


jefe_choque_ataque:
	ld a,(iy+000h)		;9e56   ; la Y del jefe...
	ld c,(hl)			;9e59   ; ...+ la de la caja...
	add a,c			;9e5a
	ld (iy+00ch),a		;9e5b   ; ...apuntada
	ld a,(iy+001h)		;9e5e   ; la X del jefe...
	inc hl			;9e61
	ld b,(hl)			;9e62   ; ...+ la de la caja...
	add a,b			;9e63
	ld (iy+00dh),a		;9e64   ; ...apuntada
	inc hl			;9e67
	ld c,(hl)			;9e68   ; la caja en Y
	inc hl			;9e69
	ld b,(hl)			;9e6a
	inc hl			;9e6b
	call caja_y		;9e6c   ; toca?
	jr nc,jefe_choque_arma		;9e6f   ; no
	ld c,(hl)			;9e71   ; en X
	inc hl			;9e72
	ld b,(hl)			;9e73
	inc hl			;9e74
	call caja_x		;9e75   ; toca?
	jr nc,jefe_choque_arma		;9e78   ; no
	call golpe		;9e7a   ; dos golpes
	call golpe		;9e7d
	ld a,004h		;9e80   ; el efecto 4
	call efecto_a_pide		;9e82
jefe_choque_arma:
	ld a,(ix+024h)		;9e85   ; el arma fuera?
	and a			;9e88
	ret z			;9e89   ; no: listo
	ld a,(ix+026h)		;9e8a   ; volviendo?
	and a			;9e8d
	ret nz			;9e8e   ; si: listo
	ld hl,09f23h		;9e8f   ; las cajas, otra vez
	ld a,(0e003h)		;9e92
	add a,a			;9e95
	add a,l			;9e96
	jr nc,jefe_choque_arma_caja		;9e97
	inc h			;9e99
jefe_choque_arma_caja:
	ld l,a			;9e9a
	ld e,(hl)			;9e9b   ; su tabla
	inc hl			;9e9c
	ld d,(hl)			;9e9d
	ex de,hl			;9e9e
	ld a,(iy+00eh)		;9e9f   ; el dibujo...
	add a,a			;9ea2   ; ...x 8
	add a,a			;9ea3
	add a,a			;9ea4
	add a,l			;9ea5
	jr nc,L_9EA9		;9ea6
	inc h			;9ea8
L_9EA9:
	ld l,a			;9ea9   ; la caja del arma
	ld c,(hl)			;9eaa
	inc hl			;9eab
	ld b,(hl)			;9eac
	inc hl			;9ead
	call caja_arma		;9eae   ; le da?
	jr nc,L_9EE7		;9eb1   ; no
	call golpe_abajo		;9eb3   ; un golpe al jefe
	ld a,003h		;9eb6   ; el efecto 3
	call efecto_a_pide		;9eb8
	ld (iy+007h),00ah		;9ebb   ; 10 cuadros
	ld (iy+008h),004h		;9ebf   ; la accion 4
	ld (ix+026h),001h		;9ec3   ; el arma vuelve
	ld a,(0e1b7h)		;9ec7   ; su barra...
	cp 008h		;9eca   ; ...menos de 8?
	jr c,jefe_retira		;9ecc   ; si: se retira
	ld a,r		;9ece   ; al azar...
	bit 2,a		;9ed0   ; ...la mitad de las veces...
	ret nz			;9ed2   ; ...nada
jefe_retira:
	ld a,(0e501h)		;9ed3   ; su X...
	cp 020h		;9ed6   ; ...menos de 0x20?
	jr c,jefe_avanza		;9ed8   ; si: avanza
	ld a,r		;9eda   ; al azar...
	and 003h		;9edc
	add a,002h		;9ede   ; ...de 2 a 5 pasos...
	ld (iy+01ah),a		;9ee0   ; ...atras
	ld (iy+00bh),006h		;9ee3   ; el modo 6
L_9EE7:
	ret			;9ee7
jefe_avanza:
	ld (iy+00bh),007h		;9ee8   ; el modo 7
	ret			;9eec
caja_arma:		; C si la X del arma menos la del jefe cae en la caja (B y C, como cerca_mira)
	push bc			;9eed
	ld a,(ix+021h)		;9eee   ; la X del arma...
	ld b,(iy+001h)		;9ef1   ; ...menos la del jefe
	jr caja_mira		;9ef4
caja_x:		; C si la X del protagonista menos la del jefe cae en la caja (B y C)
	push bc			;9ef6
	call jefe_lejos		;9ef7   ; lo lejos
	jr L_9F04		;9efa
caja_y:		; C si la Y del protagonista menos la de la caja (+0x0C) cae en la caja (B y C)
	push bc			;9efc
	ld a,(ix+000h)		;9efd   ; la Y del protagonista...
	ld b,(iy+00ch)		;9f00   ; ...menos la de la caja
caja_mira:
	sub b			;9f03
L_9F04:
	pop bc			;9f04
	cp b			;9f05   ; menos que B...
	ret c			;9f06   ; ...dentro: C
	cp c			;9f07   ; menos que C?
	jr c,caja_fuera		;9f08   ; si: fuera
	scf			;9f0a   ; no: dentro
	ret			;9f0b
caja_fuera:
	xor a			;9f0c   ; fuera: NC
	ret			;9f0d
jefe_tira:		; El jefe tira el tipo C: en 0xE400 o, si esta ocupado, en 0xE420; si no, nada
	ld a,(0e404h)		;9f0e   ; 0xE400 libre?
	and a			;9f11
	jr nz,jefe_tira_otro		;9f12   ; no
	ld a,c			;9f14   ; si: el tipo
	ld (0e404h),a		;9f15
	ret			;9f18
jefe_tira_otro:
	ld a,(0e424h)		;9f19   ; 0xE420 libre?
	and a			;9f1c
	ret nz			;9f1d   ; no: nada
	ld a,c			;9f1e   ; el tipo
	ld (0e424h),a		;9f1f
	ret			;9f22

; ----------------------------------------------------------------------
; DATOS jefe_datos: Las cajas del jefe (0x9F23: un puntero por escena, todos a
;   0x9F2D; 8 bytes por dibujo: la caja del cuerpo en X, el sitio de la del
;   ataque y sus Y y X) y sus dibujos en casillas (ancho, alto y casillas),
;   cinco por escena (las tablas de 0x9B6D)
;   0x9f23..0xa256  (819 bytes)
DATA_jefe_datos:
	defb 02dh,09fh,02dh,09fh,02dh,09fh,02dh,09fh,02dh,09fh,0fch,008h,008h,010h,0eeh,002h	; 9f23  -.-.-.-.-.......
	defb 0e0h,004h,0fch,008h,008h,010h,0eeh,002h,0e0h,004h,0f8h,008h,008h,010h,0eeh,002h	; 9f33  ................
	defb 0f8h,004h,0f4h,008h,008h,014h,0ech,004h,0f0h,022h,0fch,008h,008h,01ch,0eeh,004h	; 9f43  ........."......
	defb 0e0h,004h,005h,007h,010h,010h,010h,010h,010h,010h,018h,019h,01ah,01bh,010h,01ch	; 9f53  ................
	defb 01dh,01eh,010h,010h,01fh,014h,02ah,010h,010h,02ch,02dh,02eh,02fh,010h,030h,031h	; 9f63  ......*..,-./.01
	defb 032h,033h,010h,034h,035h,036h,010h,005h,007h,010h,010h,010h,010h,010h,010h,018h	; 9f73  23.456..........
	defb 019h,01ah,01bh,010h,01ch,01dh,01eh,010h,010h,01fh,014h,02ah,010h,010h,02ch,02dh	; 9f83  ...........*..,-
	defb 02eh,02fh,010h,058h,059h,05ah,05bh,043h,05ch,05dh,05eh,05fh,006h,007h,010h,010h	; 9f93  ./.XYZ[C\]^_....
	defb 010h,010h,010h,010h,03eh,010h,000h,001h,002h,010h,03dh,03ch,023h,027h,005h,010h	; 9fa3  ....>.....=<#'..
	defb 03fh,010h,020h,021h,009h,010h,010h,010h,024h,025h,026h,039h,010h,010h,028h,029h	; 9fb3  ?. !....$%&9..()
	defb 02bh,038h,010h,03bh,037h,017h,010h,03ah,007h,007h,010h,010h,010h,010h,010h,010h	; 9fc3  +8.;7..:........
	defb 010h,010h,010h,041h,042h,010h,010h,010h,010h,010h,045h,046h,047h,010h,010h,010h	; 9fd3  ...AB.....EFG...
	defb 048h,049h,04ah,04bh,010h,010h,010h,04ch,04dh,04eh,04fh,07fh,07eh,010h,050h,051h	; 9fe3  HIJK...LMNO.~.PQ
	defb 052h,053h,057h,07dh,040h,054h,055h,056h,010h,010h,010h,006h,007h,010h,010h,010h	; 9ff3  RSW}@TUV........
	defb 010h,010h,010h,010h,010h,000h,001h,002h,010h,010h,010h,003h,004h,005h,006h,010h	; a003  ................
	defb 010h,007h,008h,009h,00ah,010h,010h,00bh,00ch,00dh,00eh,010h,044h,00fh,011h,012h	; a013  ............D...
	defb 013h,010h,010h,010h,015h,016h,010h,005h,007h,010h,010h,010h,010h,010h,010h,0e0h	; a023  ................
	defb 0e1h,0e2h,010h,010h,0e4h,0e5h,0e6h,0e7h,010h,0e8h,0e9h,0eah,0ebh,010h,0ech,0edh	; a033  ................
	defb 0eeh,010h,010h,0f0h,0f1h,0f2h,010h,010h,0f4h,0f5h,0f6h,010h,005h,007h,010h,010h	; a043  ................
	defb 010h,010h,010h,010h,0e0h,0e1h,0e2h,010h,010h,0e4h,0e5h,0e6h,0e7h,010h,0e8h,0e9h	; a053  ................
	defb 0eah,0ebh,010h,0ech,0edh,0eeh,010h,010h,0ceh,0cfh,0dah,010h,0dbh,0deh,0dfh,0d2h	; a063  ................
	defb 0d6h,005h,007h,010h,010h,010h,010h,010h,010h,010h,0f9h,0fah,0fbh,010h,0fch,0fdh	; a073  ................
	defb 0c7h,0cbh,010h,0a0h,0ach,0b4h,0bfh,010h,079h,063h,067h,078h,010h,0c3h,0c4h,0c5h	; a083  ........ycgx....
	defb 0c6h,010h,010h,0c8h,0c9h,0cah,005h,007h,0cch,010h,010h,010h,010h,0cdh,0d0h,0d1h	; a093  ................
	defb 0e2h,010h,010h,0d4h,0d5h,0e6h,0e7h,010h,0d8h,0d9h,0e4h,0ebh,010h,0dch,0ddh,0eeh	; a0a3  ................
	defb 010h,010h,0d3h,0d7h,0f2h,010h,010h,0f4h,0f5h,0f6h,010h,005h,007h,010h,010h,010h	; a0b3  ................
	defb 010h,010h,010h,010h,0f9h,0fah,0fbh,010h,0fch,0fdh,0feh,0ffh,010h,0e3h,0efh,0f3h	; a0c3  ................
	defb 0f7h,010h,0f8h,0c0h,0c1h,0c2h,010h,0c3h,0c4h,0c5h,0c6h,010h,010h,0c8h,0c9h,0cah	; a0d3  ................
	defb 005h,007h,010h,010h,010h,010h,010h,010h,061h,062h,063h,010h,010h,065h,066h,067h	; a0e3  ........abc..efg
	defb 070h,068h,069h,06ah,06bh,074h,06ch,06dh,06eh,06fh,010h,010h,071h,072h,073h,010h	; a0f3  phijktlmno..qrs.
	defb 010h,075h,076h,077h,010h,005h,007h,010h,010h,010h,010h,010h,010h,061h,062h,063h	; a103  .uvw.........abc
	defb 010h,010h,065h,066h,067h,070h,078h,069h,06ah,06bh,074h,07ch,06dh,06eh,06fh,010h	; a113  ..efgpxijkt|mno.
	defb 010h,079h,07ah,07bh,010h,010h,07dh,07eh,07fh,010h,005h,007h,010h,010h,010h,010h	; a123  .yz{..}~........
	defb 010h,010h,061h,062h,063h,010h,060h,064h,066h,067h,070h,068h,041h,042h,043h,074h	; a133  ..abc.`dfgphABCt
	defb 06ch,045h,046h,047h,010h,010h,071h,072h,073h,010h,010h,075h,076h,077h,010h,005h	; a143  lEFG..qrs..uvw..
	defb 007h,010h,010h,010h,010h,010h,010h,061h,062h,063h,010h,010h,065h,066h,067h,070h	; a153  .......abc..efgp
	defb 068h,049h,04ah,04bh,074h,06ch,04dh,04eh,053h,010h,010h,071h,072h,073h,010h,010h	; a163  hIJKtlMNS..qrs..
	defb 075h,076h,077h,010h,005h,007h,010h,061h,062h,063h,010h,010h,065h,066h,067h,070h	; a173  uvw....abc..efgp
	defb 068h,051h,052h,043h,074h,06ch,055h,056h,047h,050h,010h,059h,05ah,05bh,054h,010h	; a183  hQRCtlUVGP.YZ[T.
	defb 05dh,05eh,05fh,010h,010h,010h,058h,010h,010h,004h,008h,010h,010h,010h,010h,010h	; a193  ]^_...X.........
	defb 025h,026h,027h,010h,029h,02ah,02bh,02ch,02dh,02eh,02fh,030h,031h,032h,033h,034h	; a1a3  %&'.)*+,-./01234
	defb 035h,036h,037h,038h,039h,03ah,03bh,03ch,03dh,03eh,010h,005h,008h,010h,010h,010h	; a1b3  56789:;<=>......
	defb 010h,010h,010h,025h,026h,027h,010h,010h,029h,02ah,02bh,010h,02ch,02dh,02eh,009h	; a1c3  ...%&'..)*+.,-..
	defb 010h,030h,031h,00ah,00bh,007h,034h,035h,036h,008h,010h,040h,039h,044h,03bh,010h	; a1d3  .01...456..@9D;.
	defb 048h,04fh,08dh,093h,010h,005h,008h,006h,010h,010h,010h,010h,014h,020h,021h,026h	; a1e3  HO........... !&
	defb 027h,010h,022h,023h,02ah,02bh,010h,024h,028h,02eh,02fh,010h,03fh,000h,032h,033h	; a1f3  '."#*+.$(./.?.23
	defb 010h,001h,002h,003h,037h,010h,038h,004h,005h,03bh,010h,03ch,03dh,03eh,010h,004h	; a203  ....7.8..;.<=>..
	defb 008h,010h,010h,010h,010h,010h,025h,026h,027h,010h,029h,02ah,02bh,02ch,00dh,00eh	; a213  ......%&'.)*+,..
	defb 00fh,04ch,011h,012h,013h,001h,015h,016h,017h,040h,004h,044h,03bh,048h,04fh,08dh	; a223  .L.......@.D;HO.
	defb 093h,004h,008h,01ah,01bh,010h,010h,018h,019h,026h,027h,01ch,01dh,02ah,02bh,024h	; a233  .........&'..*+$
	defb 028h,02eh,02fh,03fh,000h,032h,033h,001h,002h,003h,037h,038h,004h,005h,03bh,03ch	; a243  (./?.23...78..;<
	defb 03dh,03eh,010h	; a253

; ======================================================================
; CODIGO 0xa256..0xa280  (42 bytes)
; ======================================================================


dibujo_mapa:		; Un dibujo de casillas (ancho, alto y casillas, DE) en la VRAM HL, en filas de 32
	ld a,(de)			;a256   ; el ancho
	ld (0e1a0h),a		;a257
	inc de			;a25a
	ld a,(de)			;a25b   ; el alto
	ld b,a			;a25c
	inc de			;a25d
	ld (0e1a2h),hl		;a25e   ; su sitio
dibujo_mapa_fila:
	ld hl,(0e1a2h)		;a261   ; la fila
	ld a,(0e1a0h)		;a264   ; el ancho
	ld c,a			;a267
dibujo_mapa_casilla:
	ld a,(de)			;a268   ; una casilla
	call 0004dh		;a269   ; WRTVRM
	inc hl			;a26c
	inc de			;a26d
	dec c			;a26e   ; una menos
	jr nz,dibujo_mapa_casilla		;a26f
	push de			;a271
	ld de,00020h		;a272   ; la fila siguiente (+32)
	ld hl,(0e1a2h)		;a275
	add hl,de			;a278
	pop de			;a279
	ld (0e1a2h),hl		;a27a
	djnz dibujo_mapa_fila		;a27d   ; una fila menos
	ret			;a27f

; ----------------------------------------------------------------------
; DATOS casillas_y_sprites: Las casillas del segundo tercio desde la escena 3
;   (0xA280, 0x400 bytes) y sus colores (0xA680), y los dibujos de los 64
;   sprites (0xAA80, 0x800 bytes; a 0x3800)
;   0xa280..0xb280  (4096 bytes)
DATA_casillas_y_sprites:
	defb 0f8h,0f0h,0f0h,0e0h,080h,080h,080h,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a280  ................
	defb 07fh,0ffh,07fh,001h,003h,007h,00fh,001h,003h,007h,007h,007h,003h,001h,0ffh,0ffh	; a290  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,003h,0ffh,0ffh,0ffh,0ffh,0ffh,01fh,007h,0ffh,0ffh,0c0h	; a2a0  ................
	defb 000h,000h,000h,000h,000h,01ch,038h,070h,000h,000h,000h,000h,000h,0c0h,0c0h,080h	; a2b0  ......8p........
	defb 000h,080h,0c0h,0e0h,0e0h,0e0h,0f0h,0f0h,0fch,0fch,0feh,0feh,0c7h,0c3h,0e3h,0fbh	; a2c0  ................
	defb 0fch,07fh,01fh,007h,001h,0ffh,0ffh,001h,00fh,0e7h,0fbh,0fdh,0feh,01fh,007h,001h	; a2d0  ................
	defb 0cfh,0e3h,0f8h,0feh,0ffh,0ffh,0ffh,0ffh,09dh,0ceh,0efh,0e7h,0f3h,0f9h,0fch,0feh	; a2e0  ................
	defb 0ffh,0ffh,03fh,03fh,0cfh,0cfh,0feh,07ch,0fch,0fch,0feh,0feh,0c7h,003h,063h,0ebh	; a2f0  ..??...|......c.
	defb 000h,000h,000h,000h,000h,000h,000h,000h,0ffh,0ffh,0ffh,0ffh,0ffh,01fh,00fh,001h	; a300  ................
	defb 03bh,087h,0ffh,0ffh,0ffh,0ffh,0f9h,0c0h,0cfh,087h,0f1h,0fdh,0f0h,0fch,0f0h,0fch	; a310  ;...............
	defb 060h,060h,060h,06fh,02ah,000h,000h,000h,07fh,00fh,07fh,0ffh,03fh,0ffh,0ffh,01fh	; a320  ```o*.......?...
	defb 0ffh,0e1h,00ch,007h,003h,001h,0ffh,0ffh,0f3h,0fbh,002h,0e0h,0e0h,0e0h,0f0h,0f0h	; a330  ................
	defb 07fh,07fh,03fh,01fh,00fh,007h,007h,007h,0f4h,0f4h,0f6h,0e3h,0fbh,0fbh,0f9h,0fdh	; a340  ..?.............
	defb 000h,018h,018h,018h,018h,01ah,0dfh,0ffh,000h,000h,000h,000h,000h,0a0h,0e0h,0f0h	; a350  ................
	defb 007h,007h,007h,00fh,01fh,01fh,03fh,03fh,0fdh,0fch,0fdh,0fdh,0fdh,0fdh,0fdh,0fdh	; a360  ......??........
	defb 0ffh,0ffh,0ffh,01fh,0c1h,0fch,0fch,0fch,0f8h,0feh,0f8h,0feh,0f8h,07eh,000h,0fch	; a370  .............~..
	defb 000h,05ah,07fh,07fh,07fh,0ffh,0ffh,03fh,004h,084h,086h,087h,097h,0d3h,0ebh,0e9h	; a380  .Z.....?........
	defb 03fh,01fh,01fh,00fh,00fh,00fh,00fh,01fh,0f5h,0f6h,0fbh,0fbh,0fbh,0fdh,0fdh,0fdh	; a390  ?...............
	defb 03fh,07fh,0ffh,0c7h,08fh,09fh,09fh,08fh,004h,004h,006h,007h,017h,013h,01bh,019h	; a3a0  ?...............
	defb 000h,000h,000h,000h,000h,080h,0c0h,0e0h,004h,004h,00ch,01ch,01ch,038h,078h,0f8h	; a3b0  .............8x.
	defb 0fdh,0fch,0fdh,0fdh,0fdh,0fdh,0f9h,0f9h,01dh,00eh,00fh,00fh,007h,027h,033h,039h	; a3c0  .............'39
	defb 0f1h,0fbh,03fh,03fh,0cfh,0cfh,0ffh,0ffh,0f0h,0f0h,0e0h,0e0h,0c0h,0c0h,0e0h,0f0h	; a3d0  ..??............
	defb 01fh,03fh,07fh,001h,007h,00fh,00fh,00fh,09dh,0deh,0cfh,0efh,0e7h,0f3h,0fbh,0f9h	; a3e0  .?..............
	defb 0ffh,0ffh,03fh,03fh,0cfh,0cfh,0ffh,0ffh,0fch,0fch,0feh,0feh,0c7h,0c3h,0e3h,0fbh	; a3f0  ..??............
	defb 00fh,007h,003h,001h,0ffh,07fh,07fh,03fh,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0f8h,0fch	; a400  .......?........
	defb 0fch,0feh,07fh,01fh,007h,001h,0ffh,0ffh,00fh,047h,043h,021h,090h,0c8h,0e0h,078h	; a410  .........GC!...x
	defb 03fh,01fh,01fh,00fh,003h,001h,0ffh,0ffh,0fch,0feh,07fh,07fh,03fh,01fh,00fh,03fh	; a420  ?...........?..?
	defb 003h,007h,087h,0c7h,0e3h,0f1h,0c0h,0c0h,03fh,09fh,0c6h,0e0h,0e0h,0e0h,0f0h,0f0h	; a430  ........?.......
	defb 0ffh,0ffh,0ffh,07fh,07fh,01fh,00fh,003h,03fh,03fh,02ah,0ffh,0ffh,003h,0ffh,0ffh	; a440  ........??*.....
	defb 0c0h,080h,080h,03fh,007h,0ffh,0ffh,0c0h,0f0h,0f0h,0f0h,0e0h,0e0h,0c0h,080h,000h	; a450  ...?............
	defb 003h,007h,007h,000h,007h,00fh,00fh,007h,0ffh,0ffh,07fh,0ffh,03fh,007h,0ffh,0ffh	; a460  ............?...
	defb 0c0h,0c0h,0e0h,0f0h,0f8h,0feh,0ffh,0ffh,0c3h,0f1h,0ffh,07fh,03fh,03fh,01fh,00fh	; a470  ............??..
	defb 0ffh,0ffh,0ffh,07fh,07fh,03fh,01fh,00fh,07fh,03fh,03eh,0e0h,0e0h,05fh,04fh,06fh	; a480  .....?...?>.._Oo
	defb 0bfh,0bfh,07fh,071h,078h,03ch,0e0h,0f0h,087h,0c0h,0f2h,0feh,07eh,000h,000h,0c0h	; a490  ...qx<......~...
	defb 0c0h,080h,080h,01fh,007h,0ffh,0ffh,078h,0efh,0efh,0f7h,0ffh,0ffh,0ffh,0ffh,0ffh	; a4a0  .......x........
	defb 0fch,0e0h,0fch,0ffh,0ffh,0ffh,0ffh,0ffh,0f8h,0f0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; a4b0  ................
	defb 03fh,07fh,07bh,007h,07fh,0ffh,0ffh,03fh,00ah,01fh,03fh,0c0h,0c0h,07fh,07fh,07fh	; a4c0  ?.{....?..?.....
	defb 07fh,07fh,07fh,071h,07ch,01ch,0c0h,0fch,087h,0c0h,0f2h,08eh,02eh,060h,0c4h,0f0h	; a4d0  ...q|........`..
	defb 00fh,007h,003h,001h,07fh,01fh,00fh,003h,003h,001h,0f7h,0f9h,0feh,0ffh,0ffh,0ffh	; a4e0  ................
	defb 0fch,0fch,0fch,0feh,03eh,0c0h,0ffh,0ffh,0feh,0fdh,0feh,0ffh,07fh,00fh,003h,0ffh	; a4f0  ....>...........
	defb 000h,000h,000h,000h,000h,030h,030h,070h,00ah,01fh,03fh,0c0h,0c0h,07bh,077h,06fh	; a500  .....00p..?..{wo
	defb 07fh,07fh,07fh,071h,078h,03ch,0e0h,0f0h,0f0h,0c0h,0f0h,0c0h,0f0h,0c0h,0c0h,0c0h	; a510  ...qx<..........
	defb 0f0h,0f0h,0e0h,0e0h,080h,000h,000h,000h,0efh,0dfh,0cdh,080h,080h,080h,0c0h,0e1h	; a520  ................
	defb 0fch,0e0h,0fch,0ffh,0ffh,07fh,07fh,00fh,000h,000h,000h,000h,000h,000h,000h,000h	; a530  ................
	defb 070h,000h,000h,000h,000h,000h,000h,000h,0f9h,0ffh,0ffh,0ffh,02fh,000h,028h,07fh	; a540  p.........../.(.
	defb 003h,0ffh,0feh,0ffh,0feh,003h,001h,0c0h,0e1h,0ffh,03fh,01ch,0ffh,0ffh,0feh,0feh	; a550  ..........?.....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,07fh,07fh,03fh,00fh,007h,007h,003h,000h	; a560  ..........?.....
	defb 080h,080h,080h,0c0h,0c0h,0e0h,0e0h,0f0h,0fch,07ch,038h,000h,000h,000h,000h,000h	; a570  .........|8.....
	defb 007h,00eh,01ch,018h,018h,018h,01bh,00ah,001h,001h,001h,001h,001h,001h,001h,001h	; a580  ................
	defb 000h,080h,080h,0c0h,060h,030h,01fh,00fh,020h,030h,070h,070h,0f0h,0e0h,0f8h,0fch	; a590  ....`0.. 0pp....
	defb 001h,030h,01ch,01eh,000h,02ah,0c0h,080h,001h,030h,01ch,01eh,00eh,00eh,00eh,006h	; a5a0  .0...*...0......
	defb 08fh,001h,003h,001h,0ffh,0ffh,07fh,07fh,0ffh,0fch,0ffh,0feh,0ffh,07fh,01fh,003h	; a5b0  ................
	defb 000h,000h,0fch,07fh,007h,07fh,003h,01fh,00ah,01fh,03fh,0c0h,0c0h,07fh,07bh,077h	; a5c0  ..........?...{w
	defb 07fh,07fh,07fh,071h,07ch,03fh,0f0h,0fch,087h,0c0h,0f2h,0feh,07eh,000h,0f8h,0f0h	; a5d0  ...q|?......~...
	defb 001h,00fh,000h,000h,000h,000h,000h,000h,0f7h,0f7h,0fdh,0f0h,0f0h,0f0h,0f0h,0f5h	; a5e0  ................
	defb 040h,0efh,09fh,01fh,00fh,007h,007h,05fh,0e0h,0e0h,0c0h,0c0h,0c0h,0c0h,0c0h,0c0h	; a5f0  @......_........
	defb 000h,080h,080h,080h,0c0h,0e0h,0e0h,0e0h,001h,007h,007h,041h,02fh,003h,001h,001h	; a600  ...........A/...
	defb 0ffh,0ffh,0feh,0fah,0fah,0feh,00fh,007h,0c0h,0c0h,0c0h,080h,000h,000h,0c3h,0ffh	; a610  ................
	defb 0e0h,0e0h,060h,060h,020h,000h,000h,000h,000h,001h,001h,000h,000h,000h,000h,000h	; a620  ..`` ...........
	defb 001h,080h,0ffh,0feh,0f8h,0f0h,060h,000h,0fch,0f8h,0c0h,000h,000h,000h,000h,000h	; a630  ......`.........
	defb 000h,000h,000h,000h,003h,003h,007h,007h,007h,007h,043h,0bfh,02fh,003h,003h,001h	; a640  ..........C./...
	defb 0ffh,0ffh,0feh,0fah,0fah,0f8h,0f8h,0fch,0c0h,0c0h,0c0h,080h,000h,000h,000h,000h	; a650  ................
	defb 005h,005h,005h,006h,006h,004h,004h,000h,001h,003h,003h,000h,003h,003h,001h,000h	; a660  ................
	defb 00fh,003h,0ffh,0ffh,0ffh,0f8h,0c0h,000h,080h,0e6h,0feh,0f8h,0c0h,000h,000h,000h	; a670  ................
	defb 0f4h,0f4h,0f5h,0f4h,0f5h,0e4h,0e5h,04fh,04fh,04fh,04fh,04fh,04fh,04fh,04fh,04fh	; a680  .......OOOOOOOOO
	defb 054h,04fh,054h,0e4h,0e5h,0e4h,054h,054h,0feh,0feh,0feh,0feh,0feh,0feh,05fh,05fh	; a690  TOT...TT......__
	defb 04fh,04fh,04fh,04fh,04fh,054h,04fh,0efh,05fh,05fh,05fh,054h,054h,05fh,04fh,0e0h	; a6a0  OOOOOTO.___TT_O.
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,090h,090h,090h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a6b0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,050h,050h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a6c0  ......PP........
	defb 0f0h,0feh,0feh,0feh,0feh,0efh,0efh,0feh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a6d0  ................
	defb 0c0h,0c0h,0c0h,0c0h,0cfh,0cfh,0cfh,04fh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a6e0  .......O........
	defb 0ffh,0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a6f0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0ffh,0ffh,0ffh,0ffh,0ffh,0feh,0feh,0feh	; a700  ................
	defb 0f0h,0f0h,0ffh,0ffh,0ffh,0ffh,0feh,0feh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a710  ................
	defb 090h,090h,090h,090h,090h,0f0h,0f0h,0f0h,0e4h,0e4h,054h,04fh,054h,04fh,04fh,054h	; a720  ..........TOTOOT
	defb 0efh,0e0h,0e0h,0feh,0feh,0feh,05fh,05fh,0e0h,0e0h,0e0h,0f0h,0f0h,0f0h,050h,050h	; a730  ......__......PP
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a740  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a750  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a760  ................
	defb 0cfh,0cfh,0cfh,0c0h,0c0h,0c0h,0c3h,0c3h,030h,0c0h,0c0h,0c0h,0c0h,0c0h,0f0h,030h	; a770  ........0......0
	defb 0f0h,0f0h,0f0h,0f9h,0f9h,0ffh,0ffh,0feh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a780  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a790  ................
	defb 0f0h,0f0h,0ffh,0feh,0feh,0feh,0feh,0feh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a7a0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a7b0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f4h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a7c0  ................
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0ffh,0ffh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a7d0  ................
	defb 0f0h,0f0h,0e0h,0feh,0feh,0feh,0feh,0feh,0f0h,0f0h,0f4h,0f4h,0f4h,0f4h,0f4h,0f4h	; a7e0  ................
	defb 0ffh,0ffh,0f0h,0f0h,0f0h,0f0h,0ffh,0ffh,0f0h,0f0h,0f0h,0f0h,0f9h,0f9h,0f9h,0f9h	; a7f0  ................
	defb 0feh,0feh,0feh,0feh,0efh,0e4h,0e4h,0e4h,0f4h,0f4h,0f5h,0f4h,0f5h,0f4h,0f5h,0f4h	; a800  ................
	defb 0f0h,0f0h,0feh,0feh,0feh,0feh,0efh,0efh,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a810  ................
	defb 0e4h,0e4h,0e4h,0e4h,0e4h,0e4h,04fh,04fh,0f5h,0f4h,0feh,0feh,0feh,0feh,0feh,0f4h	; a820  ......OO........
	defb 0feh,0feh,0feh,0feh,0feh,0feh,0f5h,0f5h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,050h,050h	; a830  ..............PP
	defb 04fh,04fh,04fh,040h,040h,040h,040h,0e0h,0f4h,0f4h,0f4h,04fh,04fh,054h,04fh,0efh	; a840  OOO@@@@....OOTO.
	defb 0f5h,0f5h,0f5h,054h,054h,05fh,04fh,0e0h,050h,050h,050h,050h,050h,050h,040h,0f0h	; a850  ...TT_O.PPPPPP@.
	defb 0e0h,0f0h,0e0h,0f0h,0e0h,0e0h,0e0h,0e0h,0efh,0efh,0f0h,0ffh,0feh,0feh,0efh,0efh	; a860  ................
	defb 0e0h,0f0h,0f0h,0f0h,0f0h,0f0h,0ffh,0efh,0feh,0feh,0ffh,0f4h,0f4h,0e4h,0e4h,0e4h	; a870  ................
	defb 04fh,04fh,04fh,040h,040h,040h,040h,0e0h,040h,040h,060h,076h,076h,060h,060h,060h	; a880  OOO@@@@.@@`vv```
	defb 040h,040h,040h,040h,040h,040h,064h,064h,040h,040h,040h,040h,040h,0f0h,0f0h,040h	; a890  @@@@@@dd@@@@@..@
	defb 0f5h,0f5h,0f5h,054h,054h,05fh,04fh,0e0h,060h,060h,060h,06fh,06fh,06fh,06fh,06fh	; a8a0  ...TT_O.```ooooo
	defb 064h,096h,096h,09fh,09fh,09fh,09fh,09fh,040h,040h,060h,090h,090h,090h,090h,090h	; a8b0  d.......@@`.....
	defb 0e0h,0e0h,0f0h,0e0h,0e0h,0efh,0efh,0e0h,060h,060h,060h,076h,076h,060h,060h,060h	; a8c0  ........```vv```
	defb 040h,040h,040h,040h,040h,040h,060h,094h,040h,040h,040h,040h,040h,040h,040h,040h	; a8d0  @@@@@@`.@@@@@@@@
	defb 0feh,0feh,0feh,0feh,0e4h,0e4h,0e4h,0e4h,096h,096h,060h,060h,060h,06fh,06fh,06fh	; a8e0  ..........```ooo
	defb 094h,094h,094h,064h,064h,090h,09fh,09fh,0e0h,0e0h,0feh,0ffh,0feh,0feh,0feh,0efh	; a8f0  ...dd...........
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,050h,050h,050h,060h,060h,060h,076h,076h,060h,060h,060h	; a900  .....PPP```vv```
	defb 040h,040h,040h,040h,040h,040h,064h,064h,040h,040h,040h,040h,040h,090h,090h,090h	; a910  @@@@@@dd@@@@@...
	defb 050h,050h,050h,050h,050h,0f0h,0f0h,0f0h,060h,060h,064h,064h,064h,064h,064h,064h	; a920  PPPPP...``dddddd
	defb 064h,096h,096h,09fh,09fh,094h,094h,096h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h	; a930  d...............
	defb 040h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,064h,06fh,06fh,06fh,060h,0f0h,040h,040h	; a940  @.......dooo`.@@
	defb 096h,06fh,064h,06fh,064h,040h,040h,040h,050h,05fh,054h,054h,04fh,04fh,040h,040h	; a950  .odod@@@P_TTOO@@
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,040h,040h,040h,040h,040h,040h,040h,0f0h	; a960  ........@@@@@@@.
	defb 040h,040h,040h,040h,040h,040h,040h,040h,040h,040h,040h,0f0h,0f0h,0f0h,0f0h,0f0h	; a970  @@@@@@@@@@@.....
	defb 0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,0b0h,040h,040h,040h,040h,040h,040h,040h,040h	; a980  ........@@@@@@@@
	defb 0f0h,040h,040h,040h,040h,040h,040h,040h,0b0h,050h,0b0h,050h,0b0h,050h,040h,050h	; a990  .@@@@@@@.P.P.P@P
	defb 040h,060h,060h,060h,0f0h,040h,0b4h,0b4h,040h,060h,060h,060h,060h,060h,060h,060h	; a9a0  @```.@..@```````
	defb 040h,054h,054h,054h,04fh,04fh,040h,040h,05fh,054h,05fh,054h,05fh,054h,054h,054h	; a9b0  @TTTOO@@_T_T_TTT
	defb 0f0h,0f0h,070h,070h,070h,070h,070h,070h,060h,060h,060h,076h,076h,060h,060h,060h	; a9c0  ..pppppp```vv```
	defb 040h,040h,040h,040h,040h,040h,064h,064h,040h,040h,040h,040h,040h,0f0h,040h,040h	; a9d0  @@@@@@dd@@@@@.@@
	defb 070h,070h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,060h,060h,064h,064h,064h,064h,064h,064h	; a9e0  pp......``dddddd
	defb 096h,096h,094h,094h,095h,095h,095h,094h,060h,060h,090h,090h,090h,090h,090h,090h	; a9f0  ........``......
	defb 0f0h,040h,050h,040h,050h,040h,050h,040h,096h,096h,096h,096h,060h,040h,040h,040h	; aa00  .@P@P@P@....`@@@
	defb 09fh,09fh,090h,090h,060h,040h,054h,054h,090h,090h,090h,090h,0f0h,0f0h,050h,05fh	; aa10  ....`@TT......P_
	defb 050h,040h,050h,040h,050h,0f0h,0f0h,0f0h,0f0h,050h,040h,0f0h,0f0h,0f0h,0f0h,0f0h	; aa20  P@P@P....P@.....
	defb 054h,054h,04fh,040h,040h,040h,040h,0f0h,050h,040h,040h,0f0h,0f0h,0f0h,0f0h,0f0h	; aa30  TTO@@@@.P@@.....
	defb 0f0h,0f0h,0f0h,0f0h,070h,070h,070h,070h,096h,096h,096h,060h,060h,040h,040h,040h	; aa40  ....pppp...``@@@
	defb 09fh,09fh,090h,090h,060h,040h,040h,040h,090h,090h,090h,090h,0f0h,0f0h,0f0h,0f0h	; aa50  ....`@@@........
	defb 070h,070h,070h,070h,070h,070h,070h,0f0h,040h,050h,040h,0f0h,040h,040h,040h,0f0h	; aa60  ppppppp.@P@.@@@.
	defb 054h,054h,04fh,04fh,04fh,040h,040h,0f0h,050h,050h,050h,040h,040h,0f0h,0f0h,0f0h	; aa70  TTOOO@@.PPP@@...
	defb 007h,00fh,019h,000h,000h,000h,000h,000h,007h,00fh,001h,00eh,007h,000h,004h,00fh	; aa80  ................
	defb 0e0h,0f6h,0f7h,0f2h,0b0h,060h,000h,0c0h,0c0h,0c0h,000h,040h,0c0h,000h,000h,0c0h	; aa90  .....`.....@....
	defb 000h,000h,006h,00fh,01bh,00fh,007h,003h,000h,000h,00eh,001h,000h,001h,00bh,000h	; aaa0  ................
	defb 000h,008h,000h,000h,040h,080h,080h,000h,000h,000h,040h,080h,000h,080h,0c0h,000h	; aab0  ....@.....@.....
	defb 000h,007h,00fh,019h,000h,000h,000h,000h,03ch,03bh,017h,080h,0dfh,04fh,04ch,020h	; aac0  ........<;...OL 
	defb 000h,0e6h,0f7h,0f2h,0f0h,0b0h,060h,000h,0f8h,0f8h,0f0h,002h,0f2h,0f2h,0ech,018h	; aad0  ......`.........
	defb 000h,000h,000h,006h,00fh,01bh,00fh,007h,043h,044h,008h,04fh,000h,030h,030h,000h	; aae0  ........CD.O.00.
	defb 000h,000h,008h,000h,000h,040h,080h,080h,004h,004h,000h,0e0h,00ch,00ch,010h,000h	; aaf0  .....@..........
	defb 000h,007h,00fh,019h,000h,000h,000h,000h,07fh,07fh,03fh,00fh,008h,007h,001h,000h	; ab00  ..........?.....
	defb 000h,0e6h,0f7h,0f2h,0f0h,0b0h,060h,000h,080h,0c0h,0a0h,07ah,0f2h,0e2h,0cch,018h	; ab10  ......`....z....
	defb 000h,000h,000h,006h,00fh,01bh,00fh,007h,080h,080h,000h,000h,007h,000h,000h,000h	; ab20  ................
	defb 000h,000h,008h,000h,000h,040h,080h,080h,000h,000h,040h,084h,00ch,00ch,010h,000h	; ab30  .....@....@.....
	defb 007h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; ab40  ................
	defb 0ffh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; ab50  ................
	defb 000h,000h,000h,000h,000h,000h,00fh,01fh,033h,001h,001h,000h,001h,00fh,01fh,01eh	; ab60  ........3.......
	defb 000h,000h,000h,000h,000h,000h,0cch,0eeh,0e4h,0e0h,060h,0c6h,0dbh,059h,03bh,0b9h	; ab70  ..........`..Y;.
	defb 000h,000h,000h,000h,000h,000h,000h,000h,00ch,01eh,036h,01fh,00eh,000h,000h,020h	; ab80  ..........6.... 
	defb 000h,000h,000h,000h,000h,000h,000h,010h,000h,000h,080h,000h,024h,026h,040h,042h	; ab90  ............$&@B
	defb 000h,000h,001h,007h,007h,00fh,00ah,008h,000h,000h,000h,000h,000h,002h,007h,00fh	; aba0  ................
	defb 078h,07ch,08ch,0e4h,0f0h,0f8h,0fch,05ch,014h,004h,000h,00ch,02ah,0f4h,07ah,0bch	; abb0  x|.....\....*.z.
	defb 000h,000h,000h,000h,000h,000h,005h,007h,005h,007h,007h,003h,001h,000h,000h,000h	; abc0  ................
	defb 000h,000h,070h,018h,008h,000h,000h,0a0h,068h,0f8h,0f0h,0e0h,0c0h,000h,000h,000h	; abd0  ..p.....h.......
	defb 00ch,008h,00ah,008h,008h,008h,00bh,003h,002h,001h,002h,003h,011h,008h,014h,00ah	; abe0  ................
	defb 03ch,01ch,05ch,01ch,01ch,008h,0d8h,0d8h,0d0h,050h,0d0h,0d0h,0c2h,004h,00ah,014h	; abf0  <.\......P......
	defb 003h,007h,000h,007h,007h,002h,000h,000h,000h,000h,000h,000h,00ah,007h,002h,000h	; ac00  ................
	defb 0c0h,0e0h,000h,0e0h,0e0h,040h,000h,000h,000h,000h,000h,008h,01ch,008h,010h,000h	; ac10  .....@..........
	defb 008h,000h,00ah,000h,000h,008h,00bh,003h,003h,002h,003h,003h,000h,001h,003h,001h	; ac20  ................
	defb 07ch,03ch,08ch,004h,02ch,008h,0d8h,0d8h,050h,090h,050h,0f0h,000h,000h,0e0h,040h	; ac30  |<..,...P.P....@
	defb 007h,00fh,000h,00fh,00fh,004h,000h,000h,000h,001h,000h,000h,000h,002h,000h,000h	; ac40  ................
	defb 080h,0c0h,030h,0f0h,0c0h,080h,000h,000h,080h,040h,080h,000h,0c0h,0c0h,000h,000h	; ac50  ..0......@......
	defb 007h,06fh,0efh,06fh,04dh,00dh,006h,002h,000h,003h,003h,003h,002h,002h,002h,002h	; ac60  .o.oM...........
	defb 0e0h,0f0h,098h,000h,000h,000h,000h,000h,000h,000h,0e0h,0e0h,0f0h,0f0h,0e8h,0d8h	; ac70  ................
	defb 000h,010h,010h,000h,002h,002h,001h,001h,001h,000h,000h,000h,000h,000h,000h,000h	; ac80  ................
	defb 000h,000h,060h,0f0h,0d0h,0d8h,0f0h,0f0h,0c0h,0c0h,000h,000h,000h,000h,000h,000h	; ac90  ..`.............
	defb 001h,001h,00dh,00ch,00ch,00dh,007h,007h,002h,000h,000h,000h,000h,000h,000h,007h	; aca0  ................
	defb 090h,080h,0f0h,070h,070h,070h,0f0h,0e0h,000h,000h,000h,000h,000h,000h,020h,0f0h	; acb0  ...ppp........ .
	defb 004h,004h,000h,003h,003h,002h,000h,000h,001h,003h,003h,003h,007h,007h,007h,000h	; acc0  ................
	defb 060h,060h,000h,080h,080h,080h,000h,000h,0c0h,080h,080h,080h,080h,0c0h,0d0h,000h	; acd0  ``..............
	defb 080h,040h,021h,010h,00ch,00eh,007h,011h,006h,003h,009h,003h,000h,001h,000h,000h	; ace0  .@!.............
	defb 000h,000h,000h,090h,008h,080h,0d4h,0f8h,0f0h,0fch,0fdh,07fh,03ah,07fh,03fh,04bh	; acf0  ............:.?K
	defb 0f2h,0f0h,0dch,0feh,06bh,035h,03bh,09dh,02bh,006h,001h,001h,00ah,000h,000h,000h	; ad00  ....k5;.+.......
	defb 000h,080h,000h,080h,008h,040h,0c8h,0b4h,0f8h,0dch,0bfh,0dfh,07ah,07bh,09dh,01fh	; ad10  .....@......z{..
	defb 001h,003h,007h,00fh,00fh,001h,000h,010h,018h,03ch,07eh,07eh,0ffh,07fh,02fh,00dh	; ad20  .........<~~../.
	defb 0f0h,0c0h,0e0h,0f0h,0f0h,000h,080h,000h,016h,032h,07eh,078h,0f8h,0f8h,0e8h,020h	; ad30  .........2~x... 
	defb 000h,000h,000h,010h,010h,00eh,00fh,00bh,005h,003h,001h,001h,000h,000h,000h,000h	; ad40  ................
	defb 008h,000h,000h,008h,008h,0f0h,072h,0d5h,0a1h,0c4h,080h,084h,004h,004h,004h,004h	; ad50  ......r.........
	defb 000h,000h,020h,013h,004h,009h,012h,0d4h,014h,012h,009h,004h,013h,020h,001h,001h	; ad60  .. .......... ..
	defb 080h,080h,002h,0c4h,020h,090h,048h,028h,02bh,048h,090h,020h,0c8h,004h,000h,000h	; ad70  .... .H(+H. ....
	defb 000h,000h,000h,000h,000h,001h,002h,005h,00fh,017h,03eh,043h,03dh,066h,0dbh,0a5h	; ad80  ..........>C=f..
	defb 00ch,016h,02fh,07dh,0fah,06ch,0dch,0f8h,0e8h,070h,0d0h,0a0h,0e0h,0c0h,040h,000h	; ad90  ../}.l...p....@.
	defb 000h,000h,000h,000h,000h,000h,001h,002h,000h,008h,001h,03ch,042h,099h,024h,05ah	; ada0  ...........<B.$Z
	defb 000h,008h,010h,002h,004h,090h,020h,000h,010h,080h,020h,040h,000h,000h,080h,080h	; adb0  ...... ... @....
	defb 000h,000h,000h,000h,000h,000h,000h,02ah,03fh,000h,000h,000h,000h,000h,000h,000h	; adc0  .......*?.......
	defb 000h,000h,000h,000h,000h,000h,000h,0a8h,0ech,00ch,00ch,00ch,01ch,038h,070h,000h	; add0  .............8p.
	defb 000h,00eh,01ch,038h,030h,030h,030h,035h,017h,000h,000h,000h,000h,000h,000h,000h	; ade0  ...80005........
	defb 000h,000h,000h,000h,000h,000h,000h,054h,0fch,000h,000h,000h,000h,000h,000h,000h	; adf0  .......T........
	defb 000h,000h,001h,001h,003h,003h,007h,007h,003h,001h,001h,001h,001h,001h,001h,001h	; ae00  ................
	defb 080h,080h,080h,080h,080h,080h,080h,0c0h,0e0h,0e0h,0c0h,0c0h,080h,080h,000h,000h	; ae10  ................
	defb 000h,000h,000h,000h,004h,001h,00bh,002h,017h,002h,001h,004h,001h,000h,000h,000h	; ae20  ................
	defb 000h,000h,000h,080h,000h,0d0h,040h,0a8h,060h,0c0h,0d0h,000h,000h,000h,000h,000h	; ae30  ......@.`.......
	defb 000h,000h,030h,020h,000h,000h,000h,070h,078h,03ch,03eh,01eh,006h,000h,000h,000h	; ae40  ..0 ...px<>.....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,010h,02ch,010h,010h,000h,000h	; ae50  ...........,....
	defb 000h,001h,007h,00fh,01fh,03fh,03fh,00fh,007h,003h,001h,001h,000h,000h,000h,000h	; ae60  .....??.........
	defb 000h,080h,0e0h,0f0h,0f0h,0f8h,0f8h,0f0h,0f0h,0e0h,0c0h,080h,008h,000h,000h,000h	; ae70  ................
	defb 078h,077h,06bh,07eh,07fh,03fh,007h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; ae80  xwk~.?..........
	defb 000h,0c0h,07eh,0b6h,0eah,0feh,0feh,03ch,000h,000h,000h,000h,000h,000h,000h,000h	; ae90  ..~....<........
	defb 000h,003h,07eh,06dh,057h,07fh,07fh,03ch,000h,000h,000h,000h,000h,000h,000h,000h	; aea0  ..~mW..<........
	defb 01eh,0eeh,0d6h,07eh,0feh,0fch,0e0h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; aeb0  ...~............
	defb 000h,000h,000h,05fh,015h,07fh,03ah,07fh,015h,05fh,00fh,00fh,007h,000h,000h,000h	; aec0  ..._..:.._......
	defb 000h,000h,000h,0c4h,044h,0feh,0f8h,0b8h,098h,09ch,0b8h,0f8h,0f0h,000h,000h,000h	; aed0  ....D...........
	defb 000h,000h,000h,000h,040h,000h,040h,000h,040h,000h,000h,000h,000h,000h,000h,000h	; aee0  ....@.@.@.......
	defb 000h,000h,038h,028h,038h,000h,006h,044h,066h,060h,040h,000h,000h,000h,000h,000h	; aef0  ..8(8..Df`@.....
	defb 000h,000h,08fh,055h,0bfh,01ah,0bfh,075h,0bfh,03fh,03fh,03fh,03fh,01fh,01fh,00fh	; af00  ...U...u.????...
	defb 000h,000h,0c4h,044h,0feh,0f8h,0d8h,0d8h,0d8h,0deh,0feh,0feh,0feh,0fch,0fch,0f8h	; af10  ...D............
	defb 000h,000h,000h,080h,040h,0e0h,040h,080h,000h,000h,000h,000h,000h,000h,000h,000h	; af20  ....@.@.........
	defb 000h,038h,028h,038h,000h,006h,024h,024h,026h,020h,000h,000h,000h,000h,000h,000h	; af30  .8(8..$$& ......
	defb 000h,000h,000h,000h,023h,017h,00fh,01dh,02bh,01fh,026h,040h,000h,000h,000h,000h	; af40  ....#...+.&@....
	defb 000h,000h,000h,000h,0c0h,0e0h,0f0h,0f8h,0f0h,0b0h,020h,000h,000h,000h,000h,000h	; af50  .......... .....
	defb 000h,000h,002h,047h,000h,020h,030h,020h,010h,020h,011h,023h,001h,000h,000h,000h	; af60  ...G. 0 . .#....
	defb 000h,000h,00eh,09fh,01bh,01fh,00eh,000h,00eh,048h,0ceh,0c0h,080h,000h,000h,000h	; af70  .........H......
	defb 000h,000h,000h,000h,040h,023h,057h,02dh,05bh,02fh,05fh,027h,043h,000h,000h,000h	; af80  ....@#W-[/_'C...
	defb 000h,000h,000h,000h,000h,080h,080h,0c0h,0f8h,0f0h,0b0h,020h,000h,000h,000h,000h	; af90  ........... ....
	defb 000h,000h,000h,002h,087h,040h,020h,050h,020h,050h,020h,050h,0a0h,001h,000h,000h	; afa0  .....@ P P P....
	defb 000h,03eh,07fh,07fh,077h,07fh,07fh,03eh,000h,00eh,048h,0ceh,0c0h,0c0h,080h,000h	; afb0  .>..w..>..H.....
	defb 000h,00fh,01fh,0ffh,07fh,03fh,030h,030h,030h,018h,00ch,000h,000h,000h,000h,000h	; afc0  .....?000.......
	defb 000h,0f8h,0fch,0fch,0cch,0c8h,0f8h,0f0h,0f0h,0e0h,0c0h,000h,000h,000h,000h,000h	; afd0  ................
	defb 000h,000h,000h,000h,000h,000h,00fh,00fh,00fh,007h,003h,011h,00ch,000h,000h,000h	; afe0  ................
	defb 000h,000h,000h,000h,003h,017h,006h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; aff0  ................
	defb 000h,000h,000h,000h,010h,0f0h,070h,03fh,03fh,03fh,03fh,01fh,00fh,000h,000h,000h	; b000  ......p????.....
	defb 000h,000h,000h,0f8h,07ch,07ch,04ch,0c8h,0f8h,0f0h,0f0h,0e0h,0c0h,000h,000h,000h	; b010  ....||L.........
	defb 008h,00ch,00eh,00fh,00fh,00fh,00fh,000h,000h,000h,000h,000h,000h,010h,00ch,000h	; b020  ................
	defb 000h,000h,000h,000h,080h,080h,093h,007h,006h,000h,000h,000h,000h,000h,000h,000h	; b030  ................
	defb 000h,000h,000h,000h,000h,000h,020h,060h,0f0h,000h,000h,000h,000h,000h,000h,000h	; b040  ...... `........
	defb 000h,002h,006h,00eh,01eh,03eh,07eh,0feh,0d8h,0b8h,0b8h,078h,038h,002h,001h,000h	; b050  .....>~....x8...
	defb 000h,000h,00eh,01fh,03fh,03fh,00fh,00fh,00fh,000h,000h,000h,000h,000h,000h,000h	; b060  ....??..........
	defb 000h,000h,000h,000h,001h,001h,001h,001h,006h,006h,006h,006h,004h,000h,000h,000h	; b070  ................
	defb 000h,000h,000h,000h,000h,020h,060h,0f0h,000h,000h,000h,000h,000h,000h,000h,000h	; b080  ..... `.........
	defb 000h,000h,000h,000h,000h,000h,0feh,0feh,0feh,0feh,07eh,07ch,07ah,079h,060h,040h	; b090  ..........~|zy`@
	defb 000h,00eh,01fh,03fh,03fh,00fh,00fh,00fh,000h,000h,000h,000h,000h,000h,000h,000h	; b0a0  ...??...........
	defb 000h,000h,008h,004h,006h,00fh,001h,000h,000h,002h,006h,004h,000h,000h,000h,000h	; b0b0  ................
	defb 007h,00fh,00fh,00fh,007h,001h,000h,002h,033h,01bh,03ah,018h,000h,000h,007h,002h	; b0c0  ........3.:.....
	defb 080h,0c0h,0e0h,080h,000h,080h,000h,000h,000h,080h,080h,000h,000h,080h,0c0h,080h	; b0d0  ................
	defb 000h,000h,000h,000h,000h,00eh,007h,005h,004h,004h,005h,007h,003h,003h,000h,000h	; b0e0  ................
	defb 000h,000h,000h,030h,0fch,000h,0c0h,0a0h,0d0h,070h,070h,0e0h,000h,000h,000h,000h	; b0f0  ...0.....pp.....
	defb 000h,007h,00fh,00fh,06fh,037h,079h,01ch,020h,018h,028h,010h,030h,010h,038h,010h	; b100  ....o7y. .(.0.8.
	defb 000h,080h,0c0h,0e0h,080h,000h,080h,000h,000h,000h,008h,01ch,008h,00ch,008h,000h	; b110  ................
	defb 000h,000h,000h,000h,000h,000h,006h,003h,007h,007h,007h,007h,00fh,00fh,000h,000h	; b120  ................
	defb 000h,000h,000h,000h,030h,0fch,000h,0c0h,0a0h,0d0h,0f0h,0e0h,0f0h,0f0h,000h,000h	; b130  ....0...........
	defb 01dh,03ch,038h,038h,038h,030h,030h,030h,038h,03fh,03ch,03ch,01fh,00ah,000h,02ah	; b140  .<8880008?<<...*
	defb 0d0h,018h,008h,008h,008h,000h,000h,000h,008h,0fah,018h,01ah,0f0h,0a2h,002h,000h	; b150  ................
	defb 002h,003h,007h,005h,006h,00fh,00eh,00fh,000h,000h,000h,003h,000h,004h,00ch,014h	; b160  ................
	defb 020h,0e0h,0f0h,0d0h,0b0h,0f8h,0b8h,0f8h,000h,000h,002h,0e0h,00eh,01ch,000h,000h	; b170   ...............
	defb 000h,008h,010h,010h,010h,000h,000h,000h,010h,058h,01fh,05fh,01fh,04fh,04ah,000h	; b180  .........X._.OJ.
	defb 000h,038h,01ch,01ch,01ch,00ch,00ch,00ch,01ch,03ch,0fch,0fch,0fch,0d8h,000h,054h	; b190  .8.......<.....T
	defb 004h,007h,00fh,00bh,00dh,01fh,01dh,01fh,000h,007h,040h,000h,060h,030h,000h,000h	; b1a0  ..........@.`0..
	defb 040h,0c0h,0e0h,0a0h,060h,0f0h,070h,0f0h,000h,0c0h,000h,000h,000h,020h,030h,028h	; b1b0  @...`.p...... 0(
	defb 029h,02bh,013h,00ah,00ah,00bh,009h,009h,004h,000h,000h,001h,000h,011h,00ah,004h	; b1c0  )+..............
	defb 0f8h,0fch,0fch,04ch,04ch,05ch,0f8h,050h,004h,0f2h,024h,0f8h,040h,011h,00ah,004h	; b1d0  ...LL\.P..$.@...
	defb 000h,001h,003h,003h,083h,043h,073h,089h,004h,002h,000h,008h,009h,008h,00fh,000h	; b1e0  .....Cs.........
	defb 000h,0f8h,0fch,0fch,024h,024h,0ach,0f8h,0a8h,000h,0fch,025h,0fdh,001h,09fh,000h	; b1f0  ....$$.....%....
	defb 000h,000h,000h,02fh,03fh,02fh,037h,01fh,01fh,00fh,03fh,03fh,00fh,00fh,000h,000h	; b200  .../?/7...??....
	defb 000h,000h,000h,0e0h,050h,0b0h,058h,0f8h,0c0h,0e0h,080h,0c0h,0e0h,000h,038h,0f8h	; b210  ....P.X.......8.
	defb 001h,003h,003h,000h,000h,000h,000h,000h,000h,080h,040h,0c0h,040h,080h,00fh,007h	; b220  ..........@.@...
	defb 000h,080h,080h,000h,000h,000h,000h,000h,000h,000h,000h,002h,006h,0e6h,0c6h,006h	; b230  ................
	defb 000h,000h,000h,02fh,03fh,02fh,037h,01fh,01fh,00fh,00fh,01fh,01fh,03fh,010h,000h	; b240  .../?/7......?..
	defb 000h,000h,000h,0e0h,070h,0b0h,0d8h,0f8h,0c0h,0e0h,080h,0c0h,0e8h,01ch,038h,0e0h	; b250  ....p.........8.
	defb 002h,007h,007h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,040h,02fh,057h	; b260  .............@/W
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,008h,00ch,00eh,006h,0e2h,0c0h,000h	; b270  ................

; ----------------------------------------------------------------------
; DATOS musicas: Las 7 musicas: las piezas de los canales A, B y C (6 bytes
;   cada una; la 0, nada)
;   0xb280..0xb2aa  (42 bytes)
DATA_musicas:
	defb 0c0h,0b6h,0c0h,0b6h,0c0h,0b6h,0e8h,0bah,01ch,0bbh,049h,0bbh,00bh,0bah,060h,0bah	; b280  ..........I...`.
	defb 0a3h,0bah,073h,0bbh,0d5h,0bbh,00fh,0bch,0c4h,0b6h,0c8h,0b6h,0cch,0b6h,073h,0bbh	; b290  ..s...........s.
	defb 0d5h,0bbh,00fh,0bch,0d2h,0b6h,084h,0b7h,0fbh,0b8h	; b2a0  ..........

; ----------------------------------------------------------------------
; DATOS efectos_a: Los 11 efectos del canal A: su pieza (2 bytes; el 0, nada)
;   0xb2aa..0xb2c0  (22 bytes)
DATA_efectos_a:
	defb 0bch,0b6h,0cfh,0bfh,0b3h,0bfh,07ch,0bfh,09bh,0bfh,0ddh,0bfh,0ddh,0bfh,06ah,0bfh	; b2aa  ......|.......j.
	defb 06ah,0bfh,04eh,0bfh,04eh,0bfh	; b2ba

; ----------------------------------------------------------------------
; DATOS efectos_bc: Los 8 efectos de los canales B y C: sus dos piezas (4
;   bytes; el 0, nada)
;   0xb2c0..0xb2e0  (32 bytes)
DATA_efectos_bc:
	defb 0c0h,0b6h,0c0h,0b6h,0c0h,0b6h,0c0h,0b6h,0dah,0beh,00dh,0bfh,027h,0beh,05fh,0beh	; b2c0  ............'._.
	defb 027h,0beh,05fh,0beh,027h,0beh,05fh,0beh,06ah,0bch,010h,0bdh,06ah,0bch,010h,0bdh	; b2d0  '._.'._.j...j...

; ======================================================================
; CODIGO 0xb2e0..0xb5b3  (723 bytes)
; ======================================================================


efecto_a_pide:		; Pide el efecto A del canal A (0xE2C0): si ya hay uno pedido, gana el de numero menor
	ld b,a			;b2e0   ; el efecto
	ld a,(0e000h)		;b2e1   ; jugando? (no sirve: pide_va mira otra cosa)
	and a			;b2e4
	ld a,b			;b2e5
	ld hl,0e2c0h		;b2e6   ; el efecto del canal A pedido
	jr pide_va		;b2e9   ; a pedirlo
efecto_bc_pide:		; Pide el efecto A de los canales B y C (0xE2C2), con la misma regla
	ld b,a			;b2eb   ; el efecto
	ld a,(0e000h)		;b2ec   ; jugando? (no sirve)
	and a			;b2ef
	ld a,b			;b2f0   ; el efecto
	ld hl,0e2c2h		;b2f1   ; el efecto pedido
pide_va:		; El pedido A en (HL), si no hay otro o el de antes es de numero mayor
	ld b,a			;b2f4   ; el nuevo
	ld a,(hl)			;b2f5   ; ya hay uno?
	and a			;b2f6
	jr z,pide_pon		;b2f7
	cp b			;b2f9   ; el de antes es menor: se queda
	ret c			;b2fa
pide_pon:
	ld (hl),b			;b2fb   ; el nuevo
	ret			;b2fc
musica_pide:		; Pide la musica A (0xE2BE), con la misma regla
	ld hl,0e2beh		;b2fd   ; la musica pedida
	jr pide_va		;b300
sonido:		; El sonido de cada cuadro (desde la interrupcion): una musica nueva o un efecto nuevo empiezan; los tres canales (0xE280, 0xE292, 0xE2A4, 18 bytes) siguen
	ld hl,0e2bdh		;b302   ; una musica sonando?
	xor a			;b305
	cp (hl)			;b306   ; sonando?
	jr nz,sonido_musica_mira		;b307
	inc hl			;b309   ; una pedida?
	cp (hl)			;b30a
	jp nz,musica_empieza		;b30b   ; empieza
	inc hl			;b30e
	cp (hl)			;b30f
	jr nz,sonido_efecto_a_mira		;b310
	inc hl			;b312
	cp (hl)			;b313
	jp nz,efecto_a_empieza		;b314
sonido_efecto_bc:
	xor a			;b317   ; nada en el canal A...
	inc hl			;b318   ; ...un efecto de B y C sonando?
	cp (hl)			;b319
	jr nz,sonido_efecto_bc_mira		;b31a   ; si
	inc hl			;b31c   ; uno pedido?
	cp (hl)			;b31d
	jp nz,efecto_bc_empieza		;b31e   ; si: empieza
sonido_musica_mira:
	call pedido_mira		;b321   ; una musica pedida antes que la que suena?
	jp c,musica_empieza		;b324   ; si: empieza
	jr sonido_canal_a		;b327   ; si no, el canal A
sonido_efecto_a_mira:
	call pedido_mira		;b329   ; un efecto del canal A pedido antes que el que suena?
	jp c,efecto_a_empieza		;b32c   ; si: empieza
	jr sonido_efecto_bc		;b32f
sonido_efecto_bc_mira:
	call pedido_mira		;b331   ; un efecto de B y C pedido antes que el que suena?
	jp c,efecto_bc_empieza		;b334   ; si: empieza
sonido_canal_a:		; El canal A: su bloque a 0xE2C3, un paso y de vuelta
	ld a,(0e2bdh)		;b337   ; la musica?
	and a			;b33a
	jr nz,sonido_canal_a_va		;b33b
	ld a,(0e2bfh)		;b33d   ; o un efecto que use el canal A?
	and a			;b340
	jr z,sonido_canal_b		;b341
sonido_canal_a_va:
	ld hl,0e280h		;b343   ; el canal A
	call canal_a_trabajo		;b346   ; al canal de trabajo
	ld bc,00008h		;b349   ; el canal A: registros 0 y 8
	xor a			;b34c   ; el canal 0
	call canal_un_paso		;b34d   ; un paso
	push af			;b350
	ld de,0e280h		;b351   ; de vuelta al canal A
	call canal_de_trabajo		;b354
	pop af			;b357
	and a			;b358   ; sigue?
	jr z,sonido_canal_b		;b359
	cp 001h		;b35b   ; 1: la musica acabada
	jp z,musica_acaba		;b35d
	cp 002h		;b360   ; 2: el efecto acabado
	jp z,sonido_a_acaba		;b362
sonido_canal_b:		; Los canales B y C: con la musica o el efecto de B y C, un paso de cada uno (los registros 2-3 y 9, 4-5 y 10); al acabar, sonido_bc_acaba (0xB677)
	ld a,(0e2bdh)		;b365   ; la musica?
	and a			;b368
	jr nz,sonido_canal_b_va		;b369
	ld a,(0e2c1h)		;b36b   ; o el efecto de B y C?
	and a			;b36e
	ret z			;b36f
sonido_canal_b_va:
	ld hl,0e292h		;b370   ; el canal B
	call canal_a_trabajo		;b373   ; al canal de trabajo
	ld bc,00209h		;b376   ; el canal B: registros 2 y 9
	ld a,(0e03ch)		;b379   ; el mezclador...
	rrca			;b37c   ; ...un bit a la derecha
	ld (0e03ch),a		;b37d
	ld a,001h		;b380   ; el canal 1
	call canal_un_paso		;b382   ; un paso
	push af			;b385
	ld de,0e292h		;b386   ; de vuelta al canal B
	call canal_de_trabajo		;b389
	pop af			;b38c
	cp 003h		;b38d   ; 3: sigue
	jr z,sonido_canal_c		;b38f
	ld b,a			;b391
	ld a,(0e03ch)		;b392   ; los bits de vuelta
	rlca			;b395
	ld (0e03ch),a		;b396
	ld a,b			;b399
	and a			;b39a
	jp nz,sonido_bc_acaba		;b39b   ; acabado
sonido_canal_c:		; El canal C: un paso (registros 4 y 10) y el barrido del ruido
	ld hl,0e2a4h		;b39e   ; el canal C
	call canal_a_trabajo		;b3a1   ; al canal de trabajo
	ld bc,0040ah		;b3a4   ; registros 4 y 10
	ld a,(0e03ch)		;b3a7   ; el mezclador...
	rrca			;b3aa   ; ...dos bits a la derecha
	rrca			;b3ab
	ld (0e03ch),a		;b3ac
	ld a,002h		;b3af   ; el canal 2
	call canal_un_paso		;b3b1   ; un paso
	push af			;b3b4
	ld de,0e2a4h		;b3b5   ; de vuelta al canal C
	call canal_de_trabajo		;b3b8
	pop af			;b3bb
	cp 003h		;b3bc   ; 3: sigue
	jp z,ruido_barrido		;b3be   ; el ruido
	ld b,a			;b3c1   ; los bits del mezclador...
	ld a,(0e03ch)		;b3c2   ; ...de vuelta
	rlca			;b3c5
	rlca			;b3c6
	ld (0e03ch),a		;b3c7
	ld a,b			;b3ca   ; acabado?
	and a			;b3cb
	jp nz,sonido_bc_acaba		;b3cc   ; si
	jp ruido_barrido		;b3cf   ; el ruido
canal_a_trabajo:		; Copia el bloque del canal (HL, 18 bytes) a 0xE2C3
	ld de,0e2c3h		;b3d2   ; al canal de trabajo
copia18:
	ld bc,00012h		;b3d5   ; 18 bytes
	ldir		;b3d8   ; copiados
	ret			;b3da
canal_de_trabajo:		; Y de vuelta a DE
	ld hl,0e2c3h		;b3db
	jr copia18		;b3de
canal_paso:		; Un paso del canal de trabajo: si la nota sigue, nada; si no, el byte siguiente de la pieza: una nota (menos de 0xF0) o una orden
	ld hl,0e2cdh		;b3e0   ; la nota sigue?
	ld a,(hl)			;b3e3
	and a			;b3e4
	jr z,canal_byte		;b3e5
	call canal_cuenta		;b3e7   ; su cuenta
	and a			;b3ea
	ret z			;b3eb
canal_byte:		; El byte siguiente de la pieza (0xE2C3): menos de 0xF0, una nota (duracion y volumen, el tono) y 3; si no, una orden
	ld iy,0e2cdh		;b3ec
	ld hl,(0e2c3h)		;b3f0
	ld a,(hl)			;b3f3   ; el byte
	cp 0f0h		;b3f4   ; 0xF0 o mas: una orden
	jr nc,L_B41D		;b3f6
	call nota_pon		;b3f8
	call nota_tono		;b3fb
	ld (0e2c3h),hl		;b3fe   ; apuntado
	ld a,(0e03ch)		;b401   ; el canal con tono, sin ruido
	res 0,a		;b404
	set 3,a		;b406
canal_mezcla:
	ld c,a			;b408   ; guardado
	ld a,(0e2d5h)		;b409   ; corrido al canal
	and a			;b40c
	ld b,a			;b40d
	ld a,c			;b40e
	jr z,canal_mezcla_pon		;b40f
canal_mezcla_corre:
	rlca			;b411
	djnz canal_mezcla_corre		;b412   ; B veces
canal_mezcla_pon:
	ld (0e03ch),a		;b414   ; el registro 7
	call psg_mezcla		;b417   ; al PSG
	ld a,003h		;b41a
	ret			;b41c
L_B41D:
	jp z,canal_ruido		;b41d
	cp 0ffh		;b420   ; 0xFF: el final
	jr nz,canal_orden_f7		;b422
	ld a,001h		;b424   ; 1
	ret			;b426
canal_orden_f7:
	cp 0f7h		;b427   ; 0xF7: callar
	jr nz,canal_orden_fe		;b429
	ld a,002h		;b42b   ; 2
	ret			;b42d
canal_orden_fe:
	cp 0feh		;b42e   ; 0xFE: al principio
	jr nz,canal_orden_fd		;b430
	ld hl,(0e2c5h)		;b432   ; la pieza otra vez desde su principio
	jr canal_orden_sigue		;b435
canal_orden_fd:		; 0xFD n: la marca 1 y cuantas veces
	cp 0fdh		;b437   ; 0xFD n: el primer bucle, n veces
	jr nz,canal_orden_fc		;b439
	inc hl			;b43b   ; cuantas veces...
	ld a,(hl)			;b43c
	ld (iy+005h),a		;b43d   ; ...en +5
	inc hl			;b440
	ld (0e2c7h),hl		;b441   ; la marca 1
	jr canal_orden_sigue		;b444
canal_orden_fc:		; 0xFC: vuelve a la marca 1 si quedan
	cp 0fch		;b446   ; 0xFC: el final del primer bucle
	jr nz,canal_orden_fb		;b448
	dec (iy+005h)		;b44a   ; una vez menos
	jr nz,canal_orden_fc_vuelve		;b44d
	inc hl			;b44f   ; ya: sigue
	jr canal_orden_sigue		;b450
canal_orden_fc_vuelve:
	ld hl,(0e2c7h)		;b452   ; a la marca 1
	jr canal_orden_sigue		;b455
canal_orden_fb:		; 0xFB n: la marca 2
	cp 0fbh		;b457   ; 0xFB n: el segundo bucle
	jr nz,canal_orden_fa		;b459
	inc hl			;b45b   ; cuantas veces...
	ld a,(hl)			;b45c
	ld (iy+006h),a		;b45d   ; ...en +6
	inc hl			;b460
	ld (0e2c9h),hl		;b461   ; la marca 2
canal_orden_sigue:		; Sigue leyendo
	ld (0e2c3h),hl		;b464   ; por donde va
	jr canal_byte		;b467
canal_orden_fa:		; 0xFA: vuelve a la marca 2
	cp 0fah		;b469   ; 0xFA: su final
	jr nz,canal_orden_f9		;b46b
	dec (iy+006h)		;b46d   ; una vez menos
	jr nz,canal_orden_fa_vuelve		;b470
	inc hl			;b472   ; ya: sigue
	jr canal_orden_sigue		;b473
canal_orden_fa_vuelve:
	ld hl,(0e2c9h)		;b475   ; a la marca 2
	jr canal_orden_sigue		;b478
canal_orden_f9:		; 0xF9 n: la marca 3
	cp 0f9h		;b47a   ; 0xF9 n: el tercer bucle
	jr nz,canal_orden_f8		;b47c
	inc hl			;b47e   ; cuantas veces...
	ld a,(hl)			;b47f
	ld (iy+007h),a		;b480   ; ...en +7
	inc hl			;b483
	ld (0e2cbh),hl		;b484   ; la marca 3
	jr canal_orden_sigue		;b487
canal_orden_f8:		; 0xF8 (o mas): vuelve a la marca 3
	dec (iy+007h)		;b489   ; una vez menos
	jr nz,canal_orden_f8_vuelve		;b48c
	inc hl			;b48e   ; ya: sigue
	jr canal_orden_sigue		;b48f
canal_orden_f8_vuelve:
	ld hl,(0e2cbh)		;b491   ; a la marca 3
	jr canal_orden_sigue		;b494
canal_ruido:		; 0xF0: una nota de ruido (el periodo y su barrido) y su duracion; el canal, a ruido en el registro 7
	call ruido_pon		;b496   ; el ruido
	inc hl			;b499
	call nota_pon		;b49a
	inc hl			;b49d
	ld (0e2c3h),hl		;b49e
	ld a,(0e03ch)		;b4a1
	res 3,a		;b4a4
	set 0,a		;b4a6
	jp canal_mezcla		;b4a8
ruido_barrido:		; El barrido del ruido: cada tantos cuadros, el periodo + el paso, unas cuantas veces
	ld a,(0e2b6h)		;b4ab   ; hay ruido?
	and a			;b4ae
	ret z			;b4af
	ld a,(0e2b7h)		;b4b0   ; con barrido?
	and a			;b4b3
	ret z			;b4b4
	ld a,(0e2b9h)		;b4b5   ; quedan pasos?
	and a			;b4b8
	ret z			;b4b9
	ld a,(0e2bbh)		;b4ba   ; la espera...
	dec a			;b4bd   ; ...un cuadro menos
	ld (0e2bbh),a		;b4be
	ret nz			;b4c1
	ld a,(0e2b9h)		;b4c2   ; un paso menos
	dec a			;b4c5
	ld (0e2b9h),a		;b4c6
	ld a,(0e2bah)		;b4c9   ; otra vez la espera
	ld (0e2bbh),a		;b4cc
	ld a,(0e2b8h)		;b4cf   ; el periodo...
	ld b,a			;b4d2
	ld a,(0e2bch)		;b4d3   ; ...mas el paso
	add a,b			;b4d6
	ld (0e2b8h),a		;b4d7
	jp psg_ruido		;b4da   ; al registro 6
canal_un_paso:		; Un paso del canal de trabajo, que es el A (0xE2D5)
	ld (0e2d5h),a		;b4dd   ; el canal
	call canal_paso		;b4e0   ; un paso
	ret			;b4e3
pedido_mira:		; C si lo pedido (HL + 1) va antes (numero menor) que lo que suena (HL)
	ld b,(hl)			;b4e4   ; lo que suena
	inc hl			;b4e5
	ld a,(hl)			;b4e6   ; lo pedido
	and a			;b4e7   ; nada: NC
	ret z			;b4e8
	cp b			;b4e9   ; menor: C
	ret			;b4ea
canal_cuenta:		; La cuenta de la nota: un cuadro menos; acabada, A = 1; con volumen 15 la envolvente corta, si no la que baja el volumen
	inc hl			;b4eb   ; la duracion...
	dec (hl)			;b4ec   ; ...un cuadro menos
	jp z,canal_cuenta_fin		;b4ed   ; acabada
	inc hl			;b4f0
	ld a,(hl)			;b4f1   ; el volumen
	and a			;b4f2   ; sin envolvente
	jp z,canal_cuenta_sigue		;b4f3
	cp 00fh		;b4f6   ; 15: la envolvente corta
	jr z,canal_cuenta_15		;b4f8
	inc hl			;b4fa
	dec (hl)			;b4fb   ; la cuenta de la envolvente
	jr nz,canal_cuenta_sigue		;b4fc
	dec hl			;b4fe
	ld a,(hl)			;b4ff   ; la espera...
	inc hl			;b500
	ld (hl),a			;b501   ; ...otra vez
	inc hl			;b502
	dec (hl)			;b503   ; el volumen, uno menos
	ld a,(hl)			;b504
	call psg_c		;b505   ; al PSG
	and a			;b508
	jr nz,canal_cuenta_sigue		;b509
	dec hl			;b50b   ; volumen 0: sin envolvente
	dec hl			;b50c
	ld (hl),a			;b50d
canal_cuenta_sigue:
	xor a			;b50e
	ret			;b50f
canal_cuenta_15:
	inc hl			;b510
	dec (hl)			;b511   ; la cuenta
	jr nz,canal_cuenta_sigue		;b512
	xor a			;b514
	dec hl			;b515
	ld (hl),a			;b516   ; el volumen a 0
	call psg_c		;b517
	ret			;b51a
canal_cuenta_fin:
	dec hl			;b51b   ; acabada
	xor a			;b51c
	ld (hl),a			;b51d   ; acabada: A = 1
	ld a,001h		;b51e   ; 1
	ret			;b520
ruido_pon:		; El ruido: su periodo fijo o con barrido (periodo, cuantas veces, cada cuanto, el paso)
	ld (iy+000h),a		;b521   ; la nota
	inc hl			;b524
	ld a,(hl)			;b525   ; con barrido?
	ld (0e2b7h),a		;b526   ; con barrido (cuantas veces)?
	and a			;b529
	jr nz,ruido_barre		;b52a
	inc hl			;b52c   ; sin barrido
	ld a,(hl)			;b52d   ; el periodo...
	ld (0e2b8h),a		;b52e
	call psg_ruido		;b531   ; ...registro 6
	xor a			;b534   ; sin barrido
	ld (0e2b9h),a		;b535
	ld (0e2bah),a		;b538
	ld (0e2bbh),a		;b53b
	ld (0e2bch),a		;b53e
	inc a			;b541   ; hay ruido
	ld (0e2b6h),a		;b542
	ret			;b545
ruido_barre:
	ld (0e2b6h),a		;b546   ; hay ruido con barrido
	ld (0e2bch),a		;b549
	inc hl			;b54c
	ld a,(hl)			;b54d   ; el periodo...
	ld (0e2b8h),a		;b54e
	call psg_ruido		;b551   ; ...registro 6
	inc hl			;b554
	ld a,(hl)			;b555   ; cuantas veces...
	ld (0e2b9h),a		;b556
	inc hl			;b559
	ld a,(hl)			;b55a   ; ...cada cuanto
	ld (0e2bah),a		;b55b
	ld (0e2bbh),a		;b55e
	ret			;b561
nota_pon:		; Una nota: la mitad alta del byte es la duracion (la tabla de 0xB5B3, o el byte siguiente con 0xE), la baja el volumen (15: la mitad)
	ld a,(hl)			;b562   ; la nota...
	ld (iy+000h),a		;b563
	and 00fh		;b566   ; ...el volumen (la mitad baja)
	ld (iy+002h),a		;b568
	ld a,(hl)			;b56b   ; la duracion (la mitad alta)...
	and 0f0h		;b56c
	rrca			;b56e
	rrca			;b56f
	rrca			;b570
	rrca			;b571
	cp 00eh		;b572   ; ...0xE: en el byte siguiente
	jr z,nota_duracion_byte		;b574
	ld de,0b5b3h		;b576   ; la tabla de duraciones
	add a,e			;b579   ; + la mitad alta
	jr nc,nota_duracion		;b57a
	inc d			;b57c   ; acarreo
nota_duracion:
	ld e,a			;b57d
	ld a,(de)			;b57e   ; la duracion
	jr nota_volumen		;b57f
nota_duracion_byte:
	inc hl			;b581
	ld a,(hl)			;b582
nota_volumen:
	ld (iy+001h),a		;b583   ; la duracion
	ld a,(iy+002h)		;b586   ; volumen 15?
	cp 00fh		;b589
	jr nz,nota_cuenta		;b58b
	ld a,(iy+001h)		;b58d   ; la duracion...
	push bc			;b590   ; (guardado)
	ld c,a			;b591
	srl a		;b592   ; ...menos la mitad: la espera
	ld b,a			;b594
	ld a,c			;b595
	sub b			;b596
	pop bc			;b597   ; (recuperado)
nota_cuenta:
	ld (iy+003h),a		;b598   ; la cuenta de la envolvente
	ld a,00fh		;b59b   ; el volumen 15
	ld (iy+004h),a		;b59d
	jp psg_c		;b5a0   ; al PSG
nota_tono:		; El tono de la nota: dos bytes (el alto, por debajo de 0x10, al registro B + 1) o uno (al registro B)
	inc hl			;b5a3   ; el byte siguiente
	ld a,(hl)			;b5a4
	cp 010h		;b5a5   ; por debajo de 0x10?
	jr nc,nota_tono_bajo		;b5a7   ; no: un byte
	call psg_b1		;b5a9   ; la parte alta, al registro B + 1
	inc hl			;b5ac
	ld a,(hl)			;b5ad   ; la baja
nota_tono_bajo:
	call psg_b		;b5ae   ; al registro B
	inc hl			;b5b1   ; el siguiente
	ret			;b5b2

; ----------------------------------------------------------------------
; DATOS duraciones: Las 14 duraciones de las notas (la mitad alta del byte de
;   la nota, 0-13)
;   0xb5b3..0xb5c1  (14 bytes)
DATA_duraciones:
	defb 080h,060h,040h,030h,020h,018h,010h,00ch,008h,006h,004h,003h,002h,001h	; b5b3  .`@0 .........

; ======================================================================
; CODIGO 0xb5c1..0xb6bc  (251 bytes)
; ======================================================================


psg_c:		; WRTPSG: el registro C
	ld e,a			;b5c1   ; el valor...
	ld a,c			;b5c2   ; ...el registro C
psg:
	jp 00093h		;b5c3   ; WRTPSG
psg_b:		; El registro B
	ld e,a			;b5c6   ; el registro B
	ld a,b			;b5c7
	jr psg		;b5c8
psg_b1:		; El registro B + 1
	ld e,a			;b5ca   ; el registro B + 1
	ld a,b			;b5cb
	inc a			;b5cc
	jr psg		;b5cd
psg_mezcla:		; El registro 7
	ld e,a			;b5cf   ; el registro 7
	ld a,007h		;b5d0
	jr psg		;b5d2
psg_ruido:		; El registro 6
	ld e,a			;b5d4   ; el registro 6
	ld a,006h		;b5d5
	jr psg		;b5d7
musica_empieza:		; Una musica: los tres canales de la tabla de 0xB280 (6 bytes por musica: la musica N en 0xB280 + 6N), el mezclador con los tres tonos y a sonar
	ld hl,0b280h		;b5d9   ; la tabla de musicas
	ld a,(0e2beh)		;b5dc   ; la pedida...
	ld (0e2bdh),a		;b5df   ; ...suena
	ld b,a			;b5e2   ; x 6
	add a,b			;b5e3
	add a,b			;b5e4
	add a,b			;b5e5
	add a,b			;b5e6
	add a,b			;b5e7
	call canal_a_tabla		;b5e8   ; el canal A
	inc hl			;b5eb   ; los canales B y C
	call canales_bc		;b5ec
	ld (0e28ah),a		;b5ef   ; sin nota en marcha...
	ld (0e2beh),a		;b5f2   ; ...y el pedido gastado
	ld a,0f8h		;b5f5   ; los tres canales con tono, sin ruido
mezclador_pon:		; El mezclador A (0xE03C) al registro 7 y al canal A
	ld (0e03ch),a		;b5f7   ; el mezclador
	call psg_mezcla		;b5fa   ; al PSG
	jp sonido_canal_a		;b5fd   ; a sonar
musica_acaba:		; La musica acabada: otra pedida, o el sonido a cero
	ld a,(0e2beh)		;b600   ; otra pedida?
	and a			;b603
	jr nz,musica_empieza		;b604   ; si: empieza
	ld (0e2bdh),a		;b606   ; ninguna suena
	dec a			;b609   ; 0xFF: todo callado
sonido_cero:		; El mezclador A y los canales (0xE280, 0x43 bytes) a cero
	ld (0e03ch),a		;b60a   ; el mezclador...
	call psg_mezcla		;b60d   ; ...al PSG
	ld hl,0e280h		;b610   ; los canales...
	ld b,043h		;b613   ; ...0x43 bytes
cero_b:		; B bytes de HL a cero
	ld (hl),000h		;b615   ; a cero
	inc hl			;b617
	djnz cero_b		;b618
	ret			;b61a
efecto_a_empieza:		; Un efecto del canal A (0xE2C0): su pieza de la tabla de 0xB2AA (2 bytes por efecto)
	ld hl,0b2aah		;b61b   ; la tabla de los efectos del canal A
	ld a,(0e2c0h)		;b61e   ; el pedido...
	ld (0e2bfh),a		;b621   ; ...suena
	add a,a			;b624   ; x 2
	call canal_a_tabla		;b625   ; su pieza
	xor a			;b628   ; sin nota en marcha
	ld (0e28ah),a		;b629
	ld (0e2c0h),a		;b62c   ; el pedido, gastado
	ld a,(0e03ch)		;b62f   ; el canal A con tono
	res 0,a		;b632
	ld (0e03ch),a		;b634
	call psg_mezcla		;b637   ; al PSG
	ld hl,0e2c0h		;b63a   ; y los de B y C
	jp sonido_efecto_bc		;b63d
sonido_a_acaba:		; El efecto del canal A acabado (0xF7): otro pedido, o el canal A callado
	ld a,(0e2c0h)		;b640   ; otro pedido?
	and a			;b643
	jr nz,efecto_a_empieza		;b644
	ld (0e2bfh),a		;b646   ; ninguno suena
	ld hl,0e280h		;b649   ; el canal A...
	ld b,012h		;b64c   ; ...18 bytes...
	call cero_b		;b64e   ; ...a cero
	ld a,(0e03ch)		;b651
	or 009h		;b654
mezclador_guarda:
	ld (0e03ch),a		;b656   ; apuntado
	jp psg_mezcla		;b659   ; al PSG
efecto_bc_empieza:		; Un efecto de los canales B y C (0xE2C2): sus dos piezas de la tabla de 0xB2C0 (4 bytes por efecto)
	ld hl,0b2c0h		;b65c   ; la tabla de los efectos de B y C
	ld a,(0e2c2h)		;b65f   ; el pedido...
	ld (0e2c1h),a		;b662   ; ...suena
	add a,a			;b665   ; x 4
	add a,a			;b666
	add a,l			;b667
	ld l,a			;b668
	call canales_bc		;b669   ; sus piezas
	ld (0e2c2h),a		;b66c   ; el pedido, gastado
	ld a,(0e03ch)		;b66f   ; el mezclador: B y C con tono
	and 0f9h		;b672
	jp mezclador_pon		;b674   ; al PSG
sonido_bc_acaba:		; El efecto de B y C acabado: otro pedido, o B y C callados
	ld a,(0e2c2h)		;b677   ; otro pedido?
	and a			;b67a
	jr nz,efecto_bc_empieza		;b67b   ; si: empieza
	ld (0e2c1h),a		;b67d   ; ninguno suena
	ld hl,0e292h		;b680   ; los canales B y C...
	ld b,024h		;b683   ; ...36 bytes...
	call cero_b		;b685   ; ...a cero
	ld a,(0e03ch)		;b688   ; el mezclador: B y C callados
	or 036h		;b68b
	jr mezclador_guarda		;b68d
canales_bc:		; Los canales B y C desde la tabla HL
	ld e,(hl)			;b68f   ; la pieza del canal B
	inc hl			;b690
	ld d,(hl)			;b691
	ld (0e292h),de		;b692   ; ...y su principio
	ld (0e294h),de		;b696
	inc hl			;b69a
	ld e,(hl)			;b69b   ; la del canal C
	inc hl			;b69c
	ld d,(hl)			;b69d
	ld (0e2a4h),de		;b69e
	ld (0e2a6h),de		;b6a2
	xor a			;b6a6   ; sin nota en marcha
	ld (0e29ch),a		;b6a7
	ld (0e2aeh),a		;b6aa
	ret			;b6ad
canal_a_tabla:		; El canal A desde la tabla
	add a,l			;b6ae   ; + la musica x 6
	ld l,a			;b6af
	ld e,(hl)			;b6b0   ; el canal A: su pieza...
	inc hl			;b6b1
	ld d,(hl)			;b6b2
	ld (0e280h),de		;b6b3   ; ...y su principio
	ld (0e282h),de		;b6b7
	ret			;b6bb

; ----------------------------------------------------------------------
; DATOS piezas: Las piezas de las musicas y los efectos (los punteros de
;   0xB280-0xB2DF): notas, ruidos y ordenes 0xF0-0xFF
;   0xb6bc..0xc000  (2372 bytes)
DATA_piezas:
	defb 01ch,000h,000h,0f7h,01ch,000h,000h,0ffh,026h,000h,050h,0ffh,026h,000h,040h,0ffh	; b6bc  ........&.P.&.@.
	defb 081h,000h,000h,026h,020h,0ffh,0fdh,008h,065h,002h,0fah,082h,05dh,081h,000h,000h	; b6cc  ...& ...e...]...
	defb 082h,002h,081h,081h,000h,000h,082h,002h,05dh,081h,000h,000h,0fch,0fdh,002h,065h	; b6dc  ........]......e
	defb 002h,03bh,082h,001h,0c5h,081h,000h,000h,082h,001h,0e0h,081h,000h,000h,082h,001h	; b6ec  .;..............
	defb 0c5h,081h,000h,000h,0fch,0fdh,002h,065h,002h,03bh,082h,001h,07dh,081h,000h,000h	; b6fc  .......e.;..}...
	defb 082h,001h,0c5h,081h,000h,000h,082h,001h,07dh,081h,000h,000h,0fch,0fdh,003h,065h	; b70c  ........}......e
	defb 002h,0fah,082h,05dh,081h,000h,000h,082h,002h,081h,081h,000h,000h,082h,002h,05dh	; b71c  ...]...........]
	defb 081h,000h,000h,0fch,082h,002h,0fah,081h,000h,000h,082h,002h,0fah,081h,000h,000h	; b72c  ................
	defb 082h,002h,0a7h,081h,000h,000h,082h,002h,05dh,081h,000h,000h,0fdh,006h,065h,002h	; b73c  ........].....e.
	defb 0a7h,082h,01bh,081h,000h,000h,082h,002h,03bh,081h,000h,000h,082h,002h,01bh,081h	; b74c  ........;.......
	defb 000h,000h,0fch,082h,002h,0a7h,081h,000h,000h,082h,002h,0a7h,081h,000h,000h,082h	; b75c  ................
	defb 002h,05dh,081h,000h,000h,082h,002h,01bh,081h,000h,000h,082h,001h,0fch,081h,000h	; b76c  .]..............
	defb 000h,046h,003h,0f9h,061h,000h,000h,0ffh,056h,000h,0beh,083h,0beh,083h,0beh,081h	; b77c  .F..a...V.......
	defb 000h,000h,083h,0feh,083h,0e2h,083h,0beh,081h,000h,000h,083h,0e2h,081h,000h,000h	; b78c  ................
	defb 083h,0aah,081h,000h,000h,083h,0beh,081h,000h,000h,065h,0a0h,083h,097h,081h,000h	; b79c  ..........e.....
	defb 000h,083h,071h,081h,000h,000h,083h,07fh,081h,000h,000h,048h,097h,083h,0feh,081h	; b7ac  ..q........H....
	defb 000h,000h,083h,0e2h,081h,000h,000h,056h,0beh,083h,0beh,083h,0beh,081h,000h,000h	; b7bc  .......V........
	defb 083h,0feh,083h,0e2h,083h,0beh,081h,000h,000h,083h,0e2h,081h,000h,000h,083h,0aah	; b7cc  ................
	defb 081h,000h,000h,083h,0beh,081h,000h,000h,065h,0a0h,083h,097h,081h,000h,000h,084h	; b7dc  ........e.......
	defb 071h,084h,07fh,084h,071h,084h,07fh,065h,097h,083h,0beh,081h,000h,000h,083h,0aah	; b7ec  q...q..e........
	defb 081h,000h,000h,083h,097h,081h,000h,000h,065h,08fh,083h,097h,081h,000h,000h,083h	; b7fc  ........e.......
	defb 0a0h,081h,000h,000h,083h,097h,081h,000h,000h,065h,08fh,083h,071h,081h,000h,000h	; b80c  .........e..q...
	defb 083h,065h,081h,000h,000h,083h,05fh,081h,000h,000h,065h,055h,083h,05fh,081h,000h	; b81c  .e...._...eU._..
	defb 000h,083h,065h,081h,000h,000h,083h,05fh,081h,000h,000h,065h,055h,083h,05fh,081h	; b82c  ..e...._...eU._.
	defb 000h,000h,083h,065h,081h,000h,000h,083h,0e2h,081h,000h,000h,03ah,07fh,083h,07fh	; b83c  ...e........:...
	defb 083h,071h,065h,07fh,083h,08fh,081h,000h,000h,083h,097h,081h,000h,000h,083h,0aah	; b84c  .qe.............
	defb 081h,000h,000h,065h,097h,083h,08fh,081h,000h,000h,083h,07fh,081h,000h,000h,083h	; b85c  ...e............
	defb 071h,081h,000h,000h,049h,07fh,041h,000h,000h,065h,087h,083h,0aah,081h,000h,000h	; b86c  q...I.A..e......
	defb 083h,0aah,081h,000h,000h,083h,0beh,083h,0aah,081h,000h,000h,065h,087h,083h,07fh	; b87c  ............e...
	defb 083h,087h,081h,000h,000h,083h,0beh,083h,0aah,081h,000h,000h,083h,001h,00dh,083h	; b88c  ................
	defb 000h,0feh,083h,0beh,083h,0aah,083h,087h,083h,07fh,083h,071h,081h,000h,000h,083h	; b89c  ...........q....
	defb 05fh,081h,000h,000h,083h,071h,083h,07fh,083h,087h,083h,0aah,083h,0beh,083h,087h	; b8ac  _....q..........
	defb 083h,07fh,083h,071h,081h,000h,000h,083h,071h,081h,000h,000h,083h,055h,081h,000h	; b8bc  ...q....q....U..
	defb 000h,065h,05fh,083h,065h,081h,000h,000h,083h,071h,081h,000h,000h,083h,065h,081h	; b8cc  .e_.e....q....e.
	defb 000h,000h,065h,0aah,083h,0e2h,081h,000h,000h,065h,087h,083h,0aah,081h,000h,000h	; b8dc  ..e......e......
	defb 065h,065h,083h,07fh,081h,000h,000h,065h,047h,083h,055h,081h,000h,000h,0ffh,0fdh	; b8ec  ee.....eG.U.....
	defb 004h,0f0h,000h,004h,081h,0f0h,000h,004h,081h,0f0h,000h,004h,081h,0f0h,000h,004h	; b8fc  ................
	defb 081h,0f0h,000h,004h,081h,081h,000h,000h,0f0h,000h,004h,081h,051h,000h,000h,0f0h	; b90c  ............Q...
	defb 000h,004h,081h,081h,000h,000h,0f0h,000h,004h,081h,0f0h,000h,004h,081h,0f0h,000h	; b91c  ................
	defb 004h,081h,0f0h,000h,004h,081h,0fch,082h,001h,01dh,082h,01dh,082h,01dh,082h,01dh	; b92c  ................
	defb 082h,01dh,081h,000h,000h,082h,001h,01dh,081h,000h,000h,065h,001h,01dh,082h,000h	; b93c  ...........e....
	defb 0e2h,081h,000h,000h,082h,0f0h,082h,0e2h,082h,0f0h,082h,0e2h,082h,001h,01dh,082h	; b94c  ................
	defb 01dh,082h,01dh,082h,01dh,082h,01dh,081h,000h,000h,082h,001h,01dh,081h,000h,000h	; b95c  ................
	defb 065h,001h,01dh,082h,000h,0beh,081h,000h,000h,082h,0e2h,082h,0beh,082h,0e2h,082h	; b96c  e...............
	defb 0beh,03ah,097h,083h,097h,083h,08fh,065h,097h,083h,0aah,081h,000h,000h,083h,0beh	; b97c  .:.....e........
	defb 081h,000h,000h,083h,0cah,081h,000h,000h,065h,0beh,083h,0aah,081h,000h,000h,083h	; b98c  ........e.......
	defb 097h,081h,000h,000h,083h,08fh,081h,000h,000h,049h,097h,041h,000h,000h,0fdh,003h	; b99c  .........I.A....
	defb 0f0h,000h,004h,081h,0f0h,000h,004h,081h,0f0h,000h,004h,081h,0f0h,000h,004h,081h	; b9ac  ................
	defb 0f0h,000h,004h,081h,081h,000h,000h,0f0h,000h,004h,081h,051h,000h,000h,0f0h,000h	; b9bc  ...........Q....
	defb 004h,081h,081h,000h,000h,0f0h,000h,004h,081h,0f0h,000h,004h,081h,0f0h,000h,004h	; b9cc  ................
	defb 081h,0f0h,000h,004h,081h,0fch,065h,001h,053h,082h,07dh,081h,000h,000h,082h,001h	; b9dc  ......e.S.}.....
	defb 094h,081h,000h,000h,082h,001h,07dh,081h,000h,000h,065h,001h,094h,082h,0fch,081h	; b9ec  ......}...e.....
	defb 000h,000h,082h,001h,0c5h,081h,000h,000h,082h,001h,094h,081h,000h,000h,0ffh,082h	; b9fc  ................
	defb 002h,05dh,081h,000h,000h,082h,002h,0fah,081h,000h,000h,082h,002h,05dh,081h,000h	; ba0c  .]...........]..
	defb 000h,082h,002h,0fah,081h,000h,000h,082h,002h,03bh,081h,000h,000h,082h,002h,0fah	; ba1c  .........;......
	defb 081h,000h,000h,082h,002h,01bh,081h,000h,000h,082h,002h,0fah,081h,000h,000h,082h	; ba2c  ................
	defb 003h,0f9h,081h,000h,000h,082h,003h,0f9h,081h,000h,000h,082h,003h,027h,081h,000h	; ba3c  .............'..
	defb 000h,082h,003h,027h,081h,000h,000h,082h,002h,0fah,051h,000h,000h,082h,002h,0fah	; ba4c  ...'......Q.....
	defb 051h,000h,000h,0ffh,058h,001h,02eh,082h,07dh,058h,02eh,082h,07dh,082h,01dh,081h	; ba5c  Q...X...}X..}...
	defb 000h,000h,082h,001h,01dh,081h,000h,000h,082h,001h,00dh,081h,000h,000h,082h,001h	; ba6c  ................
	defb 00dh,081h,000h,000h,082h,0feh,081h,000h,000h,082h,0feh,081h,000h,000h,082h,001h	; ba7c  ................
	defb 01dh,081h,000h,000h,082h,001h,01dh,081h,000h,000h,082h,001h,02eh,051h,000h,000h	; ba8c  .............Q..
	defb 082h,001h,02eh,051h,000h,000h,0ffh,058h,000h,05fh,083h,07fh,058h,05fh,083h,07fh	; ba9c  ...Q...X._..X_..
	defb 083h,071h,081h,000h,000h,0a3h,071h,0a3h,071h,0a3h,05fh,0a3h,071h,083h,07fh,081h	; baac  .q....q.q._.q...
	defb 000h,000h,083h,08fh,081h,000h,000h,083h,097h,081h,000h,000h,0a3h,097h,0a3h,097h	; babc  ................
	defb 0a3h,08fh,0a3h,097h,083h,0aah,081h,000h,000h,0a3h,0aah,0a3h,0aah,0a3h,097h,0a3h	; bacc  ................
	defb 0aah,083h,0beh,051h,000h,000h,083h,0beh,051h,000h,000h,0ffh,0fdh,003h,082h,002h	; badc  ...Q....Q.......
	defb 0fah,081h,000h,000h,082h,002h,05dh,082h,05dh,081h,000h,000h,082h,002h,05dh,082h	; baec  ......].].....].
	defb 0fah,081h,000h,000h,082h,003h,0f9h,082h,08ah,081h,000h,000h,082h,003h,027h,0fch	; bafc  ..............'.
	defb 082h,002h,0fah,061h,000h,000h,082h,002h,0fah,061h,000h,000h,048h,002h,0fah,0ffh	; bb0c  ...a.....a..H...
	defb 0fdh,003h,082h,000h,0feh,081h,000h,000h,082h,0d6h,082h,0feh,081h,000h,000h,082h	; bb1c  ................
	defb 0d6h,082h,0feh,082h,0feh,082h,0feh,082h,0d6h,081h,000h,000h,082h,0feh,0fch,082h	; bb2c  ................
	defb 000h,0d6h,061h,000h,000h,082h,0feh,061h,000h,000h,048h,0feh,0ffh,0fdh,003h,0a3h	; bb3c  ..a....a..H.....
	defb 000h,050h,0a3h,04ch,0a3h,050h,0a3h,04ch,0a3h,050h,0a1h,000h,000h,061h,000h,000h	; bb4c  .P.L.P.L.P...a..
	defb 083h,05fh,056h,07fh,065h,06bh,083h,05fh,0fch,082h,000h,04ch,061h,000h,000h,082h	; bb5c  ._V.ek._...La...
	defb 06bh,061h,000h,000h,048h,06bh,0ffh,0fdh,002h,082h,002h,0fah,082h,0fah,082h,0fah	; bb6c  ka..Hk..........
	defb 082h,0fah,081h,000h,000h,082h,002h,0fah,081h,000h,000h,082h,002h,0fah,0fch,0fdh	; bb7c  ................
	defb 002h,082h,002h,03bh,082h,03bh,082h,03bh,082h,03bh,081h,000h,000h,082h,002h,03bh	; bb8c  ...;.;.;.;.....;
	defb 081h,000h,000h,082h,002h,03bh,0fch,0fdh,002h,082h,001h,0fch,082h,0fch,082h,0fch	; bb9c  .....;..........
	defb 082h,0fch,081h,000h,000h,082h,001h,0fch,081h,000h,000h,082h,001h,0fch,0fch,082h	; bbac  ................
	defb 002h,0fah,082h,0fah,081h,000h,000h,082h,002h,0fah,081h,000h,000h,082h,002h,0fah	; bbbc  ................
	defb 081h,000h,000h,082h,002h,0fah,083h,0fah,0ffh,0fdh,004h,082h,000h,0feh,082h,001h	; bbcc  ................
	defb 02eh,082h,000h,0feh,082h,0beh,0fch,0fdh,004h,082h,001h,01dh,082h,07dh,082h,01dh	; bbdc  .............}..
	defb 082h,000h,0e2h,0fch,0fdh,004h,082h,000h,0feh,082h,001h,053h,082h,000h,0feh,082h	; bbec  ...........S....
	defb 0cah,0fch,0fdh,002h,082h,000h,0beh,082h,0feh,082h,001h,01dh,082h,07dh,0fch,083h	; bbfc  .............}..
	defb 000h,097h,0ffh,0fdh,002h,083h,000h,05fh,083h,065h,083h,071h,083h,07fh,081h,000h	; bc0c  ......._.e.q....
	defb 000h,065h,08fh,083h,097h,0fch,0fdh,002h,083h,000h,071h,083h,07fh,083h,08fh,083h	; bc1c  .e........q.....
	defb 097h,081h,000h,000h,065h,08fh,083h,07fh,0fch,083h,000h,07fh,083h,0cah,083h,0aah	; bc2c  ....e...........
	defb 083h,07fh,081h,000h,000h,083h,08fh,083h,07fh,083h,065h,083h,08fh,083h,07fh,083h	; bc3c  ..........e.....
	defb 065h,083h,07fh,081h,000h,000h,083h,065h,083h,05fh,083h,055h,083h,05fh,083h,065h	; bc4c  e......e._.U._.e
	defb 083h,071h,083h,07fh,081h,000h,000h,065h,071h,083h,065h,083h,05fh,0ffh,0fdh,003h	; bc5c  .q.....eq.e._...
	defb 0fbh,003h,065h,002h,0fah,082h,05dh,081h,000h,000h,065h,003h,0f9h,082h,027h,081h	; bc6c  ..e...]...e...'.
	defb 000h,000h,0fah,065h,002h,0fah,082h,003h,0f9h,081h,000h,000h,082h,003h,0f9h,081h	; bc7c  ...e............
	defb 000h,000h,082h,003h,0f9h,081h,000h,000h,0fch,0fdh,004h,065h,003h,057h,082h,002h	; bc8c  ...........e.W..
	defb 0a7h,081h,000h,000h,082h,002h,03bh,081h,000h,000h,082h,001h,0ach,081h,000h,000h	; bc9c  ......;.........
	defb 0fch,0fdh,003h,065h,002h,0fah,082h,05dh,081h,000h,000h,065h,003h,0f9h,082h,027h	; bcac  ...e...]...e...'
	defb 081h,000h,000h,0fch,065h,002h,0fah,082h,003h,027h,081h,000h,000h,082h,003h,08ah	; bcbc  ....e....'......
	defb 081h,000h,000h,082h,003h,0f9h,081h,000h,000h,0fdh,004h,065h,004h,075h,082h,002h	; bccc  ...........e.u..
	defb 03bh,081h,000h,000h,0fch,0fdh,002h,065h,002h,0fah,082h,05dh,081h,000h,000h,065h	; bcdc  ;......e...]...e
	defb 003h,0f9h,082h,027h,081h,000h,000h,0fch,0fdh,004h,065h,004h,075h,082h,002h,03bh	; bcec  ...'......e.u..;
	defb 081h,000h,000h,0fch,068h,001h,0fch,068h,094h,068h,053h,068h,01dh,049h,000h,0feh	; bcfc  ....h..h.hSh.I..
	defb 045h,003h,0f9h,0feh,001h,000h,000h,001h,000h,000h,0fdh,002h,066h,000h,0beh,041h	; bd0c  E...........f..A
	defb 000h,000h,083h,0beh,083h,0aah,065h,097h,083h,0aah,081h,000h,000h,083h,0beh,081h	; bd1c  ......e.........
	defb 000h,000h,083h,0e2h,081h,000h,000h,039h,0feh,083h,0e2h,081h,000h,000h,039h,0feh	; bd2c  .......9......9.
	defb 061h,000h,000h,0fch,082h,001h,01dh,082h,000h,08fh,082h,06bh,081h,000h,000h,082h	; bd3c  a..........k....
	defb 08fh,081h,000h,000h,082h,0aah,081h,000h,000h,081h,000h,000h,082h,055h,082h,05fh	; bd4c  .............U._
	defb 082h,06bh,082h,071h,082h,07fh,082h,08fh,082h,0a0h,082h,08fh,082h,07fh,082h,08fh	; bd5c  .k.q............
	defb 082h,07fh,082h,08fh,081h,000h,000h,082h,06bh,081h,000h,000h,065h,071h,082h,07fh	; bd6c  ........k...eq..
	defb 081h,000h,000h,082h,08fh,081h,000h,000h,082h,07fh,081h,000h,000h,056h,097h,083h	; bd7c  .............V..
	defb 08fh,083h,07fh,081h,000h,000h,083h,08fh,081h,000h,000h,065h,097h,083h,0beh,081h	; bd8c  ...........e....
	defb 000h,000h,083h,0aah,081h,000h,000h,083h,097h,081h,000h,000h,065h,08fh,083h,07fh	; bd9c  ............e...
	defb 081h,000h,000h,083h,071h,081h,000h,000h,083h,065h,081h,000h,000h,03bh,05fh,061h	; bdac  ....q....e...;_a
	defb 000h,000h,061h,000h,000h,083h,0e2h,083h,0beh,065h,0aah,065h,0beh,083h,0a0h,081h	; bdbc  ..a......e.e....
	defb 000h,000h,083h,0a0h,083h,0aah,083h,0beh,081h,000h,000h,083h,0e2h,081h,000h,000h	; bdcc  ................
	defb 056h,0feh,083h,001h,01dh,083h,02eh,081h,000h,000h,083h,001h,053h,081h,000h,000h	; bddc  V...........S...
	defb 065h,001h,02eh,083h,01dh,081h,000h,000h,046h,0feh,061h,000h,000h,083h,0e2h,083h	; bdec  e.......F.a.....
	defb 0beh,065h,0aah,065h,0beh,083h,0a0h,081h,000h,000h,083h,0a0h,083h,0aah,083h,0beh	; bdfc  .e.e............
	defb 081h,000h,000h,083h,0aah,081h,000h,000h,05ah,07fh,085h,0aah,05ah,07fh,085h,0aah	; be0c  ........Z...Z...
	defb 085h,07fh,085h,0aah,085h,0cah,085h,0aah,049h,07fh,0feh,0fdh,002h,0fbh,003h,082h	; be1c  ........I.......
	defb 002h,0fah,081h,000h,000h,082h,003h,057h,082h,057h,0fah,082h,002h,0fah,082h,003h	; be2c  .......W.W......
	defb 0f9h,082h,057h,082h,0f9h,0fch,0fdh,004h,082h,002h,03bh,081h,000h,000h,082h,002h	; be3c  ..W.......;.....
	defb 03bh,082h,03bh,0fch,0fdh,004h,082h,001h,0fch,081h,000h,000h,082h,001h,0fch,082h	; be4c  ;.;.............
	defb 0fch,0fch,0feh,083h,000h,0beh,081h,000h,000h,083h,0beh,083h,0d6h,083h,0beh,081h	; be5c  ................
	defb 000h,000h,083h,0a0h,083h,08fh,083h,07fh,081h,000h,000h,083h,08fh,081h,000h,000h	; be6c  ................
	defb 083h,0a0h,083h,08fh,083h,0a0h,083h,0beh,083h,0d6h,083h,0beh,083h,0a0h,083h,08fh	; be7c  ................
	defb 083h,07fh,081h,000h,000h,083h,06bh,083h,07fh,065h,05fh,083h,06bh,083h,07fh,083h	; be8c  ......k..e_.k...
	defb 06bh,083h,07fh,083h,08fh,083h,07fh,056h,08fh,083h,08fh,065h,08fh,083h,0a0h,083h	; be9c  k......V...e....
	defb 08fh,065h,0a0h,083h,0beh,081h,000h,000h,085h,08fh,085h,087h,085h,08fh,085h,087h	; beac  .e..............
	defb 065h,07fh,083h,0aah,081h,000h,000h,083h,0cah,083h,0beh,083h,0aah,083h,08fh,083h	; bebc  e...............
	defb 07fh,081h,000h,000h,083h,08fh,081h,000h,000h,065h,07fh,065h,0aah,0feh,0f0h,000h	; becc  .........e.e....
	defb 002h,0d1h,0d1h,004h,035h,0f0h,000h,003h,0d1h,0d1h,004h,079h,0f0h,000h,002h,0d1h	; bedc  ....5......y....
	defb 0d1h,004h,031h,0fdh,006h,082h,002h,0fah,081h,000h,000h,082h,001h,0fch,082h,0fch	; beec  ..1.............
	defb 0fch,082h,002h,0fah,081h,000h,000h,082h,003h,057h,081h,000h,000h,083h,002h,0fah	; befc  .........W......
	defb 0ffh,091h,000h,000h,083h,0feh,083h,0d6h,083h,0cah,083h,0beh,083h,0d6h,081h,000h	; bf0c  ................
	defb 000h,083h,0feh,081h,000h,000h,056h,001h,01dh,083h,000h,0feh,083h,001h,01dh,081h	; bf1c  ......V.........
	defb 000h,000h,083h,001h,040h,081h,000h,000h,056h,001h,07dh,083h,040h,083h,07dh,081h	; bf2c  ....@...V.}.@.}.
	defb 000h,000h,083h,001h,0ach,081h,000h,000h,083h,001h,07dh,051h,000h,000h,083h,001h	; bf3c  ..........}Q....
	defb 07dh,0ffh,0d1h,001h,040h,0d1h,080h,0d1h,0c0h,0d1h,000h,080h,0d1h,0a0h,0d1h,0c0h	; bf4c  }...@...........
	defb 0d1h,001h,010h,0f7h,08fh,0d1h,082h,0d1h,089h,0d1h,07fh,0d1h,085h,0f7h,0f0h,008h	; bf5c  ................
	defb 008h,008h,001h,0a1h,0d1h,000h,060h,0d1h,080h,0d1h,0c0h,0d1h,050h,0d1h,0f0h,0f7h	; bf6c  ......`.....P...
	defb 0f0h,0ffh,01fh,004h,001h,0a1h,0d1h,002h,0c0h,0d1h,002h,030h,0d1h,0c0h,0d1h,001h	; bf7c  ...........0....
	defb 080h,0d1h,002h,080h,0d1h,003h,0c0h,0d1h,001h,0c0h,0d1h,0f0h,0f7h,003h,0f7h,0d1h	; bf8c  ................
	defb 002h,0e0h,0d1h,0fch,0d1h,0c5h,0d1h,000h,040h,0d1h,001h,040h,0d1h,000h,060h,0d1h	; bf9c  ........@..@..`.
	defb 0f0h,0d1h,002h,0f0h,0f7h,003h,0f7h,0d1h,000h,067h,0d1h,05fh,0d1h,062h,0d1h,050h	; bfac  .........g._.b.P
	defb 0d1h,046h,0d1h,049h,0d1h,04ch,0d1h,03ch,0d1h,032h,0d1h,06bh,0d1h,05fh,0d1h,055h	; bfbc  .F.I.L.<.2.k._.U
	defb 0d1h,047h,0f7h,0d1h,000h,0beh,0d1h,0aeh,0d1h,09eh,0d1h,08eh,0d1h,0b6h,083h,0c6h	; bfcc  .G..............
	defb 0f7h,0fdh,002h,0d1h,001h,030h,0d1h,0f0h,0f0h,000h,018h,0c1h,0f0h,000h,014h,0c1h	; bfdc  .....0..........
	defb 0d1h,001h,064h,0d1h,0a0h,0fch,0f7h,000h,0fbh,000h,0fbh,000h,0ffh,000h,0f3h,000h	; bfec  ..d.............
	defb 0fbh,000h,0fbh,000h	; bffc
