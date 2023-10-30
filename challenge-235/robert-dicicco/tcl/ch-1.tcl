#!/usr/bin/env tclsh
set comment {
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-18
Challenge 235 Task 1 Remove One ( Tcl )
---------------------------------------
}
set myints {{0 2 9 4 6} {5 1 3 2} {2 2 3}}

foreach ints $myints {
    puts "Input: @ints = ($ints)"
    set len [llength $ints]
    set x 1
    set cnt 0
    while { $x < $len} {
        set a [lindex $ints $x]
        set b [lindex $ints [expr { $x - 1}]]
        if { $a > $b } {
            puts "\t$a greater than $b"
            set x [expr $x + 1]
        } elseif { $a == $b } {
            puts "\t$a equal to $b"
            set x [expr $x + 1]
            set cnt [expr $cnt + 1]
        } else {
            puts "\t$a less than $b"
            set x [expr $x + 1]
            set cnt [expr $cnt + 1]
        }
    }
    if { $cnt == 1} {
        puts "Output: true\n"
    } else {
        puts "Output: false\n"
    }
 }

 set comment {
---------------------------------------
SAMPLE OUTPUT
tclsh .\RemoveOne.tcl

Input: @ints = (0 2 9 4 6)
        2 greater than 0
        9 greater than 2
        4 less than 9
        6 greater than 4
Output: true

Input: @ints = (5 1 3 2)
        1 less than 5
        3 greater than 1
        2 less than 3
Output: false

Input: @ints = (2 2 3)
        2 equal to 2
        3 greater than 2
Output: true
---------------------------------------
}


