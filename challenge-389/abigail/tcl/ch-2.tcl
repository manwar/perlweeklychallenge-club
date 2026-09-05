#!/opt/homebrew/bin/tclsh

while {[gets stdin numbers] >= 0} {
    set pat {}
    for {set index 1} {$index < [llength $numbers]} {incr index} {
        set left  [lindex $numbers [expr $index - 1]]
        set right [lindex $numbers [expr $index]]
        if {$left <  $right} {set pat "${pat}0"}
        if {$left == $right} {set pat "${pat}1"}
        if {$left >  $right} {set pat "${pat}2"}
    }
    set max 1
    foreach match [regexp -all -inline {0?(?:20)*2?} $pat] {
        if {[string length $match] >= $max} {
            set max [expr 1 + [string length $match]]
        }
    }
    puts $max

}
