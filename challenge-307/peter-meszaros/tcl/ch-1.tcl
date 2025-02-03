#!/usr/bin/env tclsh
#
# Task 1: Check Order
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# 
# Write a script to re-arrange the given array in an increasing order and return
# the indices where it differs from the original array.
# 
# Example 1
# 
#     Input: @ints = (5, 2, 4, 3, 1)
#     Output: (0, 2, 3, 4)
# 
#     Before: (5, 2, 4, 3, 1)
#     After : (1, 2, 3, 4, 5)
# 
#     Difference at indices: (0, 2, 3, 4)
# 
# Example 2
# 
#     Input: @ints = (1, 2, 1, 1, 3)
#     Output: (1, 3)
# 
#     Before: (1, 2, 1, 1, 3)
#     After : (1, 1, 1, 2, 3)
# 
#     Difference at indices: (1, 3)
# 
# Example 3
# 
#     Input: @ints = (3, 1, 3, 2, 3)
#     Output: (0, 1, 3)
# 
#     Before: (3, 1, 3, 2, 3)
#     After : (1, 2, 3, 3, 3)
# 
#     Difference at indices: (0, 1, 3)
# 

package require tcltest

set cases {
    {{5 2 4 3 1} {0 2 3 4} "Example 1"}
    {{1 2 1 1 3} {1 3}     "Example 2"}
    {{3 1 3 2 3} {0 1 3}   "Example 3"}
}

proc check_order {l} {
    set sorted [lsort -integer $l]
    set diff {}
    for {set i 0} {$i < [llength $sorted]} {incr i} {
        if {[lindex $l $i] != [lindex $sorted $i]} {
            lappend diff $i
        }
    }
    return $diff
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       check_order [lindex $case 0]
    } [lindex $case 1]
}

exit 0
