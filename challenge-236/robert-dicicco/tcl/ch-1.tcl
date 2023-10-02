#!/usr/bin/env tclsh
set comment {
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-25
Challenge 236 Task 01 Exact Change ( Tcl )
-------------------------------------
}

set bills { { 5 5 5 10 20 } { 5 5 10 10 20 } { 5 5 5 20 } }

foreach paid $bills {
    puts "Input: @bills = ($paid)"
    set cnt 0
    set change 0
    set ln [expr [llength $paid]]
    while { [ expr $cnt ] < $ln } {
        set ticket [lindex $paid $cnt]
        set change_required [expr $ticket - 5]
        switch $ticket {
            5 {
                set change [ expr $change + 5 ]
            }
            10 {
            }
            20 {
                if { $change_required > $change  } {
                    puts "Output: false\n"
                    break
                } else {
                    puts "Output: true\n"
                    break
                }
                set change [ expr $change - 10]
            }
        }
        set cnt [expr $cnt + 1]
    }
    set cnt 0
}

set comment {
--------------------------------------
SAMPLE OUTPUT
tclsh .\ExactChange.tcl

Input: @bills = ( 5 5 5 10 20 )
Output: true

Input: @bills = ( 5 5 10 10 20 )
Output: false

Input: @bills = ( 5 5 5 20 )
Output: true
-------------------------------------
}


