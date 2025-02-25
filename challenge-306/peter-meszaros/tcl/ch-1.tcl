#!/usr/bin/env tclsh
#
# Task 1: Odd Sum
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of positive integers, @ints.
# 
# Write a script to return the sum of all possible odd-length subarrays of the
# given array. A subarray is a contiguous subsequence of the array.
# 
# Example 1
# 
#     Input: @ints = (2, 5, 3, 6, 4)
#     Output: 77
# 
#     Odd length sub-arrays:
#     (2) => 2
#     (5) => 5
#     (3) => 3
#     (6) => 6
#     (4) => 4
#     (2, 5, 3) => 10
#     (5, 3, 6) => 14
#     (3, 6, 4) => 13
#     (2, 5, 3, 6, 4) => 20
# 
#     Sum => 2 + 5 + 3 + 6 + 4 + 10 + 14 + 13 + 20 => 77
# 
# Example 2
# 
#     Input: @ints = (1, 3)
#     Output: 4
# 

package require tcltest

set cases {
    {{2 5 3 6 4} 77 "Example 1"}
    {{1 3}        4 "Example 2"}
}

proc odd_sum {p} {

    set sum 0
    for {set i 0} {$i < [llength $p]} {incr i} {
        for {set j $i} {$j < [llength $p]} {incr j} {
            set len [expr {$j - $i + 1}]
            if {$len % 2} {
                for {set k $i} {$k <= $j} {incr k} {
                    incr sum [lindex $p $k]
                }
            }
        }
    }
    return $sum
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       odd_sum [lindex $case 0]
    } [lindex $case 1]
}

exit 0

