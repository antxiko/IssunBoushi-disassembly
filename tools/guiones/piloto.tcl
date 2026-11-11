# piloto.tcl - un jugador sencillo para Issun-boushi (con el arma fuera no se mueve). En el rio: la barra (el arma)
# 2 cuadros de cada 30, salvo si la corriente lo ha llevado pasado de X 0xA0; GRAPH (el
# salto) si un tronco (tipo 7) esta de 6 a 22 pixeles a su izquierda y a menos de 22 en Y; a la izquierda si la corriente lo lleva pasado de
# X 0x90; arriba o abajo hacia una calle que cambia cada 200 cuadros. En tierra: se pone donde el arma le da al jefe
# (0xE501): 19 pixeles a su derecha o 15 a su izquierda,
# mirandolo (0xE32D); la barra 2 cuadros de cada 24, GRAPH cada 70 cuadros y, si tiene (0xE054), arriba cada 400.
proc m {a} { return [debug read memory $a] }
set ::calle 0x70
proc tecla_si {fila bit si} { if {$si} { keymatrixdown $fila $bit } else { keymatrixup $fila $bit } }
proc piloto {n} {
    set y [m 0xE320]; set x [m 0xE321]
    if {[m 0xE051] == 2} {
        tecla_si 8 0x01 [expr {$n % 24 < 2}]
        set jx [m 0xE501]
        set mira [m 0xE32D]
        if {$x >= $jx} {
            set obj [expr {$jx + 19}]
            tecla_si 8 0x10 [expr {$x > $obj + 4 || $mira != 0}]
            tecla_si 8 0x80 [expr {$x < $obj - 4 && $mira == 0}]
        } else {
            set obj [expr {$jx - 15}]
            tecla_si 8 0x10 [expr {$x > $obj + 4 && $mira != 0}]
            tecla_si 8 0x80 [expr {$x < $obj - 4 || $mira == 0}]
        }
        tecla_si 6 0x04 [expr {$n % 70 < 2}]
        tecla_si 8 0x20 [expr {[m 0xE054] > 0 && $n % 400 < 2}]
        keymatrixup 8 0x40
        return
    }
    set salta 0
    for {set i 0} {$i < 16} {incr i} {
        set b [expr {0xE380 + 16 * $i}]
        if {[m [expr {$b + 4}]] == 7} {
            set ex [m [expr {$b + 1}]]; set ey [m $b]
            if {$ex >= $x - 22 && $ex < $x - 6 && abs($ey - $y) < 22} { set salta 1 }
        }
    }
    tecla_si 6 0x04 [expr {$salta && [m 0xE326] == 0}]
    tecla_si 8 0x01 [expr {$n % 30 < 2 && $x < 0xA0}]
    if {$n % 200 == 0} { if {$::calle == 0x70} { set ::calle 0x88 } else { set ::calle 0x70 } }
    tecla_si 8 0x10 [expr {$x > 0x90}]
    keymatrixup 8 0x80
    tecla_si 8 0x20 [expr {$y > $::calle + 2}]
    tecla_si 8 0x40 [expr {$y < $::calle - 2}]
}
