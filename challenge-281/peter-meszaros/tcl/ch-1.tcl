#!/usr/bin/env tclsh
#
# Task 1: Check Color
#
# Submitted by: Mohammad Sajid Anwar
#
# You are given coordinates, a string that represents the coordinates of a square
# of the chessboard as shown below:
#
#      +-+-+-+-+-+-+-+-+
#    8 | |#| |#| |#| |#|
#    7 |#| |#| |#| |#| |
#    6 | |#| |#| |#| |#|
#    5 |#| |#| |#| |#| |
#    4 | |#| |#| |#| |#|
#    3 |#| |#| |#| |#| |
#    2 | |#| |#| |#| |#|
#    1 |#| |#| |#| |#| |
#      +-+-+-+-+-+-+-+-+
#       a b c d e f g h
#
# Write a script to return true if the square is light, and false if the square
# is dark.
#
# Example 1
#
#    Input: $coordinates = "d3"
#    Output: true
#
# Example 2
#
#    Input: $coordinates = "g5"
#    Output: false
#
# Example 3
#
#    Input: $coordinates = "e6"
#    Output: true

package require tcltest

set cases {
    {d3 1 "Example 1"}
    {g5 0 "Example 2"}
    {e6 1 "Example 3"}
}

proc check_color {pos} {
    set l [split $pos {}]
    return [expr ([scan [lindex $l 0] %c] + [lindex $l 1]) % 2]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        check_color [lindex $case 0]
    } [lindex $case 1]
}

exit 0
