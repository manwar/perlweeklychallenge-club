#!/opt/homebrew/bin/tclsh

while {[gets stdin numbers] >= 0} {
    set min   0
    set max   0
    set min_c 0
    set max_c 0
    for {set i 0} {$i < [llength $numbers]} {incr i} {
        set number [lindex $numbers $i]
        if {$min_c == 0 || $number < $min} {set min_c 0; set min $number}
        if {$max_c == 0 || $number > $max} {set max_c 0; set max $number}
        if {$min == $number} {incr min_c}
        if {$max == $number} {incr max_c}
    }
    if {$min == $max} {set max_c 0}
    puts [expr [llength $numbers] - $min_c - $max_c]
}
