#!/usr/bin/env tclsh
#
# Task 2: Sort Odd Even
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers.
# 
# Write a script to sort odd index elements in decreasing order and even index
# elements in increasing order in the given array.
# 
# Example 1
# 
#     Input: @ints = (4, 1, 2, 3)
#     Output: (2, 3, 4, 1)
# 
#     Even index elements: 4, 2 => 2, 4 (increasing order)
#     Odd index elements : 1, 3 => 3, 1 (decreasing order)
# 
# Example 2
# 
#     Input: @ints = (3, 1)
#     Output: (3, 1)
# 
# Example 3
# 
#     Input: @ints = (5, 3, 2, 1, 4)
#     Output: (2, 3, 4, 1, 5)
# 
#     Even index elements: 5, 2, 4 => 2, 4, 5 (increasing order)
#     Odd index elements : 3, 1 => 3, 1 (decreasing order)
# 

package require tcltest

set cases {
    {{4 1 2 3}   {2 3 4 1}   "Example 1"}
    {{3 1}       {3 1}       "Example 2"}
    {{5 3 2 1 4} {2 3 4 1 5} "Example 3"}
}

proc sort_odd_even {l} {
    set len [llength $l]
    for {set i 0} {$i < $len} {incr i} {
        if {[expr $i % 2] == 0} {
            lappend even  [lindex $l $i]
        } else {
            lappend odd   [lindex $l $i]
        }
    }
    set even [lsort -integer -increasing $even]
    set odd  [lsort -integer -decreasing $odd]

    for {set i 0} {$i < [llength $even]} {incr i} {
        lappend sorted [lindex $even $i]
        if {[llength $odd] > $i} {
            lappend sorted [lindex $odd $i]
        }
    }

    return $sorted
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       sort_odd_even [lindex $case 0]
    } [lindex $case 1]
}

exit 0

