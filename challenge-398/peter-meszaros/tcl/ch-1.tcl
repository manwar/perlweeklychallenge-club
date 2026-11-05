#!/usr/bin/env tclsh
#
# Task 1: Divisible Average
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of positive integers.  Write a script to return the
# closest integer to the mean value of all even integers that are divisible by 3.
# If none is divisible, return 0.
# 
# Example 1
# 
#     Input: @arr = (18, 5, 7, 11)
#     Output: 18
# 
#     18 is the only even number and divisible by 3.
#     Average: 18 / 1 = 18.
# 
# Example 2
# 
#     Input: @arr = (6, 12, 18, 24, 30, 40)
#     Output: 18
# 
#     The qualifying numbers are 6, 12, 18, 24, and 30.
#     Average: (6 + 12 + 18 + 24 + 30) / 5 = 90 / 5 = 18
# 
# Example 3
# 
#     Input: @arr = (3, 9, 15, 21, 27)
#     Output: 0
# 
#     None of the elements are even.
#     Since no elements qualify, return 0.
# 
# Example 4
# 
#     Input: @arr = (6, 12, 14, 20)
#     Output: 9
# 
#     The qualifying numbers are 6 and 12.
#     Average: (6 + 12) / 2 = 9.
# 
# Example 5
# 
#     Input: @arr = (6, 6, 6, 12, 12)
#     Output: 8
# 
#     All five numbers are even and divisible by 3.
#     Average: (6 + 6 + 6 + 12 + 12) / 5 = 8.4 => 8
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{18 5 7 11}        18 "Example 1"}
    {{6 12 18 24 30 40} 18 "Example 2"}
    {{3 9 15 21 27}      0 "Example 3"}
    {{6 12 14 20}        9 "Example 4"}
    {{6 6 6 12 12}       8 "Example 5"}
}

proc divisible_average {arr} {
    set filtered [lmap x $arr {
        if {$x % 2 == 0 && $x % 3 == 0} {
            set x
        } else {
            continue
        }
    }]

    if {[llength $filtered] == 0} {
        return 0
    }
    set sum 0
    foreach num $filtered {
        set sum [expr $sum + $num]
    }
    set avg [expr $sum / [llength $filtered]]
    return [expr round($avg)]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        divisible_average [lindex $case 0]
    } [lindex $case 1]
}

exit 0

