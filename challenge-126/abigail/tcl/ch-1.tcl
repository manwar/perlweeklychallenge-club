#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl < input-file
#

while {[gets stdin line] >= 0} {
    set result   0
    set seen_one 0
    foreach char [split $line ""] {
        set result [expr 9 * $result]
        if {$seen_one == 1} {
            set result [expr $result + 8]
        } elseif {$char == 1} {
            set seen_one 1
        } elseif {$char > 0} {
            set result [expr $result + $char - 1]
        }
    }
    puts $result
}
