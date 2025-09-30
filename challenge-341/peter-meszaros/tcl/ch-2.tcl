#!/usr/bin/env tclsh
#
# Task 2: Reverse Prefix
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str and a character in the given string, $char.
# 
# Write a script to reverse the prefix upto the first occurrence of the given
# $char in the given string $str and return the new string.
# 
# Example 1
# 
#     Input: $str = "programming", $char = "g"
#     Output: "gorpramming"
# 
#     Reverse of prefix "prog" is "gorp".
# 
# Example 2
# 
#     Input: $str = "hello", $char = "h"
#     Output: "hello"
# 
# Example 3
# 
#     Input: $str = "abcdefghij", $char = "h"
#     Output: "hgfedcbaij"
# 
# Example 4
# 
#     Input: $str = "reverse", $char = "s"
#     Output: "srevere"
# 
# Example 5
# 
#     Input: $str = "perl", $char = "r"
#     Output: "repl"
# 

package require tcltest

set cases {
    {{"programming"  "g"} "gorpramming" "Example 1"}
    {{"hello"        "h"} "hello"       "Example 2"}
    {{"abcdefghij"   "h"} "hgfedcbaij"  "Example 3"}
    {{"reverse"      "s"} "srevere"     "Example 4"}
    {{"perl"         "r"} "repl"        "Example 5"}
}

proc reverse_prefix {p} {
    set str  [lindex $p 0]
    set char [lindex $p 1]

    set pos [string first $char $str]
    if {$pos == -1} {
        return $str
    }

    return [string reverse [string range $str 0 $pos]][string range $str [expr $pos + 1] end]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        reverse_prefix [lindex $case 0]
    } [lindex $case 1]
}

exit 0

