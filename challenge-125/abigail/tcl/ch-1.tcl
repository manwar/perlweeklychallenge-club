#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl < input-file
#

proc introot {square} {
    return [expr int (.4 + sqrt ($square))]
}



while {[gets stdin n] >= 0} {
    if {$n <= 2} {
        puts "-1"
        continue
    }
    set n_sq [expr $n * $n]
    set c    [expr $n + 1]
    set c_sq [expr $n_sq + 2 * $n + 1]

    while {2 * $c - 1 <= $n_sq} {
        set b_sq [expr $c_sq - $n_sq]
        set b    [introot $b_sq]

        if {$b_sq == [expr $b * $b]} {
            puts "$n $b $c"
        }

        set c_sq [expr $c_sq + 2 * $c + 1]
        set c    [expr $c + 1]
    }

    set max_a [expr int ($n / sqrt (2))]
    for {set a 3} {$a <= $max_a} {incr a} {
        set b_sq [expr $n_sq - $a * $a]
        set b    [introot $b_sq]

        if {$b_sq == [expr $b * $b]} {
            puts "$a $b $n"
        }
    }
}
