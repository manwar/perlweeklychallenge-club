#!/usr/bin/env tclsh
#
# Task 1: Last Word
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string.
# 
# Write a script to find the length of last word in the given string.
# 
# Example 1
# 
#     Input: $str = "The Weekly Challenge"
#     Output: 9
# 
# Example 2
# 
#     Input: $str = "   Hello   World    "
#     Output: 5
# 
# Example 3
# 
#     Input: $str = "Let's begin the fun"
#     Output: 3
# 

package require tcltest

set cases {
    {"The Weekly Challenge" 9 "Example 1"}
    {"   Hello   World    " 5 "Example 2"}
    { "Let's begin the fun" 3 "Example 3"}
    { "                   " 0 "Example 4"}
}

proc last_word {str} {
    set str [string trim $str]
    
    set words [split $str " "]
    
    if {[llength $words] == 0} {
        return 0
    } else {
        return [string length [lindex $words end]]
    }
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        last_word [lindex $case 0]
    } [lindex $case 1]
}

exit 0

