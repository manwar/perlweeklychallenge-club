#!/opt/homebrew/bin/tclsh

while {[gets stdin words] >= 0} {
    set count 0
    for {set i 0} {$i < [llength $words] - 1} {incr i} {
        for {set j [expr $i + 1]} {$j < [llength $words]} {incr j} {
            set w1 [lindex $words $i]
            set w2 [lindex $words $j]
            if {[string length $w2] > [string length $w1]} {
                set w1 [lindex $words $j]
                set w2 [lindex $words $i]
            }
            if {[string first $w2 $w1] == 0 &&
                [string last  $w2 $w1] == [string length $w1] -
                                          [string length $w2]} {
                incr count
            }
        }
    }
    puts $count
}
