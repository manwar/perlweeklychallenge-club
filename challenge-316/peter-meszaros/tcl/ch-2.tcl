#!/usr/bin/env tclsh
#
# Task 2: Subsequence
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given two string.
# 
# Write a script to find out if one string is a subsequence of another.
# 
# A subsequence of a string is a new string that is formed from the original
# string by deleting some (can be none)  of the characters without disturbing the
# relative positions of the remaining characters.
# 
# Example 1
# 
#     Input: $str1 = "uvw", $str2 = "bcudvew"
#     Output: true
# 
# Example 2
# 
#     Input: $str1 = "aec", $str2 = "abcde"
#     Output: false
# 
# Example 3
# 
#     Input: $str1 = "sip", $str2 = "javascript"
#     Output: true
# 

package require tcltest

set cases {
    {{"uvw" "bcudvew"}    1 "Example 1"}
    {{"aec" "abcde"}      0 "Example 2"}
    {{"sip" "javascript"} 1 "Example 3"}
}

proc subsequence {strs} {
    set str1 [lindex $strs 0]
    set str2 [lindex $strs 1]

    set re [join [split $str1 ""] ".*"]
    return [regexp $re $str2]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
       subsequence [lindex $case 0]
    } [lindex $case 1]
}

exit 0

