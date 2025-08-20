#!/usr/bin/env tclsh
#
# Task 1: Common Characters
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given an array of words.
# 
# Write a script to return all characters that is in every word in the given
# array including duplicates.
# 
# Example 1
# 
#     Input: @words = ("bella", "label", "roller")
#     Output: ("e", "l", "l")
# 
# Example 2
# 
#     Input: @words = ("cool", "lock", "cook")
#     Output: ("c", "o")
# 
# Example 3
# 
#     Input: @words = ("hello", "world", "pole")
#     Output: ("l", "o")
# 
# Example 4
# 
#     Input: @words = ("abc", "def", "ghi")
#     Output: ()
# 
# Example 5
# 
#     Input: @words = ("aab", "aac", "aaa")
#     Output: ("a", "a")
# 

package require tcltest

set cases {
    {{bella label roller} {e l l} "Example 1"}
    {{cool lock cook}     {c o}   "Example 2"}
    {{hello world pole}   {l o}   "Example 3"}
    {{abc def ghi}        {}      "Example 4"}
    {{aab aac aaa}        {a a}   "Example 5"}
}

proc common_characters {words} {
    foreach word $words {
        foreach char [split $word ""] {
            incr char_count($char)
        }
    }

    set common_chars {}
    foreach char [lsort [array names char_count]] {
        set min_count $char_count($char)
        foreach word $words {
            set count [regexp -all -- $char $word]
            if {$count < $min_count} {
                set min_count $count
            }
        }
        for {set i 0} {$i < $min_count} {incr i} {
            lappend common_chars $char
        }
    }
    return $common_chars
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        common_characters [lindex $case 0]
    } [lindex $case 1]
}

exit 0

