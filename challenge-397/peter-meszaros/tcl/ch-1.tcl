#!/usr/bin/env tclsh
#
# Task 1: Absent Smallest Positive
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers.  Write a script to return the smallest
# absent positive integer such that it is strictly greater than the average of
# all elements in the given array.
# 
# Example 1
# 
#     Input: @arr = (1, 2, 4, 5, 6)
#     Output: 7
# 
#     Average: (1 + 2 + 4 + 5 + 6) / 5 = 3.6
#     We need the smallest positive integer absent from nums that is strictly greater than 3.6.
#     The positive integers greater than 3.6 are 4, 5, 6, 7, ....
# 
#     4 is in the given array.
#     5 is in the given array.
#     6 is in the given array.
#     7 is not in.
# 
# Example 2
# 
#     Input: @arr = (-5, -2, -1, 3)
#     Output: 1
# 
#     Average: (-5 -2 -1 + 3) / 4 = -1.25
#     We need the smallest absent positive integer strictly greater than -1.25.
#     Positive integers are 1, 2, 3, 4, ... (all are strictly greater than -1.25).
# 
#     1 is positive and absent from the given array.
# 
# Example 3
# 
#     Input: @arr = (1, 2, 3)
#     Output: 4
# 
#     Average: (1 + 2 + 3) / 3 = 2.0
#     We need an integer strictly greater than 2.0.
# 
#     3 is in the given array.
#     4 is not in.
# 
# Example 4
# 
#     Input: @arr = (2, 3, 7, 8)
#     Output: 6
# 
#     Average: (2 + 3 + 7 + 8) / 4 = 5.0
#     We need an integer strictly greater than 5.0.
# 
#     6 is not in the given array.
# 
# Example 5
# 
#     Input: @arr = (1, 1, 1, 10)
#     Output: 4
# 
#     Average: (1 + 1 + 1 + 10) / 4 = 3.25
#     Positive integers strictly greater than 3.25: 4, 5, 6, ...
# 
#     4 is not in the given array.
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{1 2 4 5 6}  7 "Example 1"}
    {{-5 -2 -1 3} 1 "Example 2"}
    {{1 2 3}      4 "Example 3"}
    {{2 3 7 8}    6 "Example 4"}
    {{1 1 1 10}   4 "Example 5"}
}

proc absent_smallest_positive {arr} {
    set sum 0
    foreach n $arr {
        set sum [expr $sum + $n]
    }
    set num [expr double($sum) / [llength $arr]]

    if {$num <= 0} {
        set num 1
    } else {
        set num [expr int($num) + 1]
    }

    set arrdict {}
    foreach i $arr {
        dict set arrdict $i 1
    }

    while {[dict exists $arrdict $num]} {
        incr num
    }
    return $num
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        absent_smallest_positive [lindex $case 0]
    } [lindex $case 1]
}

exit 0

