#!/usr/bin/env tclsh
#
# Task 2: Maximum Average
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints and an integer, $n which is less than
# or equal to total elements in the given array.
# 
# Write a script to find the contiguous subarray whose length is the given
# integer, $n, and has the maximum average. It should return the average.
# 
# Example 1
# 
#     Input: @ints = (1, 12, -5, -6, 50, 3), $n = 4
#     Output: 12.75
# 
#     Subarray: (12, -5, -6, 50)
#     Average: (12 - 5 - 6 + 50) / 4 = 12.75
# 
# Example 2
# 
#     Input: @ints = (5), $n = 1
#     Output: 5
# 

package require tcltest

set cases {
    {{{1 12 -5 -6 50 3} 4} 12.75 "Example 1"}
    {{{5}               1}  5.0  "Example 2"}
}

proc ladd {l} {
    set total 0.0
    foreach nxt $l {
        set total [expr $total + $nxt]
    }
    return $total
}

proc maximum_average {p} {
    set l [lindex $p 0]
    set n [lindex $p 1]

    set avgmax {}
    for {set i 0} {$i <= [expr [llength $l] - $n]} {incr i} {
        set avg [expr [ladd [lrange $l $i [expr $i + $n - 1]]] / $n]
        if {$avgmax == {} || $avg > $avgmax} {
            set avgmax $avg
        }
    }

    return $avgmax
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       maximum_average [lindex $case 0]
    } [lindex $case 1]
}

exit 0
