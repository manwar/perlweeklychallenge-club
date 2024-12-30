#!/usr/bin/env tclsh
#
# Task 1: Ones and Zeroes
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of binary strings, @str, and two integers, $x and $y.
# 
# Write a script to return the size of the largest subset of @str such that there
# are at most $x 0's and $y 1's in the subset.
# 
# A set m is a subset of n if all elements of m are also elements of n.
# 
# Example 1
# 
#     Input: @str = ("10", "0001", "111001", "1", "0")
#            $x = 5
#            $y = 3
#     Output: 4
# 
#     The largest subset with at most five 0's and three 1's: ("10", "0001", "1",
#     "0")
# 
# Example 2
# 
#     Input: @str = ("10", "1", "0")
#            $x = 1
#            $y = 1
#     Output: 2
# 
#     The largest subset with at most one 0's and one 1's: ("1", "0")
# 

package require tcltest

set cases {
    {{{"10" "0001" "111001" "1" "0"} 5 3} 4 "Example 1"}
    {{{"10"    "1"      "0"}         1 1} 3 "Example 2"}
}

proc ones_and_zeroes {p} {
    set l [lindex $p 0]
    set x [lindex $p 1]
    set y [lindex $p 2]
    set cnt 0
    foreach i $l {
        set z [regexp -all "0" $i]
        set o [regexp -all "1" $i]
        if {$z <= $x && $o <= $y} {
            incr cnt
        }
    }
    return $cnt
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       ones_and_zeroes [lindex $case 0]
    } [lindex $case 1]
}

exit 0

