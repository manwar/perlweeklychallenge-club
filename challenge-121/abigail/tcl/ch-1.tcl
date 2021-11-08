#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl < input-file
#

while {[gets stdin line] >= 0} {
    lassign [split $line " "] m n
    puts [expr $m ^ (1 << ($n - 1))]
}
