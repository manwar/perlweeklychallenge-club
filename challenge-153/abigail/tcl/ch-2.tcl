#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
#

#
# Run as: tclsh ch-2.tcl < input-file
#

set fac [list 1]
for {set n 1} {$n <= 9} {incr n} {
    lset fac $n [expr $n * [lindex $fac [expr $n - 1]]]
}

while {[gets stdin num] >= 0} {
    set sum 0
    set n   $num
    while {$n > 0} {
        set sum [expr $sum + [lindex $fac [expr $n % 10]]]
        set n   [expr int ($n / 10)]
    }
    puts [expr $sum == $num ? 1 : 0]
}
