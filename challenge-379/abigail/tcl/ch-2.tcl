#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    set base  [lindex $line 0]
    set limit [lindex $line 1]
    for {set n 0} {$n <= $limit} {incr n} {
        set size 0
        for {set n_c $n} {$n_c > 0} {set n_c [expr $n_c / $base]} {
            incr size
        }
        set sum 0
        for {set n_c $n} {$n_c > 0} {set n_c [expr $n_c / $base]} {
            incr sum [expr ($n_c % $base) ** $size]
        }
        if {$sum == $n} {
            puts -nonewline "$sum "
        }
    }
    puts ""
}
