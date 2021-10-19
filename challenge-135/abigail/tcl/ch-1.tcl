#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl < input-file
#

while {[gets stdin line] >= 0} {
    if {[regexp {^[-+]?([0-9]+)$} $line -> digits]} {
        set ll [string length $digits]
        if {[expr $ll % 2] == 0} {
            puts "even number of digits"
        } elseif {[expr $ll < 3]} {
            puts "too short"
        } else {
            puts [string range $digits [expr ($ll - 3) / 2]\
                                       [expr ($ll + 2) / 2]]
        }
    } else {
        puts "not an integer"
    }
}
