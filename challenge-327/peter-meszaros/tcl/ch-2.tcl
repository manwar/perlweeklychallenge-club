#!/usr/bin/env tclsh
#
# Task 2: MAD
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of distinct integers.
# 
# Write a script to find all pairs of elements with minimum absolute difference
# (MAD) of any two elements.
# 
# Example 1
# 
#     Input: @ints = (4, 1, 2, 3)
#     Output: [1,2], [2,3], [3,4]
# 
#     The minimum absolute difference is 1.
#     Pairs with MAD: [1,2], [2,3], [3,4]
# 
# Example 2
# 
#     Input: @ints = (1, 3, 7, 11, 15)
#     Output: [1,3]
# 
# Example 3
# 
#     Input: @ints = (1, 5, 3, 8)
#     Output: [1,3], [3,5]
# 

package require tcltest

set cases {
    {{4 1 2 3}     {{1 2} {2 3} {3 4}} "Example 1"}
    {{1 3 7 11 15} {{1 3}}             "Example 2"}
    {{1 5 3 8}     {{1 3} {3 5}}       "Example 3"}
}

proc mad {ints} {

    set sorted [lsort -integer $ints]
    set min_diff {}
    set pairs {}

    for {set i 0} {$i < [llength $sorted] - 1} {incr i} {
        set sorted_i1 [lindex $sorted [expr $i + 1]]
        set sorted_i  [lindex $sorted $i]
        set diff [expr $sorted_i1 - $sorted_i]

        if {$min_diff eq "" || $diff < $min_diff} {
            set min_diff $diff
            set pairs [list [list $sorted_i $sorted_i1]]
        } elseif {$diff == $min_diff} {
            lappend pairs [list $sorted_i $sorted_i1]
        }
    }
    return $pairs
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       mad [lindex $case 0]
    } [lindex $case 1]
}

exit 0

