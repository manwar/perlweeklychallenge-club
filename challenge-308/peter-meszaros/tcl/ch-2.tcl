#!/usr/bin/env tclsh
#
# Task 2: Decode XOR
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an encoded array and an initial integer.
# 
# Write a script to find the original array that produced the given encoded
# array. It was encoded such that encoded[i] = orig[i] XOR orig[i + 1].
# 
# Example 1
# 
#     Input: @encoded = (1, 2, 3), $initial = 1
#     Output: (1, 0, 2, 1)
# 
#     Encoded array created like below, if the original array was (1, 0, 2, 1)
#     $encoded[0] = (1 xor 0) = 1
#     $encoded[1] = (0 xor 2) = 2
#     $encoded[2] = (2 xor 1) = 3
# 
# Example 2
# 
#     Input: @encoded = (6, 2, 7, 3), $initial = 4
#     Output: (4, 2, 0, 7, 4)
# 

package require tcltest

set cases {
    {{{1 2 3}   1} {1 0 2 1}   "Example 1"}
    {{{6 2 7 3} 4} {4 2 0 7 4} "Example 2"}
}

proc decode_xor {p} {
    set encoded [lindex $p 0]
    set initial [lindex $p 1]
    
    set orig [list $initial]
    foreach i $encoded {
        lappend orig [expr {$i ^ [lindex $orig end]}]
    }
    return $orig
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       decode_xor [lindex $case 0]
    } [lindex $case 1]
}

exit 0

