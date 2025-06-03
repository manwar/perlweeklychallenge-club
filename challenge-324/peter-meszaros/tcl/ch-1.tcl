#!/usr/bin/env tclsh
#
# Task 1: 2D Array
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers and two integers $r amd $c.
# 
# Write a script to create two dimension array having $r rows and $c columns
# using the given array.
# 
# Example 1
# 
#     Input: @ints = (1, 2, 3, 4), $r = 2, $c = 2
#     Output: ([1, 2], [3, 4])
# 
# Example 2
# 
#     Input: @ints = (1, 2, 3), $r = 1, $c = 3
#     Output: ([1, 2, 3])
# 
# Example 3
# 
#     Input: @ints = (1, 2, 3, 4), $r = 4, $c = 1
#     Output: ([1], [2], [3], [4])
# 

package require tcltest

set cases {
    {{{1 2 3 4} 2 2} {{1 2} {3 4}} "Example 1"}
    {{{1 2 3}   1 3} {{1 2 3}}     "Example 2"}
    {{{1 2 3 4} 4 1} {1 2 3 4}     "Example 3"}
}

proc two_d_array {p} {
    set ints [lindex $p 0]
    set r    [lindex $p 1]
    set c    [lindex $p 2]

    if {[llength $ints] != $r * $c} {
        return nil
    }

    set result {}
    for {set i 0} {$i < $r} {incr i} {
        lappend result [lrange $ints [expr $i * $c] [expr ($i * $c) + $c - 1]]
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       two_d_array [lindex $case 0]
    } [lindex $case 1]
}

exit 0
