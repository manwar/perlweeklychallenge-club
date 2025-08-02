#!/usr/bin/env tclsh
#
# Task 1: Middle Index
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# 
# Write a script to find the leftmost middle index (MI) i.e. the smallest amongst
# all the possible ones.
# 
#     A middle index is an index where ints[0] + ints[1] + ... + ints[MI-1] ==
#     ints[MI+1] + ints[MI+2] + ... + ints[ints.length-1].
# 
# If MI == 0, the left side sum is considered to be 0. Similarly,
# 
# if MI == ints.length - 1, the right side sum is considered to be 0.
# 
# Return the leftmost MI that satisfies the condition, or -1 if there is no such
# index.
# 
# Example 1
# 
#     Input: @ints = (2, 3, -1, 8, 4)
#     Output: 3
# 
#     The sum of the numbers before index 3 is: 2 + 3 + -1 = 4
#     The sum of the numbers after index 3 is: 4 = 4
# 
# Example 2
# 
#     Input: @ints = (1, -1, 4)
#     Output: 2
# 
#     The sum of the numbers before index 2 is: 1 + -1 = 0
#     The sum of the numbers after index 2 is: 0
# 
# Example 3
# 
#     Input: @ints = (2, 5)
#     Output: -1
# 
#     There is no valid MI.
# 

package require tcltest

set cases {
    {{2 3 -1 8 4} 3 "Example 1"}
    {{1 -1 4}     2 "Example 2"}
    {{2 5}       -1 "Example 3"}
}

proc middle_index {lst} {

    set ls 0
    set rs 0

    foreach n [lrange $lst 1 end] {
        incr rs $n
    }

    for {set i 0} {$i < [llength $lst]} {incr i} {
        if {$rs == $ls} {
            return $i
        }
        incr ls [lindex $lst $i]
        set v [lindex $lst [expr $i + 1]]
        if {$v != {}} {
            incr rs [expr -$v]
        }
    }
    return -1
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       middle_index [lindex $case 0]
    } [lindex $case 1]
}

exit 0
