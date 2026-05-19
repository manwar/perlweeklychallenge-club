#!/opt/homebrew/bin/tclsh

while {[gets stdin line] >= 0} {
    # Array of characters, sans newline
    set chars [split $line {}] 
    # Track maximum distance
    set max   -1

    for {set f 0} {$f < [llength $chars]} {incr f} {
        for {set l [expr [llength $chars] - 1]} {$l > $f} {incr l -1} {
            #
            # For all characters,
            # find the matching character from the end
            #
            if {[lindex $chars $f] == [lindex $chars $l]} {
                #
                # If the distance is larger, remember it
                #
                if {$l - $f - 1 > $max} {
                    set max [expr $l - $f - 1]
                }
                break
            }
        }
    }

    puts $max
}
