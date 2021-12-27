#
# See ../README.md
#

#
# Run as: tclsh ch-1.tcl
#

set count          10
set nr_of_divisors  8

set n 0

while {$count > 0} {
    incr n
    set s [expr isqrt ($n)]
    if {$n == $s * $s} {
        continue
    }
    set c 0
    for {set d 1} {$d <= $s && $c <= $nr_of_divisors} {incr d} {
        if {$n % $d == 0} {
            incr c 2
        }
    }

    if {$c == $nr_of_divisors} {
        puts $n
        incr count -1
    }
}
