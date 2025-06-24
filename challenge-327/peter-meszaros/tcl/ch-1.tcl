#!/usr/bin/env tclsh
#
# Task 1: Missing Integers
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of n integers.
# 
# Write a script to find all the missing integers in the range 1..n in the given
# array.
# 
# Example 1
# 
#     Input: @ints = (1, 2, 1, 3, 2, 5)
#     Output: (4, 6)
# 
#     The given array has 6 elements.
#     So we are looking for integers in the range 1..6 in the given array.
#     The missing integers: (4, 6)
# 
# Example 2
# 
#     Input: @ints = (1, 1, 1)
#     Output: (2, 3)
# 
# Example 3
# 
#     Input: @ints = (2, 2, 1)
#     Output: (3)
# 

package require tcltest

set cases {
    {{1 2 1 3 2 5} {4 6} "Example 1"}
    {{1 1 1}       {2 3} "Example 2"}
    {{2 2 1}       {3}   "Example 3"}
}

proc missing_integers {ints} {

    set n [llength $ints]
    set seen {}
    foreach i $ints {
        dict set seen $i 1
    }
    set missing {}
    for {set i 1} {$i <= $n} {incr i} {
        if {![dict exists $seen $i]} {
            lappend missing $i
        }
    }
    return $missing
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        missing_integers [lindex $case 0]
    } [lindex $case 1]
}

exit 0

