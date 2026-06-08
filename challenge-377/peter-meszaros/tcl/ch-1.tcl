#!/usr/bin/env tclsh
#
# Task 1: Reverse Existence
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string.  Write a script to find whether any substring of length
# 2 is also present in the reverse of the given string.
# 
# Example 1
# 
#     Input: $str = "abcba"
#     Output: true
# 
#     Reverse of given string is "abcba".
#     The substring "ab" in original string is also present in the reverse string too.
# 
# Example 2
# 
#     Input: $str = "racecar"
#     Output: true
# 
#     The substring "ce" is present in both.
# 
# Example 3
# 
#     Input: $str = "abcd"
#     Output: false
# 
# Example 4
# 
#     Input: $str = "banana"
#     Output: true
# 
#     The substring "an" is present in both.
# 
# Example 5
# 
#     Input: $str = "hello"
#     Output: true
# 
#     The substring "ll" is present in both.
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"abcba"   true  "Example 1"}
    {"racecar" true  "Example 2"}
    {"abcd"    false "Example 3"}
    {"banana"  true  "Example 4"}
    {"hello"   true  "Example 5"}
}

proc reverse_existence {str} {
    set rev [string reverse $str]

    for {set i 0} {$i < [string length $str] - 1} {incr i} {
        if {[string first [string range $str $i [expr $i + 1]] $rev] != -1} {
            return true
        }
    }
    return false
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        reverse_existence [lindex $case 0]
    } [lindex $case 1]
}

exit 0

