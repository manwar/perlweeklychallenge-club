#!/usr/bin/env tclsh
#
# Task 2: Friendly Strings
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two strings.
# 
# Write a script to return true if swapping any two letters in one string match
# the other string, return false otherwise.
# 
# Example 1
# 
#     Input: $str1 = "desc", $str2 = "dsec"
#     Output: true
# 
# Example 2
# 
#     Input: $str1 = "fuck", $str2 = "fcuk"
#     Output: true
# 
# Example 3
# 
#     Input: $str1 = "poo", $str2 = "eop"
#     Output: false
# 
# Example 4
# 
#     Input: $str1 = "stripe", $str2 = "sprite"
#     Output: true
# 

package require tcltest

set cases {
    {{"desc"   "dsec"}   1 "Example 1"}
    {{"fuck"   "fcuk"}   1 "Example 2"}
    {{"poo"    "eop"}    0 "Example 3"}
    {{"stripe" "sprite"} 1 "Example 4"}
}

proc friendly_strings {p} {
    set str1 [lindex $p 0]
    set str2 [lindex $p 1]

    if {[string length $str1] != [string length $str2]} {
        return 0
    }

    set rep {}
    for {set i 0} {$i < [string length $str1]} {incr i} {
        if {[string index $str1 $i] ne [string index $str2 $i]} {
            if {[llength $rep] >= 2} {
                return 0
            }
            lappend rep $i
        }
    }

    if {[string index $str1 [lindex $rep 0]] eq [string index $str2 [lindex $rep 1]] && \
        [string index $str1 [lindex $rep 1]] eq [string index $str2 [lindex $rep 0]]} {
        return 1
    } else {
        return 0
    }
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        friendly_strings [lindex $case 0]
    } [lindex $case 1]
}

exit 0

