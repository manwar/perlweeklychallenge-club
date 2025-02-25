#!/usr/bin/env tclsh
#
# Task 2: Right Interval
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of @intervals, where $intervals[i] = [starti, endi] and
# each starti is unique.
# 
# The right interval for an interval i is an interval j such that startj >= endi
# and startj is minimized. Please note that i may equal j.
# 
# Write a script to return an array of right interval indices for each interval
# i. If no right interval exists for interval i, then put -1 at index i.
# 
# Example 1
# 
#     Input: @intervals = ([3,4], [2,3], [1,2])
#     Output: (-1, 0, 1)
# 
#     There is no right interval for [3,4].
#     The right interval for [2,3] is [3,4] since start0 = 3 is the smallest
#     start that is >= end1 = 3.
#     The right interval for [1,2] is [2,3] since start1 = 2 is the smallest
#     start that is >= end2 = 2.
# 
# Example 2
# 
#     Input: @intervals = ([1,4], [2,3], [3,4])
#     Output: (-1, 2, -1)
# 
#     There is no right interval for [1,4] and [3,4].
#     The right interval for [2,3] is [3,4] since start2 = 3 is the smallest
#     start that is >= end1 = 3.
# 
# Example 3
# 
#     Input: @intervals = ([1,2])
#     Output: (-1)
# 
#     There is only one interval in the collection, so it outputs -1.
# 
# Example 4
# 
#     Input: @intervals = ([1,4], [2, 2], [3, 4])
#     Output: (-1, 1, -1)
# 

package require tcltest

set cases {
    {{{3 4}  {2 3}  {1 2}}   {-1 0 1}  "Example 1"} 
    {{{1 4}  {2 3}  {3 4}}   {-1 2 -1} "Example 2"} 
    {{{1 2}}                 {-1}      "Example 3"} 
    {{{1 4}  {2  2}  {3  4}} {-1 1 -1} "Example 4"} 
}

proc right_interval {l} {
    set len [llength $l]
    set ret {}
    for {set i 0} {$i < $len} {incr i} {
        set int1 [lindex $l $i]
        lset ret $i -1
        for {set j 0} {$j < $len} {incr j} {
            set int2 [lindex $l $j]
            if {[lindex $int2 0] == [lindex $int1 1]} {
                lset ret $i $j
                break
            } elseif {[lindex $int2 0] > [lindex $int1 1]} {
                if {[lindex $ret $i] == -1 || $j < [lindex $ret $i]} {
                    lset ret $i $j
                }
            }
        }
    }
    return $ret
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       right_interval [lindex $case 0]
    } [lindex $case 1]
}

exit 0

