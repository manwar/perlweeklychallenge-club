#!/usr/bin/env tclsh

set comment {
------------------------------------------
AUTHOR: Robert DiCicco
DATE  ; 2023-09-19
Challenge 235 Task 02 Duplicate Zaroes ( Tcl )
------------------------------------------
}

set myints {{ 1 0 2 3 0 4 5 0 } { 1 2 3 } { 0 3 0 4 5 }}

foreach mints $myints {
    puts "Input: @ints = ($mints)"
    set seen {}
    set ln [expr [llength $mints] - 1]
    foreach x $mints {
        if { $x == 0 } {
            lappend seen 0
            lappend seen 0
        } else {
            lappend seen $x
        }
    }
    puts -nonewline "Output : ("
    puts -nonewline [lrange $seen 0 $ln]
    puts ")\n"
}

set comment {
------------------------------------------
SAMPLE OUTPUT
tclsh .\DuplicateZeros.tcl

Input: @ints = ( 1 0 2 3 0 4 5 0 )
Output : (1 0 0 2 3 0 0 4)

Input: @ints = ( 1 2 3 )
Output : (1 2 3)

Input: @ints = ( 0 3 0 4 5 )
Output : (0 0 3 0 0)
------------------------------------------
}


