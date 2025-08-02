#!/usr/bin/env tclsh
#
# Task 1: Consecutive One
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a binary array containing only 0 or/and 1.
# 
# Write a script to find out the maximum consecutive 1 in the given array.
# 
# Example 1
# 
# Input: @binary = (0, 1, 1, 0, 1, 1, 1)
# Output: 3
# 
# Example 2
# 
# Input: @binary = (0, 0, 0, 0)
# Output: 0
# 
# Example 3
# 
# Input: @binary = (1, 0, 1, 0, 1, 1)
# Output: 2
# 

package require tcltest

set cases {
    {{0 1 1 0 1 1 1} 3 "Example 1"}
    {{0 0 0 0}       0 "Example 2"}
    {{1 0 1 0 1 1}   2 "Example 3"}
}

proc consecutive_one {bin} {
    set max_count 0
    set current_count 0

    foreach bit $bin {
        if {$bit == 1} {
            incr current_count
            if {$current_count > $max_count} {
                set max_count $current_count
            }
        } else {
            set current_count 0
        }
    }

    return $max_count
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       consecutive_one [lindex $case 0]
    } [lindex $case 1]
}

exit 0

