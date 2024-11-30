#!/usr/bin/env tclsh
#
# Task 1: Contiguous Array
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of binary numbers, @binary.
# 
# Write a script to return the maximum length of a contiguous subarray with an
# equal number of 0 and 1.
# 
# Example 1
# 
#     Input: @binary = (1, 0)
#     Output: 2
# 
#     (1, 0) is the longest contiguous subarray with an equal number of 0 and 1.
# 
# Example 2
# 
#     Input: @binary = (0, 1, 0)
#     Output: 2
# 
#     (1, 0) or (0, 1) is the longest contiguous subarray with an equal number of
#     0 and 1.
# 
# Example 3
# 
#     Input: @binary = (0, 0, 0, 0, 0)
#     Output: 0
# 
# Example 4
# 
#     Input: @binary = (0, 1, 0, 0, 1, 0)
#     Output: 4
# 

package require tcltest

set cases {
    {{1 0}         2 "Example 1"}
    {{0 1 0}       2 "Example 2"}
    {{0 0 0 0 0}   0 "Example 3"}
    {{0 1 0 0 1 0} 4 "Example 4"}
}

proc contiguous_array {l} {

    proc ladd {l} {
        set total 0
        foreach nxt $l {
            incr total $nxt
        }
        return $total
    }

    set len [llength $l]
    for {set i $len} {$i > 1} {incr i -1} {
        for {set j 0} {$j <= $len-$i} {incr j} {
            set sum [ladd [lrange $l $j [expr $j+$i-1]]]
            if {$sum == $i/2.0} {
                return $i
            }
        }
    }

    return 0
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        contiguous_array [lindex $case 0]
    } [lindex $case 1]
}

exit 0
