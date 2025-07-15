#!/usr/bin/env tclsh
#
# Task 1: Clear Digits
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string containing only lower case English letters and digits.
# 
# Write a script to remove all digits by removing the first digit and the closest
# non-digit character to its left.
# 
# Example 1
# 
#     Input: $str = "cab12"
#     Output: "c"
# 
#     Round 1: remove "1" then "b" => "ca2"
#     Round 2: remove "2" then "a" => "c"
# 
# Example 2
# 
#     Input: $str = "xy99"
#     Output: ""
# 
#     Round 1: remove "9" then "y" => "x9"
#     Round 2: remove "9" then "x" => ""
# 
# Example 3
# 
#     Input: $str = "pa1erl"
#     Output: "perl"
# 

package require tcltest

set cases {
    {"cab12"  "c"    "Example 1"}
    {"xy99"   ""     "Example 2"}
    {"pa1erl" "perl" "Example 3"}
}

proc clear_digits {str} {

    while {[regsub {[a-z][0-9]} $str {} str]} {
        ;
    }

    return $str

}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        clear_digits [lindex $case 0]
    } [lindex $case 1]
}

exit 0

