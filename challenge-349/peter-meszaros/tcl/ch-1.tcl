#!/usr/bin/env tclsh
#
# Task 1: Power String
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string.
# 
# Write a script to return the power of the given string.
# 
#     The power of the string is the maximum length of a non-empty substring that
#     contains only one unique character.
# 
# Example 1
# 
#     Input: $str = "textbook"
#     Output: 2
# 
#     Breakdown: "t", "e", "x", "b", "oo", "k"
#     The longest substring with one unique character is "oo".
# 
# Example 2
# 
#     Input: $str = "aaaaa"
#     Output: 5
# 
# Example 3
# 
#     Input: $str = "hoorayyy"
#     Output: 3
# 
#     Breakdown: "h", "oo", "r", "a", "yyy"
#     The longest substring with one unique character is "yyy".
# 
# Example 4
# 
#     Input: $str = "x"
#     Output: 1
# 
# Example 5
# 
#     Input: $str = "aabcccddeeffffghijjk"
#     Output: 4
# 
#     Breakdown: "aa", "b", "ccc", "dd", "ee", "ffff", "g", "h", "i", "jj", "k"
#     The longest substring with one unique character is "ffff".
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"textbook"             2 "Example 1"}
    {"aaaaa"                5 "Example 2"}
    {"hoorayyy"             3 "Example 3"}
    {"x"                    1 "Example 4"}
    {"aabcccddeeffffghijjk" 4 "Example 5"}
}

proc power_string {str} {
    set max_power 1
    set current_power 1
    set length [string length $str]
    for {set i 1} {$i < $length} {incr i} {
        if {[string index $str $i] eq [string index $str [expr $i - 1]]} {
            incr current_power
            if {$current_power > $max_power} {
                set max_power $current_power
            }
        } else {
            set current_power 1
        }
    }
    return $max_power
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        power_string [lindex $case 0]
    } [lindex $case 1]
}

exit 0

