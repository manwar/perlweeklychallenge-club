#!/usr/bin/env tclsh
#
# Task 1: Consecutive Sequence
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an unsorted array of integers, @ints.
# 
# Write a script to return the length of the longest consecutive elements
# sequence. Return -1 if none found. The algorithm must runs in O(n) time.
# 
# Example 1
# 
#     Input: @ints = (10, 4, 20, 1, 3, 2)
#     Output: 4
# 
#     The longest consecutive sequence (1, 2, 3, 4).
#     The length of the sequence is 4.
# 
# Example 2
# 
#     Input: @ints = (0, 6, 1, 8, 5, 2, 4, 3, 0, 7)
#     Output: 9
# 
# Example 3
# 
#     Input: @ints = (10, 30, 20)
#     Output: -1
# 

package require tcltest

set cases {
    {{10  4 20 1 3 2}         4 "Example 1"}
    {{0   6  1 8 5 2 4 3 0 7} 9 "Example 2"}
    {{10 30 20}              -1 "Example 3"}
}

proc max args {
    lindex [lsort -real $args] end
}

proc consecutive_sequence {l} {
    set ls [lsort -integer $l]
    set seq {}
    set cnt 1
    for {set i 1} {$i < [llength $ls]} {incr i} {
        if {[lindex $ls $i] == [expr [lindex $ls [expr $i - 1]] + 1]} {
            incr cnt
        } elseif {$cnt > 1} {
            lappend seq $cnt
            set cnt 1
        }
    }
    if {$cnt > 1} {
        lappend seq $cnt
    }

    set m [max {*}$seq]
    if {$m == ""} {
        set m -1
    }
    return $m
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       consecutive_sequence [lindex $case 0]
    } [lindex $case 1]
}

exit 0
