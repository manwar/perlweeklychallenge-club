#!/usr/bin/env tclsh
#
# Task 2: Semi-Ordered Permutation
#
# Submitted by: Mohammad Sajid Anwar
#
# You are given permutation of $n integers, @ints.
#
# Write a script to find the minimum number of swaps needed to make the @ints a
# semi-ordered permutation.
#
#     A permutation is a sequence of integers from 1 to n of length n containing
#     each number exactly once.
#
#     A permutation is called semi-ordered if the first number is 1 and the last
#     number equals n.
#
# You are ONLY allowed to pick adjacent elements and swap them.
#
# Example 1
#
#     Input: @ints = (2, 1, 4, 3)
#     Output: 2
#
#     Swap 2 <=> 1 => (1, 2, 4, 3)
#     Swap 4 <=> 3 => (1, 2, 3, 4)
#
# Example 2
#
#     Input: @ints = (2, 4, 1, 3)
#     Output: 3
#
#     Swap 4 <=> 1 => (2, 1, 4, 3)
#     Swap 2 <=> 1 => (1, 2, 4, 3)
#     Swap 4 <=> 3 => (1, 2, 3, 4)
#
# Example 3
#
#     Input: @ints = (1, 3, 2, 4, 5)
#     Output: 0
#
#     Already a semi-ordered permutation.
#

package require tcltest

set cases {
    {{2 1 4 3}   2 "Example 1"}
    {{2 4 1 3}   3 "Example 2"}
    {{1 3 2 4 5} 0 "Example 3"}
    {{2 5 4 1 3} 5 "Example 4"}
}

proc semi_ordered_permutation {l} {

    set minidx 0
    set maxidx 0
    set len [llength $l]
    for {set i 1} {$i < $len} {incr i} {
        if {[lindex $l $i] < [lindex $l $minidx]} {
            set minidx $i
        }
        if {[lindex $l $i] > [lindex $l $maxidx]} {
            set maxidx $i
        }
    }

    return [expr $minidx + ($len - 1) - $maxidx - ($minidx > $maxidx ? 1 : 0)]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        semi_ordered_permutation [lindex $case 0]
    } [lindex $case 1]
}

exit 0
