#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl < input-file
#

while {[gets stdin line] >= 0} {
    set list [split $line " "]
    set result 1
    for {set i 1} {$i < [llength $list]} {incr i} {
        if {[lindex $list [expr $i - 1]] > [lindex $list $i]} {
            set result 0
            break
        }
    }
    puts $result
}
