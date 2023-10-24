#!/usr/bin/env tclsh
set comment {
-----------------------------------
AUTHOR: Robert DiCicco
DATE  : 23-OCT-2023
Challenge 240 Task 02 Build Array ( Tcl )
-----------------------------------
}

set myints {{0 2 1 5 3 4} {5 0 1 2 3 4}}

foreach mints  $myints {
    set out {}
    puts "Input: @ints = ($mints)"
    set cnt 0
    while { $cnt < [llength $mints]} {
        set i [lindex $mints $cnt]
        lappend out [lindex $mints $i]
        incr cnt
    }
    puts "Output: ($out)\n"
}

set comment {
-----------------------------------
SAMPLE OUTPUT
tclsh .\BuildArray.tcl

Input: @ints = (0 2 1 5 3 4)
Output: (0 1 2 4 5 3)

Input: @ints = (5 0 1 2 3 4)
Output: (4 5 0 1 2 3)
-----------------------------------
}


