#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
#

#
# Run as: tclsh ch-1.tcl
#

set sum 1
set fac 1
puts -nonewline $sum

for {set n 1} {$n <= 9} {incr n} {
    set fac [expr $fac * $n]
    set sum [expr $sum + $fac]
    puts -nonewline " ${sum}"
}

puts ""
