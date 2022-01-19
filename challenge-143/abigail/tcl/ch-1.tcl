#
# Run as: tclsh ch-1.tcl < input-file
#

while {[gets stdin line] >= 0} {puts [expr $line]}
