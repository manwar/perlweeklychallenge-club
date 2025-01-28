#!/usr/bin/env tclsh
#
# Task 2: Last Element
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a array of integers, @ints.
# 
# Write a script to play a game where you pick two biggest integers in the given
# array, say x and y. Then do the following:
# 
#     a) if x == y then remove both from the given array
#     b) if x != y then remove x and replace y with (y - x)
# 
# At the end of the game, there is at most one element left.
# 
# Return the last element if found otherwise return 0.
# 
# Example 1
# 
#     Input: @ints = (3, 8, 5, 2, 9, 2)
#     Output: 1
# 
#     Step 1: pick 8 and 9 => (3, 5, 2, 1, 2)
#     Step 2: pick 3 and 5 => (2, 2, 1, 2)
#     Step 3: pick 2 and 1 => (1, 2, 2)
#     Step 4: pick 2 and 1 => (1, 2)
#     Step 5: pick 1 and 2 => (1)
# 
# Example 2
# 
#     Input: @ints = (3, 2, 5)
#     Output: 0
# 
#     Step 1: pick 3 and 5 => (2, 2)
#     Step 2: pick 2 and 2 => ()
# 

package require tcltest

set cases {
    {{3 8 5 2 9 2} 1 "Example 1"}
    {{3 2 5}       0 "Example 2"}
}

proc last_element {p} {
    while {[llength $p] > 1} {
        set sorted [lsort -integer -decreasing $p]
        set x [lindex $sorted 0]
        set y [lindex $sorted 1]
        set sorted [lreplace $sorted 0 1]

        if {$x != $y} {
            lappend sorted [expr $x - $y]
        }
        set p $sorted
    }
    
    return [expr {[llength $p] ? [lindex $p 0] : 0}]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       last_element [lindex $case 0]
    } [lindex $case 1]
}

exit 0
