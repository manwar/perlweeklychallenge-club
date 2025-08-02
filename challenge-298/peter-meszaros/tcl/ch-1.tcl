#!/usr/bin/env tclsh
#
# Task 1: Maximal Square
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an m x n binary matrix with 0 and 1 only.
# 
# Write a script to find the largest square containing only 1's and return it's
# area.
# 
# Example 1
# 
#     Input: @matrix = ([1, 0, 1, 0, 0],
#                       [1, 0, 1, 1, 1],
#                       [1, 1, 1, 1, 1],
#                       [1, 0, 0, 1, 0])
#     Output: 4
# 
#     Two maximal square found with same size marked as 'x':
# 
#     [1, 0, 1, 0, 0]
#     [1, 0, x, x, 1]
#     [1, 1, x, x, 1]
#     [1, 0, 0, 1, 0]
# 
#     [1, 0, 1, 0, 0]
#     [1, 0, 1, x, x]
#     [1, 1, 1, x, x]
#     [1, 0, 0, 1, 0]
# 
# Example 2
# 
#     Input: @matrix = ([0, 1],
#                       [1, 0])
#     Output: 1
# 
#     Two maximal square found with same size marked as 'x':
# 
#     [0, x]
#     [1, 0]
# 
# 
#     [0, 1]
#     [x, 0]
# 
# Example 3
# 
#     Input: @matrix = ([0])
#     Output: 0
# 

package require tcltest

set cases {
    {{{1 0 1 0 0}
      {1 0 1 1 1}
      {1 1 1 1 1}
      {1 0 0 1 0}} 4 "Example 1"}
    {{{0 1}
      {1 0}}       1 "Example 2"}
    {{{0}}         0 "Example 3"}
    {{{0 1 1 0 1}
      {1 1 0 1 0} 
      {0 1 1 1 0}
      {1 1 1 1 0}
      {1 1 1 1 1}
      {0 0 0 0 0}} 9 "Example 4"}
}

proc max {args} {
    return [lindex [lsort -real $args] end]
}

proc min {args} {
    return [lindex [lsort -real -decreasing $args] end]
}

# Based on ttps://www.geeksforgeeks.org/maximum-size-sub-matrix-with-all-1s-in-a-binary-matrix/
proc maximal_square {mat} {

    set n [llength $mat]
    set m [llength [lindex $mat 0]]
    set ans 0
    set dp [lrepeat [expr $n + 1] 1]
    set diagonal 0

    for {set j [expr $m - 1]} {$j >= 0} {incr j -1} {
        for {set i [expr $n - 1]} {$i >= 0} {incr i -1} {
            set tmp [lindex $dp $i]
            set l [concat [lindex $dp $i] $diagonal [lindex $dp [expr $i + 1]]]
            lset dp $i [expr [lindex [lindex $mat $i] $j] == 0 ? 0 : [expr 1 + [min {*}$l]]]
            set diagonal $tmp
            set l [concat $ans [lindex $dp $i]]
            set ans [max {*}$l]
        }
    }
    return [expr $ans ** 2]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        maximal_square [lindex $case 0]
    } [lindex $case 1]
}

exit 0

