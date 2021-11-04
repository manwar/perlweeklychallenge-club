#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl < input-file
#

while {[gets stdin num] >= 0} {
    puts [expr int (exp (log ($num) / 2))]
}
