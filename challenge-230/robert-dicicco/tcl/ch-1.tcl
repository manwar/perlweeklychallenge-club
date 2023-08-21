#!/usr/bin/env/tclsh
set comment {
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-14
Challenge 230 Seperate Digits Task 1 ( Tcl )
---------------------------------------
}

set myints {{1 34 5 6} {1 24 51 60}}

foreach ints $myints {
    set str {}
    puts "Input: @ints = ($ints)"
    foreach elem $ints {
        set str [ concat $str $elem ]
    }
    set stripped [string map {" " ""} $str]
    set arr [split $stripped {}]
    puts "Output: $arr\n"
}

set comment {
---------------------------------------
SAMPLE OUTPUT
tclsh .\SeperateDigits.tcl

Input: @ints = (1 34 5 6)
Output: 1 3 4 5 6

Input: @ints = (1 24 51 60)
Output: 1 2 4 5 1 6 0
---------------------------------------
}


