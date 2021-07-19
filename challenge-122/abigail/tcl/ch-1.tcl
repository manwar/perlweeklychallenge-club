#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl < input-file
#

set s 0
set c 0

while {[gets stdin n] >= 0} {
    set s [expr $s + $n]
    set c [expr $c +  1]
    puts  [expr $s / $c]
}
