#!/usr/bin/env tclsh
# ---------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-10-09
# Challenge 238 Task 01 Running Sum ( Tcl )
# ---------------------------------

set myints { {1  2  3  4  5} {1  1  1  1  1} {0  -1  1  2} }
foreach mints $myints {
    puts "Input: @int = \[$mints\]"
    set sum 0
    set out {}
    foreach i $mints {
        lappend out [expr $i + $sum]
        set sum [expr $sum + $i]
    }
    puts "Output: \[$out\]\n"
}

# ---------------------------------
# SAMPLE OUTPUT
# tclsh .\RunningSum.tcl

# Input: @int = [1  2  3  4  5]
# Output: [1 3 6 10 15]

# Input: @int = [1  1  1  1  1]
# Output: [1 2 3 4 5]

# Input: @int = [0  -1  1  2]
# Output: [0 -1 0 2]
# ---------------------------------


