#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl < input-file
#

set w {1 3 1 7 3 9 1}

while {[gets stdin line] >= 0} {
    if {[regexp {^[0-9BCDFGHJKLMNPQRSTVWXYZ]{6}[0-9]$} $line]} {
        set check 0
        for {set i 0} {$i < [string length $line]} {incr i} {
            set val [scan [string index $line $i] %c]
            if {[expr $val <= [scan "9" %c]]} {
                set val [expr $val - [scan "0" %c]]
            } else {
                set val [expr $val - [scan "A" %c] + 10]
            }
            set check [expr $check + [lindex $w $i] * $val]
        }
        if {[expr $check % 10] == 0} {
            puts 1
        } else {
            puts 0
        }
    } else {
        puts 0
    }
}
