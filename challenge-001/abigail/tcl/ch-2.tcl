#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
#

#
# Run as: tclsh ch-2.tcl < input-file
#

while {[gets stdin max] >= 0} {
    for {set i 1} {$i <= $max} {incr i} {
        if {$i % 15 == 0} {
            puts "fizzbuzz"
            continue
        }
        if {$i %  5 == 0} {
            puts     "buzz"
            continue
        }
        if {$i %  3 == 0} {
            puts "fizz"
            continue
        }
        puts $i
    }
}
