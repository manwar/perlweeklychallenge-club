#!/usr/bin/env tclsh
#
# Task 1: Range Sum
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list integers and pair of indices..
# 
# Write a script to return the sum of integers between the given indices
# (inclusive).
# 
# Example 1
# 
#     Input: @ints = (-2, 0, 3, -5, 2, -1), $x = 0, $y = 2
#     Output: 1
# 
#     Elements between indices (0, 2) => (-2, 0, 3)
#     Range Sum: (-2) + 0 + 3 => 1
# 
# Example 2
# 
#     Input: @ints = (1, -2, 3, -4, 5), $x = 1, $y = 3
#     Output: -3
# 
#     Elements between indices (1, 3) => (-2, 3, -4)
#     Range Sum: (-2) + 3 + (-4) => -3
# 
# Example 3
# 
#     Input: @ints = (1, 0, 2, -1, 3), $x = 3, $y = 4
#     Output: 2
# 
#     Elements between indices (3, 4) => (-1, 3)
#     Range Sum: (-1) + 3 => 2
# 
# Example 4
# 
#     Input: @ints = (-5, 4, -3, 2, -1, 0), $x = 0, $y = 3
#     Output: -2
# 
#     Elements between indices (0, 3) => (-5, 4, -3, 2)
#     Range Sum: (-5) + 4 + (-3) + 2 => -2
# 
# Example 5
# 
#     Input: @ints = (-1, 0, 2, -3, -2, 1), $x = 0, $y = 2
#     Output: 1
# 
#     Elements between indices (0, 2) => (-1, 0, 2)
#     Range Sum: (-1) + 0 + 2 => 1
# 


package require tcltest

set cases {
    {{{-2  0  3 -5  2 -1} {0 2}}  1 "Example 1"}
    {{{ 1 -2  3 -4  5}    {1 3}} -3 "Example 2"}
    {{{ 1  0  2 -1  3}    {3 4}}  2 "Example 3"}
    {{{-5  4 -3  2 -1  0} {0 3}} -2 "Example 4"}
    {{{-1  0  2 -3 -2  1} {0 2}}  1 "Example 5"}
}

proc range_sum {p} {
    set ints [lindex $p 0]
    set x [lindex [lindex $p 1] 0]
    set y [lindex [lindex $p 1] 1]

    set sum 0
    for {set i $x} {$i <= $y} {incr i} {
        set sum [expr $sum + [lindex $ints $i]]
    }
    return $sum
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        range_sum [lindex $case 0]
    } [lindex $case 1]
}

exit 0

