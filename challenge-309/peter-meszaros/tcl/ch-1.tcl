#!/usr/bin/env tclsh
#
# Task 1: Min Gap
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints, increasing order.
# 
# Write a script to return the element before which you find the smallest gap.
# 
# Example 1
# 
#     Input: @ints = (2, 8, 10, 11, 15)
#     Output: 11
# 
#      8 - 2  => 6
#     10 - 8  => 2
#     11 - 10 => 1
#     15 - 11 => 4
# 
#     11 is where we found the min gap.
# 
# Example 2
# 
#     Input: @ints = (1, 5, 6, 7, 14)
#     Output: 6
# 
#      5 - 1 => 4
#      6 - 5 => 1
#      7 - 6 => 1
#     14 - 7 => 7
# 
#     6 and 7 where we found the min gap, so we pick the first instance.
# 
# Example 3
# 
#     Input: @ints = (8, 20, 25, 28)
#     Output: 28
# 
#      8 - 20 => 14
#     25 - 20 => 5
#     28 - 25 => 3
# 
#     28 is where we found the min gap.
# 

package require tcltest

set cases {
    {{2  8 10 11 15} 11 "Example 1"}
    {{1  5  6  7 14}  6 "Example 2"}
    {{8 20 25 28}    28 "Example 3"}
}

proc min_gap {p} {

    set gap -1
    set idx -1

    for {set i 1} {$i < [llength $p]} {incr i} {
        set d [expr [lindex $p $i] - [lindex $p [expr $i - 1]]]
        if {$gap == -1 || $d < $gap} {
            set gap $d
            set idx $i
        }
    }
    return [lindex $p $idx]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       min_gap [lindex $case 0]
    } [lindex $case 1]
}

exit 0

