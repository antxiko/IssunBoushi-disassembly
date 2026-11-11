# Para mirar el juego: 2500 cuadros sin tocar (la demostracion), luego la barra y a jugar a ciegas: derecha, y la
# barra y GRAPH cada poco. Hasta el 7000.
proc toca {fila bit} {
    keymatrixdown $fila $bit
    after time 0.08 "keymatrixup $fila $bit"
}
proc guion {n} {
    if {$n == 2500} { toca 8 0x01 }
    if {$n > 2700} {
        set f [expr {($n / 300) % 2}]
        if {$f == 0} { keymatrixup 8 0x10; keymatrixdown 8 0x80 } else { keymatrixup 8 0x80; keymatrixdown 8 0x10 }
        if {$n % 40 == 0} { toca 8 0x01 }
        if {$n % 90 == 0} { toca 6 0x04 }
    }
    return [expr {$n >= 7000}]
}
