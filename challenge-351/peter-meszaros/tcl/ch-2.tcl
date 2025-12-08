#!/usr/bin/env tclsh
#
# Task 2: Arithmetic Progression
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of numbers.
# 
# Write a script to return true if the given array can be re-arranged to form an
# arithmetic progression, otherwise return false.
# 
#     A sequence of numbers is called an arithmetic progression if the difference
#     between any two consecutive elements is the same.
# 
# Example 1
# 
#     Input: @num = (1, 3, 5, 7, 9)
#     Output: true
# 
#     Already AP with common difference 2.
# 
# Example 2
# 
#     Input: @num = (9, 1, 7, 5, 3)
#     Output: true
# 
#     The given array re-arranged like (1, 3, 5, 7, 9) with common difference 2.
# 
# Example 3
# 
#     Input: @num = (1, 2, 4, 8, 16)
#     Output: false
# 
#     This is geometric progression and not arithmetic progression.
# 
# Example 4
# 
#     Input: @num = (5, -1, 3, 1, -3)
#     Output: true
# 
#     The given array re-arranged like (-3, -1, 1, 3, 5) with common difference 2.
# 
# Example 5
# 
#     Input: @num = (1.5, 3, 0, 4.5, 6)
#     Output: true
# 
#     The given array re-arranged like (0, 1.5, 3, 4.5, 6) with common difference 1.5.
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{1   3 5 7   9} true  "Example 1"}
    {{9   1 7 5   3} true  "Example 2"}
    {{1   2 4 8  16} false "Example 3"}
    {{5  -1 3 1  -3} true  "Example 4"}
    {{1.5 3 0 4.5 6} true  "Example 5"}
}

proc arithmetic_progression {arr} {
    set sorted [lsort -real $arr]
    set diff [expr [lindex $sorted 1] - [lindex $sorted 0]]
    for {set i 2} {$i < [llength $sorted]} {incr i} {
        if {[expr [lindex $sorted $i] - [lindex $sorted [expr $i - 1]]] != $diff} {
            return false
        }
    }
    return true
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        arithmetic_progression [lindex $case 0]
    } [lindex $case 1]
}

exit 0

