#!/usr/bin/env tclsh
#
# Task 1: Arrange Binary
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of binary digits (0 and 1) and a positive integer, $n.
# 
# Write a script to return true if you can re-arrange the list by replacing at
# least $n digits with 1 in the given list so that no two consecutive digits are
# 1 otherwise return false.
# 
# Example 1
# 
#     Input: @digits = (1, 0, 0, 0, 1), $n = 1
#     Output: true
# 
#     Re-arranged list: (1, 0, 1, 0, 1)
# 
# Example 2
# 
#     Input: @digits = (1, 0, 0, 0, 1), $n = 2
#     Output: false
# 

package require tcltest

set cases {
    {{{1 0 0 0 1} 1} 1 "Example 1"}
    {{{1 0 0 0 1} 2} 0 "Example 2"}
}

proc arrange_binary {p} {
    set l [lindex $p 0]
    set n [lindex $p 1]

    set count 0
    for {set i 0} {$i < [expr [llength $l] - 1]} {incr i} {
        if {[lindex $l $i] == 0 && [lindex $l [expr $i + 1]] == 0} {
            incr count
        }
    }

    return [expr $count > $n ? 1 : 0]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       arrange_binary [lindex $case 0]
    } [lindex $case 1]
}

exit 0
