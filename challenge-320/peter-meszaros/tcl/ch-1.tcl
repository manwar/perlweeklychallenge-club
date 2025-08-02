#!/usr/bin/env tclsh
#
# Task 1: Maximum Count
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers.
# 
# Write a script to return the maximum between the number of positive and
# negative integers. Zero is neither positive nor negative.
# 
# Example 1
# 
#     Input: @ints = (-3, -2, -1, 1, 2, 3)
#     Output: 3
# 
#     There are 3 positive integers.
#     There are 3 negative integers.
#     The maximum between 3 and 3 is 3.
# 
# Example 2
# 
#     Input: @ints = (-2, -1, 0, 0, 1)
#     Output: 2
# 
#     There are 1 positive integers.
#     There are 2 negative integers.
#     The maximum between 2 and 1 is 2.
# 
# Example 3
# 
#     Input: @ints = (1, 2, 3, 4)
#     Output: 4
# 
#     There are 4 positive integers.
#     There are 0 negative integers.
#     The maximum between 4 and 0 is 4.
# 

package require tcltest

set cases {
    {{-3 -2 -1 1 2 3} 3 {Example 1}}
    {{-2 -1  0 0 1}   2 {Example 2}}
    {{ 1  2  3 4}     4 {Example 3}}
}

proc maximum_count {ints} {
    set pos 0
    set neg 0

    foreach i $ints {
        if {$i > 0} {
            incr pos
        } elseif {$i < 0} {
            incr neg
        }
    }
    return [expr $pos > $neg ? $pos : $neg]

}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       maximum_count [lindex $case 0]
    } [lindex $case 1]
}

exit 0

