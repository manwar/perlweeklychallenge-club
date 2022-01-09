#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-003
#

#
# Run as: tclsh ch-2.tcl < input-file
#

while {[gets stdin max] >= 0} {
    set current_row(0) 1
    puts 1
    for {set row 1} {$row <= $max} {incr row} {
        set next_row(0)    1
        set next_row($row) 1
        puts -nonewline "1 "
        for {set col 1} {$col < $row} {incr col} {
            set next_row($col) \
               [expr $current_row([expr $col - 1]) + $current_row($col)]
            puts -nonewline $next_row($col)
            puts -nonewline " "
        }
        puts 1
        array set current_row [array get next_row]
    }
}
