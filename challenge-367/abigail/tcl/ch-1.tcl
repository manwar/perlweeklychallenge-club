#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    set count_0 0
    set count_1 0
    for {set i 0} {$i < [string length $line]} {incr i} {
        set ch [string index $line $i]
        if {$ch == "0"} {incr count_0}
        if {$ch == "1"} {incr count_1}
    }
    for {set i 1} {$i < $count_1} {incr i} {
        puts -nonewline 1
    }
    for {set i 0} {$i < $count_0} {incr i} {
        puts -nonewline 0
    }
    puts 1
}
