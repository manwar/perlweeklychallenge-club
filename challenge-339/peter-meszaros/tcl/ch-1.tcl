#!/usr/bin/env tclsh
#
# Task 1: Max Diff
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers having four or more elements.
# 
# Write a script to find two pairs of numbers from this list (four numbers total)
# so that the difference between their products is as large as possible.
# 
# In the end return the max difference.
# 
#     With Two pairs (a, b) and (c, d), the product difference is (a * b) - (c * d).
# 
# Example 1
# 
#     Input: @ints = (5, 9, 3, 4, 6)
#     Output: 42
# 
#     Pair 1: (9, 6)
#     Pair 2: (3, 4)
#     Product Diff: (9 * 6) - (3 * 4) => 54 - 12 => 42
# 
# Example 2
# 
#     Input: @ints = (1, -2, 3, -4)
#     Output: 10
# 
#     Pair 1: (1, -2)
#     Pair 2: (3, -4)
# 
# Example 3
# 
#     Input: @ints = (-3, -1, -2, -4)
#     Output: 10
# 
#     Pair 1: (-1, -2)
#     Pair 2: (-3, -4)
# 
# Example 4
# 
#     Input: @ints = (10, 2, 0, 5, 1)
#     Output: 50
# 
#     Pair 1: (10, 5)
#     Pair 2: (0, 1)
# 
# Example 5
# 
#     Input: @ints = (7, 8, 9, 10, 10)
#     Output: 44
# 
#     Pair 1: (10, 10)
#     Pair 2: (7, 8)
# 

package require tcltest
package require math::combinatorics 

set cases {
    {{ 5  9  3  4  6} 42 "Example 1"}
    {{ 1 -2  3 -4}    10 "Example 2"}
    {{-3 -1 -2 -4}    10 "Example 3"}
    {{10  2  0  5  1} 50 "Example 4"}
    {{ 7  8  9 10 10} 44 "Example 5"}
}

proc max_diff {ints} {
    set len [llength $ints]

    set max_diff {}
    set comb [::math::combinatorics::combinationObj create "comb" $len 4]
    $comb setElements $ints
    set c [$comb nextElements]
    while {[llength $c] == 4} {
        set d1 [expr abs([lindex $c 0] * [lindex $c 1] - [lindex $c 2] * [lindex $c 3])]
        set d2 [expr abs([lindex $c 0] * [lindex $c 2] - [lindex $c 1] * [lindex $c 3])]
        set d3 [expr abs([lindex $c 0] * [lindex $c 3] - [lindex $c 1] * [lindex $c 2])]
        set d  [expr max($d1, $d2, $d3)]
        if {![info exists max_diff] || $d > $max_diff} {
            set max_diff $d
        }
        set c [$comb nextElements]
    }
    $comb destroy
    return $max_diff
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       max_diff [lindex $case 0]
    } [lindex $case 1]
}

exit 0

