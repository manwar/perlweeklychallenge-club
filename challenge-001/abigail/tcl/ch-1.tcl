#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-001
#

#
# Run as: tclsh ch-1.tcl < input-file
#

while {[gets stdin line] >= 0} {
    set count 0
    set index [string first e $line]
    while {$index >= 0} {
        incr count
        set line [string replace $line $index $index E]
        set index [string first e $line]
    }
    puts $line
    puts $count
}
