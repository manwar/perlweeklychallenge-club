#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl < input-file
#

while {[gets stdin line] >= 0} {
    lassign [split $line " "] n m
    array set seen { }
    for {set i 1} {$i <= $n} {incr i} {
        for {set j 1} {$j <= $m} {incr j} {
            set seen([expr $i * $j]) 1
        }
    }
    puts [array size seen]
}
