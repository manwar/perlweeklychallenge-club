#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    set words  [split $line " "]
    set target [lindex $words 0]
    set valid   0
    for {set i 1} {$i < [llength $words]} {incr i} {
        set prefix [lindex $words $i]
        if {[regexp "^$prefix" $target]} {incr valid}
        if {$prefix == "\"\""}           {incr valid}
    }
    puts $valid
}
