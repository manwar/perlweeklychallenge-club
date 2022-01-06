#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-123
#

#
# Run as: tclsh ch-1.tcl < input-file
#

while {[gets stdin max] >= 0} {
    set ugly(0) 1
    set count   0
    set next_2  0
    set next_3  0
    set next_5  0

    while {$count < $max - 1} {
        incr count

        set c2 [expr 2 * $ugly($next_2)]
        set c3 [expr 3 * $ugly($next_3)]
        set c5 [expr 5 * $ugly($next_5)]

        if {$c2 <= $c3 && $c2 <= $c5} {set min $c2}
        if {$c3 <= $c2 && $c3 <= $c5} {set min $c3}
        if {$c5 <= $c2 && $c5 <= $c3} {set min $c5}

        set ugly($count) $min

        if {$c2 <= $ugly($count)} {incr next_2}
        if {$c3 <= $ugly($count)} {incr next_3}
        if {$c5 <= $ugly($count)} {incr next_5}
    }

    puts $ugly($count)
}
