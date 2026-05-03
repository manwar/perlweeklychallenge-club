#!/opt/homebrew/bin/tclsh

while {[gets stdin numbers] >= 0} {
    #
    # Iterate over all possible mask, except all 0s and all 1s
    #
    for {set mask 1} {$mask < 2 ** [llength $numbers] - 1} {incr mask} {
        set sum 0
        set set {}
        for {set index 0} {$index < [llength $numbers]} {incr index} {
            #
            # If the position of the number matches the mask, add the
            # difference of the number and its position to the sum.
            # Also add the number to the set.
            #
            if {$mask & (1 << $index)} {
                incr sum [expr [lindex $numbers $index] - $index - 1]
                lappend set [lindex $numbers $index]
            }
        }
        #
        # If the sum equals 0, and the set has more than a single 
        # element, print the set, followed by a semi-colon.
        #
        if {$sum == 0 && [llength $set] > 1} {
            puts -nonewline "${set}; "
        }
    }
    # Effectively prints a newline
    puts "" 
}
