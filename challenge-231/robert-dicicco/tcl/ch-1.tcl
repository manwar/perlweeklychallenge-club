#!/usr/bin/env tclsh
set comment {
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-08-21
Challenge 231 Min Max Task 1 ( Tcl )
----------------------------------------
}

set myints  {{3 2 1 4} {3 1} {2 1 3}}

proc minimum mint {
    set mymin 10
    foreach m $mint {
        if {$m < $mymin} {
            set mymin $m
        }
    }
    return $mymin
}

proc maximum mint {
    set mymax 0
    foreach m $mint {
        if {$m > $mymax} {
            set mymax $m
        }
    }
    return $mymax
}

foreach mints $myints {
    set arr []
    puts "Input: @ints = \[$mints\]"
    puts -nonewline "Output: "
    set ln [llength $mints ]
    if { $ln <= 2 } {
        puts "\[\]\n"
        continue
    }
    set minm [minimum $mints]
    set maxm [maximum $mints]

    foreach i $mints {
        if {$i > $minm && $i < $maxm} {
            lappend arr $i
        }
    }
    puts "\[$arr\]\n"
}

set comment {
----------------------------------------
SAMPLE OUTPUT
tclsh .\MinMax.tcl

Input: @ints = [3 2 1 4]
Output: [3 2]

Input: @ints = [3 1]
Output: []

Input: @ints = [2 1 3]
Output: [2]
----------------------------------------
}




