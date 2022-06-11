#!/usr/local/opt/tcl-tk/bin/tclsh

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#

#
# Run as: tclsh ch-2.tcl < input-file
#

while {[gets stdin line] >= 0} {
    set h [split $line " "] 
    lappend h 0 0
    for {set i [expr [llength $h] - 3]} {$i >= 2} {incr i -1} {
        set v1 [expr [lindex $h $i] + [lindex $h [expr $i + 2]]]
        set v2 [lindex $h [expr $i + 1]]
        lset h $i [expr $v1 < $v2 ? $v2 : $v1]
    }
    puts [expr [lindex $h 0] + [lindex $h 2]]
}
