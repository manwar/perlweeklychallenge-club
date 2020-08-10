#!/usr/bin/env tclsh
package require Tcl 8.6

proc task2 {A} {
    set last_index [llength $A]
    set results [list 0]
    for {set i 1} {$i < $last_index} {incr i} {
        set m [::tcl::mathfunc::min {*}[lrange $A 0 $i-1]]
        if {$m < [lindex $A $i]} {
            lappend results $m
        } else {
            lappend results 0
        }
    }
    puts "Task 2:\t$results"
}

task2 {7 8 3 12 10}
task2 {4 6 5}

