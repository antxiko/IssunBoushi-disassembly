# UNA PARTIDA con el piloto (piloto.tcl), nada forzado: la barra en el 400; jugando (0xE000 = 1; al encender la RAM
# trae 0xF0), el piloto. Hasta
# GAME OVER + 300 o 20000 cuadros.
source [file join [file dirname [info script]] piloto.tcl]
proc toca {fila bit} {
    keymatrixdown $fila $bit
    after time 0.08 "keymatrixup $fila $bit"
}
proc guion {n} {
    if {[m 0xE000] != 1} {
        keymatrixup 8 0xF1
        keymatrixup 6 0x04
        if {$n == 400} { toca 8 0x01 }
        if {[info exists ::empezada]} {
            if {![info exists ::fin_partida]} { set ::fin_partida $n; }
            return [expr {$n >= $::fin_partida + 300}]
        }
        return [expr {$n >= 20000}]
    }
    set ::empezada 1
    piloto $n
    return [expr {$n >= 20000}]
}
