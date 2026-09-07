#!/opt/homebrew/bin/tclsh

while {[gets stdin parts] >= 0} {
    set nr_of_notes [expr [llength $parts] / 2]
    set notes [lrepeat $nr_of_notes {}]
    for {set i 1} {$i <= $nr_of_notes} {incr i} {
        lset notes [expr [lindex $parts [expr $i + $nr_of_notes]] - 1] \
                   [lindex $parts $i]
    }
    puts [string cat [string toupper [lindex $parts 0]] " => " $notes]
}
