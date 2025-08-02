#!/usr/bin/env tclsh
#
# Task 1: Counter Integers
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string containing only lower case English letters and digits.
# 
# Write a script to replace every non-digit character with a space and then
# return all the distinct integers left.
# 
# Example 1
# 
#     Input: $str = "the1weekly2challenge2"
#     Output: 1, 2
# 
#     2 is appeared twice, so we count it one only.
# 
# Example 2
# 
#     Input: $str = "go21od1lu5c7k"
#     Output: 21, 1, 5, 7
# 
# Example 3
# 
#     Input: $str = "4p3e2r1l"
#     Output: 4, 3, 2, 1
# 

package require tcltest

set cases {
    {"the1weekly2challenge2" {1 2}      "Example 1"}
    {"go21od1lu5c7k"         {21 1 5 7} "Example 2"}
    {"4p3e2r1l"              {4 3 2 1}  "Example 3"}
}

proc counter_integers {str} {
    set numbers [regexp -all -inline {(\d+)} $str]
    set counter_integers {}
    
    foreach num $numbers {
        if {![info exists seen($num)]} {
            lappend counter_integers $num
            set seen($num) 1
        }
    }
    
    return $counter_integers
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        counter_integers [lindex $case 0]
    } [lindex $case 1]
}

exit 0

