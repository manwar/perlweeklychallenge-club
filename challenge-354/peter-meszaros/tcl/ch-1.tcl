#!/usr/bin/env tclsh
#
# Task 1: Min Abs Diff
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of distinct integers.
# Write a script to find all pairs of elements with the minimum absolute difference.
# 
# Rules (a,b):
# 
#     1: a, b are from the given array.
#     2: a < b
#     3: b - a = min abs diff any two elements in the given array
# 
# Example 1
# 
#     Input: @ints= (4, 2, 1, 3)
#     Output: [1, 2], [2, 3], [3, 4]
# 
# Example 2
# 
#     Input: @ints = (10, 100, 20, 30)
#     Output: [10, 20], [20, 30]
# 
# Example 3
# 
#     Input: @ints = (-5, -2, 0, 3)
#     Output: [-2, 0]
# 
# Example 4
# 
#     Input: @ints = (8, 1, 15, 3)
#     Output: [1, 3]
# 
# Example 5
# 
#     Input: @ints = (12, 5, 9, 1, 15)
#     Output: [9, 12], [12, 15]
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{4 2 1 3}      {{1 2} {2 3} {3 4}} "Example 1"}
    {{10 100 20 30} {{10 20} {20 30}}   "Example 2"}
    {{-5 -2 0 3}    {{-2 0}}            "Example 3"}
    {{8 1 15 3}     {{1 3}}             "Example 4"}
    {{12 5 9 1 15}  {{9 12} {12 15}}    "Example 5"}
}

proc min_abs_diff {ints} {
    set sorted [lsort -integer $ints]
    set min {}
    set result {}

    for {set i 0} {$i < [expr [llength $sorted] - 1]} {incr i} {
        set a [lindex $sorted $i]
        set b [lindex $sorted [expr $i + 1]]
        set diff [expr $b - $a]

        if {[llength $min] == 0 || $diff < $min} {
            set min $diff
            set result [list [list $a $b]]
        } elseif {$diff == $min} {
            lappend result [list $a $b]
        }
    }

    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        min_abs_diff [lindex $case 0]
    } [lindex $case 1]
}

exit 0

