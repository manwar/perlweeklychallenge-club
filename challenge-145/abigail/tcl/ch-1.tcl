#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl < input-file
#

set a [split [gets stdin] " "]
set b [split [gets stdin] " "]

set sum 0
for {set i 0} {$i < [llength $a]} {incr i} {
    set sum [expr $sum + [lindex $a $i] * [lindex $b $i]]
}

puts $sum
