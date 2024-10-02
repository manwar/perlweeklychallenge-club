#!/usr/bin/env tclsh
#
# Task 1: Third Maximum
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# 
# Write a script to find the third distinct maximum in the given array. If third
# maximum doesn’t exist then return the maximum number.
# 
# Example 1
# 
#     Input: @ints = (5, 6, 4, 1)
#     Output: 4
# 
#     The first distinct maximum is 6.
#     The second distinct maximum is 5.
#     The third distinct maximum is 4.
# 
# Example 2
# 
#     Input: @ints = (4, 5)
#     Output: 5
# 
#     In the given array, the third maximum doesn't exist therefore returns the
#     maximum.
# 
# Example 3
# 
#     Input: @ints =  (1, 2, 2, 3)
#     Output: 1
# 
#     The first distinct maximum is 3.
#     The second distinct maximum is 2.
#     The third distinct maximum is 1.
# 

package require tcltest

set cases {
    {{5 6 4 1} 4 "Example 1"}
    {{4 5}     5 "Example 2"}
    {{1 2 2 3} 1 "Example 3"}
}

proc third_maximum {l} {

    set lsorted [lsort -integer -decreasing -unique $l]
    set v [lindex $lsorted 2]
    if {$v == {}} {
        set v [lindex $lsorted 0]
    }
    return $v
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       third_maximum [lindex $case 0]
    } [lindex $case 1]
}

exit 0

