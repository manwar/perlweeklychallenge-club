#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    set rev {}
    for {set i 0} {$i < [string length $line]} {incr i} {
        set rev [string index $line $i]$rev
    }
    puts $rev
}
