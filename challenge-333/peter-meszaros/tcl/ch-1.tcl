#!/usr/bin/env tclsh
#
# Task 1: Straight Line
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of co-ordinates.
# 
# Write a script to find out if the given points make a straight line.
# 
# Example 1
# 
#     Input: @list = ([2, 1], [2, 3], [2, 5])
#     Output: true
# 
# Example 2
# 
#     Input: @list = ([1, 4], [3, 4], [10, 4])
#     Output: true
# 
# Example 3
# 
#     Input: @list = ([0, 0], [1, 1], [2, 3])
#     Output: false
# 
# Example 4
# 
#     Input: @list = ([1, 1], [1, 1], [1, 1])
#     Output: true
# 
# Example 5
# 
#     Input: @list = ([1000000, 1000000], [2000000, 2000000], [3000000, 3000000])
#     Output: true
# 

package require tcltest

set cases {
    {{{2 1} {2 3} {2 5}}  1 "Example 1"}
    {{{1 4} {3 4} {10 4}} 1 "Example 2"}
    {{{0 0} {1 1} {2 3}}  0 "Example 3"}
    {{{1 1} {1 1} {1 1}}  1 "Example 4"}
    {{{1000000 1000000} {2000000 2000000} {3000000 3000000}}
                          1 "Example 5"}
}

proc straight_line {points} {
    if {[llength $points] < 2} {
        return 0
    }

    set x0 [lindex [lindex $points 0] 0]
    set y0 [lindex [lindex $points 0] 1]
    set x1 [lindex [lindex $points 1] 0]
    set y1 [lindex [lindex $points 1] 1]
    set dx [expr $x1 - $x0]
    set dy [expr $y1 - $y0]

    for {set i 2} {$i < [llength $points]} {incr i} {
        set point [lindex $points $i]
        set x [lindex $point 0]
        set y [lindex $point 1]
        if {[expr ($x - $x0) * $dy != ($y - $y0) * $dx]} {
            return 0
        }
    }

    return 1;
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        straight_line [lindex $case 0]
    } [lindex $case 1]
}

exit 0

