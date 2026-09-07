#!/opt/homebrew/bin/tclsh


while {[gets stdin n] >= 0} {
    set sf 1
    for {set i 1} {$i <= $n} {incr i} {
        set sf [expr $i * $sf + 1 - 2 * ($i % 2)]
    }
    puts $sf
}
