#!/usr/bin/env tclsh
#
# Task 1: Array Form Compute
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints and an integer, $x.
# 
# Write a script to add $x to the integer in the array-form.
# 
#     The array form of an integer is a digit-by-digit representation stored as
#     an array, where the most significant digit is at the 0th index.
# 
# Example 1
# 
#     Input: @ints = (1, 2, 3, 4), $x = 12
#     Output: (1, 2, 4, 6)
# 
# Example 2
# 
#     Input: @ints = (2, 7, 4), $x = 181
#     Output: (4, 5, 5)
# 
# Example 3
# 
#     Input: @ints = (9, 9, 9), $x = 1
#     Output: (1, 0, 0, 0)
# 
# Example 4
# 
#     Input: @ints = (1, 0, 0, 0, 0), $x = 9999
#     Output: (1, 9, 9, 9, 9)
# 
# Example 5
# 
#     Input: @ints = (0), $x = 1000
#     Output: (1, 0, 0, 0)
# 

package require tcltest

set cases {
    {{{1 2 3 4}     12} {1 2 4 6}   "Example 1"}
    {{{2 7 4}      181} {4 5 5}     "Example 2"}
    {{{9 9 9}        1} {1 0 0 0}   "Example 3"}
    {{{1 0 0 0 0} 9999} {1 9 9 9 9} "Example 4"}
    {{{0}         1000} {1 0 0 0}   "Example 5"}
}

proc array_form_compute {p} {
    set ints [lindex $p 0]
    set x    [lindex $p 1]

    return [split [expr [join $ints ""] + $x] ""]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        array_form_compute [lindex $case 0]
    } [lindex $case 1]
}

exit 0

