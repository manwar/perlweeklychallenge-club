#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    set chars [dict create]
    for {set i 0} {$i < [string length $line]} {incr i} {
        set ch [string index $line $i]
        if {"a" <= $ch && $ch <= "z"} {
            dict incr chars $ch
        }
    }
    set max_c 0
    set max_v 0
    dict for {ch count} $chars {
        if {[regexp {[aeiou]} $ch]} {
            if {$max_v < $count} {set max_v $count}
        } else {
            if {$max_c < $count} {set max_c $count}
        }
    }

    puts [expr $max_c + $max_v]
}
