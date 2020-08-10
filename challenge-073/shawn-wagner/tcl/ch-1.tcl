#!/usr/bin/env tclsh
package require Tcl 8.6

proc task1 {A S} {
    incr S -1
    set last_index [expr {[llength $A] - $S}]
    for {set i 0} {$i < $last_index} {incr i} {
        lappend results [::tcl::mathfunc::min {*}[lrange $A $i $i+$S]]
    }
    puts "Task 1:\t$results"
}

task1 {1 5 0 2 9 3 7 6 4 8} 3

