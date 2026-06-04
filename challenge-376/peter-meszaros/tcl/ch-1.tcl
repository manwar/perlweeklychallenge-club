#!/usr/bin/env tclsh
#
# Task 1: Chessboard Squares
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two coordinates of a square on 8x8 chessboard.
# Write a script to find the given two coordinates have the same colour.
# 
#     8 W B W B W B W B
#     7 B W B W B W B W
#     6 W B W B W B W B
#     5 B W B W B W B W
#     4 W B W B W B W B
#     3 B W B W B W B W
#     2 W B W B W B W B
#     1 B W B W B W B W
#       a b c d e f g h
# 
# Example 1
# 
#     Input: $c1 = "a7", $c2 = "f4"
#     Output: true
# 
# Example 2
# 
#     Input: $c1 = "c1", $c2 = "e8"
#     Output: false
# 
# Example 3
# 
#     Input: $c1 = "b5", $c2 = "h2"
#     Output: false
# 
# Example 4
# 
#     Input: $c1 = "f3", $c2 = "h1"
#     Output: true
# 
# Example 5
# 
#     Input: $c1 = "a1", $c2 = "g8"
#     Output: false
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{"a7" "f4"} true  "Example 1"}
    {{"c1" "e8"} false "Example 2"}
    {{"b5" "h2"} false "Example 3"}
    {{"f3" "h1"} true  "Example 4"}
    {{"a1" "g8"} false "Example 5"}
}

proc chessboard_squares {p} {
    set c1 [lindex $p 0]
    set c2 [lindex $p 1]

    set x1 [expr [scan [string index $c1 0] %c] - [scan "a" %c] + 1]
    set y1 [string index $c1 1]
    set x2 [expr [scan [string index $c2 0] %c] - [scan "a" %c] + 1]
    set y2 [string index $c2 1]
    
    return [expr {[expr ($x1 + $y1) % 2] == [expr ($x2 + $y2) % 2] ? true : false}]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        chessboard_squares [lindex $case 0]
    } [lindex $case 1]
}

exit 0

