#!/usr/bin/env tclsh
#
# Task 1: Highest Row
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a m x n matrix.
# 
# Write a script to find the highest row sum in the given matrix.
# 
# Example 1
# 
#     Input: @matrix = ([4,  4, 4, 4],
#                       [10, 0, 0, 0],
#                       [2,  2, 2, 9])
#     Output: 16
# 
#     Row 1: 4  + 4 + 4 + 4 => 16
#     Row 2: 10 + 0 + 0 + 0 => 10
#     Row 3: 2  + 2 + 2 + 9 => 15
# 
# Example 2
# 
#     Input: @matrix = ([1, 5],
#                       [7, 3],
#                       [3, 5])
#     Output: 10
# 
# Example 3
# 
#     Input: @matrix = ([1, 2, 3],
#                       [3, 2, 1])
#     Output: 6
# 
# Example 4
# 
#     Input: @matrix = ([2, 8, 7],
#                       [7, 1, 3],
#                       [1, 9, 5])
#     Output: 17
# 
# Example 5
# 
#     Input: @matrix = ([10, 20,  30],
#                       [5,  5,   5],
#                       [0,  100, 0],
#                       [25, 25,  25])
#     Output: 100
# 

package require tcltest

set cases {
    {{{ 4  4 4 4}
      {10  0 0 0}
      { 2  2 2 9}}  16 "Example 1"}
    {{{1 5}
      {7 3}
      {3 5}}        10 "Example 2"}
    {{{1 2 3}
      {3 2 1}}       6 "Example 3"}
    {{{2 8 7}
      {7 1 3}
      {1 9 5}}      17 "Example 4"}
    {{{10  20 30}
      { 5   5  5}
      { 0 100  0}
      {25  25 25}} 100 "Example 5"}
}

proc highest_row {m} {
    set max 0
    foreach row $m {
        set sum 0
        foreach val $row {
            set sum [expr $sum + $val]
        }
        if {$sum > $max} {
            set max $sum
        }
    }
    return $max
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        highest_row [lindex $case 0]
    } [lindex $case 1]
}

exit 0

