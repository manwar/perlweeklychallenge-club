#!/usr/bin/env tclsh
#
# Task 1: Good Substrings
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string.
# 
# Write a script to return the number of good substrings of length three in the
# given string.
# 
#     A string is good if there are no repeated characters.
# 
# Example 1
# 
#     Input: $str = "abcaefg"
#     Output: 5
# 
#     Good substrings of length 3: abc, bca, cae, aef and efg
# 
# Example 2
# 
#     Input: $str = "xyzzabc"
#     Output: 3
# 
#     Good substrings of length 3: "xyz", "zab" and "abc"
# 
# Example 3
# 
#     Input: $str = "aababc"
#     Output: 1
# 
#     Good substrings of length 3: "abc"
# 
# Example 4
# 
#     Input: $str = "qwerty"
#     Output: 4
# 
#     Good substrings of length 3: "qwe", "wer", "ert" and "rty"
# 
# Example 5
# 
#     Input: $str = "zzzaaa"
#     Output: 0
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"abcaefg" 5 "Example 1"}
    {"xyzzabc" 3 "Example 2"}
    {"aababc"  1 "Example 3"}
    {"qwerty"  4 "Example 4"}
    {"zzzaaa"  0 "Example 5"}
}

proc good_substrings {str} {
    set len [string length $str]
    set count 0

    for {set i 0} {$i <= $len - 3} {incr i} {
        set substr [string range $str $i [expr $i + 2]]
        set chars [split $substr ""]

        if {[lindex $chars 0] ne [lindex $chars 1] &&
            [lindex $chars 0] ne [lindex $chars 2] &&
            [lindex $chars 1] ne [lindex $chars 2]} {
            incr count
        }
    }

    return $count
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        good_substrings [lindex $case 0]
    } [lindex $case 1]
}

exit 0

