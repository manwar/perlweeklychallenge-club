#!/opt/homebrew/bin/tclsh

while {[gets stdin numbers] >= 0} {
    set numbers [lsort -integer $numbers]
    set sum 0
    for {set i 0} {$i < [llength $numbers]} {incr i} {
        incr sum [lindex $numbers $i]
    }
    set res 1
    if {$sum > 0} {
        incr res [expr $sum / [llength $numbers]]
    }
    for {set i 0} {$i < [llength $numbers]} {incr i} {
        set num [lindex $numbers $i]
        if {$num == $res} {
            incr res
        }
        if {$num >  $res} {
            break
        }
    }
    puts $res
}
