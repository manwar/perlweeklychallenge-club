#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
#

#
# Run as: tclsh ch-2.tcl
#

set pentagon [dict create]
set p 0
set n 0
set done 0

while {!$done} {
    set p [expr $p + $n + $n + $n + 1]
    incr n
    dict set pentagon $p 1

    foreach seen [dict keys $pentagon] {
        if {$seen + $seen <= $p
                 && [dict exists $pentagon [expr $p - $seen]]
                 && [dict exists $pentagon [expr $p - $seen - $seen]]} {
            puts -nonewline "${seen} "
            puts [expr $p - $seen]
            set done 1
            break
        }
    }
}
