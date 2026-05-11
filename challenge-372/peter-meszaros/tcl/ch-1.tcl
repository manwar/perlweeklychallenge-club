#!/usr/bin/env tclsh
#
# Task 1: Rearrange Spaces
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string text of words that are placed among number of spaces.
# Write a script to rearrange the spaces so that there is an equal number of
# spaces between every pair of adjacent words and that number is maximised. If
# you can't distribute, place the extra speaces at the end. Finally return the
# string.
# 
# Example 1
# 
#     Input: $str = "  challenge  "
#     Output: "challenge    "
# 
#     We have 4 spaces and 1 word. So all spaces go to the end.
# 
# Example 2
# 
#     Input: $str = "coding  is  fun"
#     Output: "coding  is  fun"
# 
#     We have 4 spaces and 3 words (2 gaps). So 2 spaces per gap.
# 
# Example 3
# 
#     Input: $str = "a b c  d"
#     Output: "a b c d "
# 
#     We have 4 spaces and 4 words (3 gaps). So 1 space per gap and 1 remainder.
# 
# Example 4
# 
#     Input: $str = "  team      pwc  "
#     Output: "team          pwc"
# 
#     We have 10 spaces and 2 words (1 gap). So 10 spaces per gap.
# 
# Example 5
# 
#     Input: $str = "   the  weekly  challenge  "
#     Output: "the    weekly    challenge "
# 
#     We have 9 spaces and 3 words (2 gaps). So 4 spaces per gap and 1 remainder.
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"  challenge  "               "challenge    "               "Example 1"}
    {"coding  is  fun"             "coding  is  fun"             "Example 2"}
    {"a b c  d"                    "a b c d "                    "Example 3"}
    {"  team      pwc  "           "team          pwc"           "Example 4"}
    {"   the  weekly  challenge  " "the    weekly    challenge " "Example 5"}
}

proc rearrange_spaces {str} {
    set words [regexp -all -inline {\S+} $str]
    set spaces [regexp -all { } $str]
    set gaps [expr [llength $words] - 1]

    if {$gaps == 0} {
        set per_gap 0
        set remainder $spaces
    } else {
        set per_gap [expr $spaces / $gaps]
        set remainder [expr $spaces % $gaps]
    }
    return "[join $words [string repeat " " $per_gap]][string repeat " " $remainder]"
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        rearrange_spaces [lindex $case 0]
    } [lindex $case 1]
}

exit 0

