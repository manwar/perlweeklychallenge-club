#!/usr/bin/env tclsh
#
# Task 2: Rank Array
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers.
# 
# Write a script to return an array of the ranks of each element: the lowest
# value has rank 1, next lowest rank 2, etc. If two elements are the same then
# they share the same rank.
# 
# Example 1
# 
#     Input: @ints = (55, 22, 44, 33)
#     Output: (4, 1, 3, 2)
# 
# Example 2
# 
#     Input: @ints = (10, 10, 10)
#     Output: (1, 1, 1)
# 
# Example 3
# 
#     Input: @ints = (5, 1, 1, 4, 3)
#     Output: (4, 1, 1, 3, 2)
# 

package require tcltest

set cases {
    {{55 22 44 33} {4 1 3 2}   "Example 1"}
    {{10 10 10}    {1 1 1}     "Example 2"}
    {{5 1 1 4 3}   {4 1 1 3 2} "Example 3"}
}

proc rank_array {ints} {

    set sorted [lsort -integer $ints]
    set rank {}
    set rank_value 1

    foreach i $sorted {
        if {![dict exists $rank $i]} {
            dict set rank $i $rank_value
            incr rank_value
        }
    }

    set result {}
    foreach i $ints {
        lappend result [dict get $rank $i]
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        rank_array [lindex $case 0]
    } [lindex $case 1]
}

exit 0

