# GRABACION FORZADA, para ver las cinco escenas, sus jefes y el final: CAPS en el titulo (vidas sin fin); la barra del
# protagonista llena a mano (0xE1B5 = 0x40) cada 20 cuadros; el rio acortado: a los 900 cuadros de rio (contados desde que el mapa esta al principio), el mapa al
# final (0xE190 = 0x7E); el jefe con la barra casi vacia (0xE1B7 = 4) a los 900 cuadros de tierra. Juega el piloto.
# Hasta 600 cuadros despues de la segunda vuelta (0xE004 = 1) o 40000.
source [file join [file dirname [info script]] piloto.tcl]
proc pon {a v} { debug write memory $a $v }
proc toca {fila bit} {
    keymatrixdown $fila $bit
    after time 0.08 "keymatrixup $fila $bit"
}
set ::parte -1
set ::desde 0
proc guion {n} {
    if {$n < 340} { keymatrixdown 6 0x08 } elseif {$n == 340} { keymatrixup 6 0x08 }
    if {$n == 400} { toca 8 0x01 }
    if {[m 0xE000] != 1} { return [expr {$n >= 40000}] }
    set p [m 0xE051]
    if {$p != $::parte} { set ::parte $p; set ::desde $n }
    if {$n % 20 == 0} { pon 0xE1B5 0x40 }
    if {$p == 0 && [m 0xE190] == 0} { set ::desde $n }
    if {$p == 0 && $n - $::desde == 900} { pon 0xE190 0x7E }
    if {$p == 2 && $n - $::desde == 900 && [m 0xE1B7] > 4} { pon 0xE1B7 4 }
    piloto $n
    if {[m 0xE004] == 1} {
        if {![info exists ::fin]} { set ::fin $n }
        return [expr {$n >= $::fin + 600}]
    }
    return [expr {$n >= 40000}]
}
