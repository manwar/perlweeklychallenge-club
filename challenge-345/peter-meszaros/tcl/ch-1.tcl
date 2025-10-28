#!/usr/bin/env tclsh
#
# Task 1: Peak Positions
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of integers, @ints.
# 
# Find all the peaks in the array, a peak is an element that is strictly greater
# than its left and right neighbours. Return the indices of all such peak
# positions.
# 
# Example 1
# 
#     Input: @ints = (1, 3, 2)
#     Output: (1)
# 
# Example 2
# 
#     Input: @ints = (2, 4, 6, 5, 3)
#     Output: (2)
# 
# Example 3
# 
#     Input: @ints = (1, 2, 3, 2, 4, 1)
#     Output: (2, 4)
# 
# Example 4
# 
#     Input: @ints = (5, 3, 1)
#     Output: (0)
# 
# Example 5
# 
#     Input: @ints = (1, 5, 1, 5, 1, 5, 1)
#     Output: (1, 3, 5)
# 

package require tcltest

set cases {
    {{1 3 2}             {1} "Example 1"}
    {{2 4 6 5 3}         {2} "Example 2"}
    {{1 2 3 2 4 1}     {2 4} "Example 3"}
    {{5 3 1}             {0} "Example 4"}
    {{1 5 1 5 1 5 1} {1 3 5} "Example 5"}
}

proc peak_positions {ints} {
    set peaks {}
    set len [llength $ints]
    for {set i 0} {$i < $len} {incr i} {
        if {$i == 0} {
            if {[lindex $ints $i] > [lindex $ints [expr $i + 1]]} {
                lappend peaks $i
            }
        } elseif {$i == [expr {$len - 1}]} {
            if {[lindex $ints $i] > [lindex $ints [expr $i - 1]]} {
                lappend peaks $i
            }
        } else {
            if {[lindex $ints $i] > [lindex $ints [expr $i - 1]] &&
                [lindex $ints $i] > [lindex $ints [expr $i + 1]]} {
                lappend peaks $i
            }
        }
    }
    return $peaks

}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        peak_positions [lindex $case 0]
    } [lindex $case 1]
}

exit 0

