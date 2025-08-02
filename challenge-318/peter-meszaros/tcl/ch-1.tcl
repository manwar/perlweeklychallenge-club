#!/usr/bin/env tclsh
#
# Task 1: Group Position
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string of lowercase letters.
# 
# Write a script to find the position of all groups in the given string. Three or
# more consecutive letters form a group. Return "” if none found.
# 
# Example 1
# 
#     Input: $str = "abccccd"
#     Output: "cccc"
# 
# Example 2
# 
#     Input: $str = "aaabcddddeefff"
#     Output: "aaa", "dddd", "fff"
# 
# Example 3
# 
#     Input: $str = "abcdd"
#     Output: ""
# 

package require tcltest

set cases {
    {abccccd        {cccc}         "Example 1"}
    {aaabcddddeefff {aaa dddd fff} "Example 2"}
    {abcdd          {}             "Example 3"}
}

proc group_position {str} {
    set groups {}

    set pos 0
    while {[regexp -expanded -indices -start $pos "(\[a-z\])\\1{2,}" $str match]} {
        set pos [lindex $match 1]
        lappend groups [string range $str [lindex $match 0] [lindex $match 1]]
    }

    return $groups
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       group_position [lindex $case 0]
    } [lindex $case 1]
}

exit 0

