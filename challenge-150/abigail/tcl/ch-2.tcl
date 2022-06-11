#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
#

#
# Run as: tclsh ch-2.tcl
#

set primes [list 2 3 5 7 11 13 17 19]

for {set n 1} {$n <= 500} {incr n} {
    set has_square 0
    foreach p $primes {
        if {$n % ($p * $p) == 0} {
            set has_square 1
        }
    }
    if {$has_square == 0} {
        puts -nonewline "${n} "
    }
}

puts ""
