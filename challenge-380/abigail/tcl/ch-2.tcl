#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    set sum 0
    for {set i 0} {$i < [string length $line]} {incr i} {
        set ch [string index $line $i]
        if {"a" <= $ch && $ch <= "z"} {
            set sum [expr $sum + ($i + 1) * ([scan z %c] - [scan $ch %c] + 1)]
        }
    }
    puts $sum
}
