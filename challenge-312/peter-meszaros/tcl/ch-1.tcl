#!/usr/bin/env tclsh
#
# Task 1: Minimum Time
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a typewriter with lowercase english letters a to z arranged in a circle.
# 
# Typing a character takes 1 sec. You can move pointer one character clockwise or
# anti-clockwise.
# 
# The pointer initially points at a.
# 
# Write a script to return minimum time it takes to print the given string.
# 
# Example 1
# 
#     Input: $str = "abc"
#     Output: 5
# 
#     The pointer is at 'a' initially.
#     1 sec - type the letter 'a'
#     1 sec - move pointer clockwise to 'b'
#     1 sec - type the letter 'b'
#     1 sec - move pointer clockwise to 'c'
#     1 sec - type the letter 'c'
# 
# Example 2
# 
#     Input: $str = "bza"
#     Output: 7
# 
#     The pointer is at 'a' initially.
#     1 sec - move pointer clockwise to 'b'
#     1 sec - type the letter 'b'
#     1 sec - move pointer anti-clockwise to 'a'
#     1 sec - move pointer anti-clockwise to 'z'
#     1 sec - type the letter 'z'
#     1 sec - move pointer clockwise to 'a'
#     1 sec - type the letter 'a'
# 
# Example 3
# 
#     Input: $str = "zjpc"
#     Output: 34
# 

package require tcltest

set cases {
    {"abc"   5 "Example 1"}
    {"bza"   7 "Example 2"}
    {"zjpc" 34 "Example 3"}
}

proc minimum_time {str} {
    set time 0
    set pos 0
    foreach c [split $str ""] {
        set new_pos [expr {[scan $c %c] - 97}]
        set diff [expr {abs($new_pos - $pos)}]
        incr time [expr {$diff > 13 ? 26 - $diff : $diff}]
        set pos $new_pos
        incr time
    }
    return $time
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       minimum_time [lindex $case 0]
    } [lindex $case 1]
}

exit 0
