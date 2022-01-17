#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
#

#
# Run as: tclsh ch-1.tcl
#

for {set i 0} {$i <= 100} {incr i} {
    if {![regexp {^0$|[1789]|^2.|[35]$} $i]} {
        puts -nonewline "${i} "
    }
}

puts ""
