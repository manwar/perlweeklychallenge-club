#!/usr/bin/env tclsh
#
# Task 1: Second Largest Digit
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an alphanumeric string.  Write a script to find the second
# largest distinct digit in the given string. Return -1 if none found.
# 
# Example 1
# 
#     Input: $str = "aaaaa77777"
#     Output: -1
# 
#     The only digit in the given string is 7 and there is no second digit.
# 
# Example 2
# 
#     Input: $str = "abcde"
#     Output: -1
# 
#     No numerical digits in the given string.
# 
# Example 3
# 
#     Input: $str = "9zero8eight7seven9"
#     Output: 8
# 
# Example 4
# 
#     Input: $str = "xyz9876543210"
#     Output: 8
# 
# Example 5
# 
#     Input: $str = "4abc4def2ghi8jkl2"
#     Output: 4
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"aaaaa77777"        -1 "Example 1"}
    {"abcde"             -1 "Example 2"}
    {"9zero8eight7seven9" 8 "Example 3"}
    {"xyz9876543210"      8 "Example 4"}
    {"4abc4def2ghi8jkl2"  4 "Example 5"}
}

proc second_largest_digit {str} {
    set digits {}
    foreach char [split $str ""] {
        if {[string is digit $char]} {
            lappend digits $char
        }
    }
    set unique_digits [lsort -unique $digits]
    if {[llength $unique_digits] < 2} {
        return -1
    } else {
        return [lindex $unique_digits end-1]
    }
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        second_largest_digit [lindex $case 0]
    } [lindex $case 1]
}

exit 0

