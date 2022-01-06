#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-002
#

#
# Run as: tclsh ch-1.tcl < input-file
#

while {[gets stdin line] >= 0} {
    set line [string trimleft $line 0]
    if {[string length $line] == 0} {
        set line 0
    }
    puts $line
}
