#!/usr/bin/env tclsh
#
# Task 2: Odd Letters
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string.
# 
# Write a script to find out if each letter in the given string appeared odd
# number of times.
# 
# Example 1
# 
#     Input: $str = "weekly"
#     Output: false
# 
#     w: 1 time
#     e: 2 times
#     k: 1 time
#     l: 1 time
#     y: 1 time
# 
#     The letter 'e' appeared 2 times i.e. even.
# 
# Example 2
# 
#     Input: $str = "perl"
#     Output: true
# 
# Example 3
# 
#     Input: $source = "challenge"
#     Output: false
# 

package require tcltest

set cases {
    {"weekly"    0 "Example 1"}
    {"perl"      1 "Example 2"}
    {"challenge" 0 "Example 3"}
}

proc odd_letters {str} {
    foreach l [split $str ""] {
        dict incr counts $l
    }
    foreach letter [dict keys $counts] {
        if {[dict get $counts $letter] % 2 == 0} {
            return 0
        }
    }
    return 1
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        odd_letters [lindex $case 0]
    } [lindex $case 1]
}

exit 0

