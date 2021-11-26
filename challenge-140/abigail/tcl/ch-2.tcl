#
# See ../README.md
#

#
# Run as: tclsh ch-2.tcl < input-file
#

while {[gets stdin line] >= 0} {
    lassign [split $line " "] i j k
    set n 0
    while {$k > 0} {
        incr n
        set s [expr isqrt ($n)]
        for {set d 1} {$d <= $s} {incr d} {
            if {$n % $d == 0} {
                if {$d <= $i && $n / $d <= $j} {incr k -1}
                if {$d <= $j && $n / $d <= $i} {incr k -1}
                if {$n == $d * $d}             {incr k}
            }
        }
    }
    puts $n
}
