#!/usr/bin/env tclsh
#
# Task 2: Step by Step
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# 
# Write a script to find the minimum positive start value such that step by step
# sum is never less than one.
# 
# Example 1
# 
#     Input: @ints = (-3, 2, -3, 4, 2)
#     Output: 5
# 
#     For start value 5.
#     5 + (-3) = 2
#     2 + (+2) = 4
#     4 + (-3) = 1
#     1 + (+4) = 5
#     5 + (+2) = 7
# 
# Example 2
# 
#     Input: @ints = (1, 2)
#     Output: 1
# 
# Example 3
# 
#     Input: @ints = (1, -2, -3)
#     Output: 5
# 

package require tcltest

set cases {
    {{-3  2 -3 4 2} 5 "Example 1"}
    {{ 1  2}        1 "Example 2"}
    {{ 1 -2 -3}     5 "Example 3"}
}

proc step_by_step {p} {

    set min 0
    set v 0
    foreach i $p {
        incr v $i
        if {$v < $min} {
            set min $v
        }
    }

    return [expr 1 - $min]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        step_by_step [lindex $case 0]
    } [lindex $case 1]
}

exit 0

