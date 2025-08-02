#!/usr/bin/env tclsh
#
# Task 2: Buddy Strings
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two strings, source and target.
# 
# Write a script to find out if the given strings are Buddy Strings.
# 
# If swapping of a letter in one string make them same as the other then they are
# `Buddy Strings`.
# 
# Example 1
# 
#     Input: $source = "fuck"
#            $target = "fcuk"
#     Output: true
# 
#     The swapping of 'u' with 'c' makes it buddy strings.
# 
# Example 2
# 
#     Input: $source = "love"
#            $target = "love"
#     Output: false
# 
# Example 3
# 
#     Input: $source = "fodo"
#            $target = "food"
#     Output: true
# 
# Example 4
# 
#     Input: $source = "feed"
#            $target = "feed"
#     Output: true
# 

package require tcltest

set cases {
    {{"fuck" "fcuk"} 1 "Example 1"}
    {{"love" "love"} 0 "Example 2"}
    {{"fodo" "food"} 1 "Example 3"}
    {{"feed" "feed"} 1 "Example 4"}
}

proc buddy_strings {strs} {
    set source [lindex $strs 0]
    set target [lindex $strs 1]

    set buddy 0
    if {[string length $source] == [string length $target]} {
        for {set i 0} {$i < [string length $source]} {incr i} {
            set j [string first [string index $source $i] $target [expr $i + 1]]
            if {$j != -1 && [string index $source $j] eq [string index $target $i]} {
                if {$buddy} {
                    set buddy 0
                    break
                }
                set buddy 1
            }
        }
    }

    return $buddy
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        buddy_strings [lindex $case 0]
    } [lindex $case 1]
}

exit 0

