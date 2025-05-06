#!/usr/bin/env tclsh
#
# Task 2: Sum Difference
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of positive integers.
# 
# Write a script to return the absolute difference between digit sum and element
# sum of the given array.
# 
# Example 1
# 
#     Input: @ints = (1, 23, 4, 5)
#     Output: 18
# 
#     Element sum: 1 + 23 + 4 + 5 => 33
#     Digit sum: 1 + 2 + 3 + 4 + 5 => 15
#     Absolute difference: | 33 - 15 | => 18
# 
# Example 2
# 
#     Input: @ints = (1, 2, 3, 4, 5)
#     Output: 0
# 
#     Element sum: 1 + 2 + 3 + 4 + 5 => 15
#     Digit sum: 1 + 2 + 3 + 4 + 5 => 15
#     Absolute difference: | 15 - 15 | => 0
# 
# Example 3
# 
#     Input: @ints = (1, 2, 34)
#     Output: 27
# 
#     Element sum: 1 + 2 + 34 => 37
#     Digit sum: 1 + 2 + 3 + 4 => 10
#     Absolute difference: | 37 - 10 | => 27
# 

package require tcltest

set cases {
    {{1 23  4 5}   18 {Example 1}}
    {{1  2  3 4 5}  0 {Example 2}}
    {{1  2 34}     27 {Example 3}}
}

proc sum_difference {ints} {
    set esum 0
    set dsum 0

    foreach i $ints {
        incr esum $i
        foreach j [split $i ""] {
            incr dsum $j
        }
    }

    return [expr abs($esum - $dsum)]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       sum_difference [lindex $case 0]
    } [lindex $case 1]
}

exit 0

