#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
#

#
# Run as: tclsh ch-1.tcl < input-file
#

while {[gets stdin line] >= 0} {
    lassign [split $line " "] fib_prev fib_last
    while {[string length $fib_last] < 51} {
        lassign "$fib_last $fib_prev$fib_last" fib_prev fib_last
    }
    puts [string index $fib_last 50]
}
