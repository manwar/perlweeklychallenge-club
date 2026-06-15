#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    set max -1
    set sec -1
    set chars [regexp -all -inline {[0-9]} $line]
    for {set i 0} {$i < [llength $chars]} {incr i} {
        set ch [lindex $chars $i]
        if {$max < $ch} {
            set sec $max
            set max $ch
        } elseif {$max > $ch && $ch > $sec} {
            set sec $ch
        }
    }
    puts $sec
}
