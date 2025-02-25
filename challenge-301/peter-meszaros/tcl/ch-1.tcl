#!/usr/bin/env tclsh
#
# Task 1: Largest Number
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of positive integers, @ints.
# 
# Write a script to arrange all the elements in the given list such that they
# form the largest number and return it.
# 
# Example 1
# 
#     Input: @ints = (20, 3)
#     Output: 320
# 
# Example 2
# 
#     Input: @ints = (3, 30, 34, 5, 9)
#     Output: 9534330
# 

package require tcltest

set cases {
    {{20 3}            320 "Example 1"}
    {{3 30 34 5 9} 9534330 "Example 2"}
}

proc compare {a b} {
    if {"$b$a" < "$a$b"} {
        return -1
    }
    return 1
}

proc largest_number {l} {
    return [join [lsort -command compare $l] {}]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       largest_number [lindex $case 0]
    } [lindex $case 1]
}

exit 0

