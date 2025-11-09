#!/usr/bin/env tclsh
#
# Task 1: Longest Parenthesis
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string containing only ( and ).
# 
# Write a script to find the length of the longest valid parenthesis.
# 
# Example 1
# 
#     Input: $str = '(()())'
#     Output: 6
# 
#     Valid Parenthesis: '(()())'
# 
# Example 2
# 
#     Input: $str = ')()())'
#     Output: 4
# 
#     Valid Parenthesis: '()()' at positions 1-4.
# 
# Example 3
# 
#     Input: $str = '((()))()(((()'
#     Output: 8
# 
#     Valid Parenthesis: '((()))()' at positions 0-7.
# 
# Example 4
# 
#     Input: $str = '))))((()('
#     Output: 2
# 
#     Valid Parenthesis: '()' at positions 6-7.
# 
# Example 5
# 
#     Input: $str = '()(()'
#     Output: 2
# 
#     Valid Parenthesis: '()' at positions 0-1 and 3-4.
# 

package require tcltest

set cases {
    {"(()())"        6 "Example 1"}
    {")()())"        4 "Example 2"}
    {"((()))()(((()" 8 "Example 3"}
    {"))))((()("     2 "Example 4"}
    {"()(()"         2 "Example 5"}
}

proc longest_parenthesis {s} {
    set stack {-1}
    set max_length 0

    for {set i 0} {$i < [string length $s]} {incr i} {
        set char [string index $s $i]
        if {$char eq "("} {
            lappend stack $i
        } else {
            set stack [lrange $stack 0 end-1]
            if {[llength $stack] > 0} {
                set length [expr $i - [lindex $stack end]]
                if {$length > $max_length} {
                    set max_length $length
                }
            } else {
                lappend stack $i
            }
        }
    }
    return $max_length
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        longest_parenthesis [lindex $case 0]
    } [lindex $case 1]
}

exit 0

