#!/usr/bin/env tclsh
#
# Task 2: Largest Substring
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string.  Write a script to return the length of the largest
# substring between two equal characters excluding the two characters. Return -1
# if there is no such substring.
# 
# Example 1
# 
#     Input: $str = "aaaaa"
#     Output: 3
# 
#     For character "a", we have substring "aaa".
# 
# Example 2
# 
#     Input: $str = "abcdeba"
#     Output: 5
# 
#     For character "a", we have substring "bcdeb".
# 
# Example 3
# 
#     Input: $str = "abbc"
#     Output: 0
# 
#     For character "b", we have substring "".
# 
# Example 4
# 
#     Input: $str = "abcaacbc"
#     Output: 4
# 
#     For character "a", we have substring "bca".
#     For character "b", we have substring "caac".
#     For character "c", we have substring "aacb".
# 
# Example 5
# 
#     Input: $str = "laptop"
#     Output: 2
# 
#     For character "p", we have substring "to".
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"aaaaa"    3 "Example 1"}
    {"abcdeba"  5 "Example 2"}
    {"abbc"     0 "Example 3"}
    {"abcaacbc" 4 "Example 4"}
    {"laptop"   2 "Example 5"}
}

proc largest_substring {str} {
    set seen {}
    set max -1

    for {set i 0} {$i < [string length $str]} {incr i} {
        set c [string index $str $i]
        if {[dict exists $seen $c]} {
            set len [expr $i - [dict get $seen $c] - 1]
            if {$len > $max} {
                set max $len
            }
        } else {
            dict set seen $c $i
        }
    }

    return $max
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        largest_substring [lindex $case 0]
    } [lindex $case 1]
}

exit 0

