#!/usr/bin/env tclsh
#
# Task 1: Echo Chamber
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string containing lowercase letters.  Write a script to
# transform the string based on the index position of each character (starting
# from 0). For each character at position i, repeat it i + 1 times.
# 
# Example 1
# 
#     Input: "abca"
#     Output: "abbcccaaaa"
# 
#     Index 0: "a" -> repeated 1 time  -> "a"
#     Index 1: "b" -> repeated 2 times -> "bb"
#     Index 2: "c" -> repeated 3 times -> "ccc"
#     Index 3: "a" -> repeated 4 times -> "aaaa"
# 
# Example 2
# 
#     Input: "xyz"
#     Output: "xyyzzz"
# 
#     Index 0: "x" -> "x"
#     Index 1: "y" -> "yy"
#     Index 2: "z" -> "zzz"
# 
# Example 3
# 
#     Input: "code"
#     Output: "coodddeeee"
# 
#     Index 0: "c" -> "c"
#     Index 1: "o" -> "oo"
#     Index 2: "d" -> "ddd"
#     Index 3: "e" -> "eeee"
# 
# Example 4
# 
#     Input: "hello"
#     Output: "heelllllllooooo"
# 
#     Index 0: "h" -> "h"
#     Index 1: "e" -> "ee"
#     Index 2: "l" -> "lll"
#     Index 3: "l" -> "llll"
#     Index 4: "o" -> "ooooo"
# 
# Example 5
# 
#     Input: "a"
#     Output: "a"
# 
#     Index 0: "a" -> "a"
# 

package require Tcl 8.6
package require tcltest

set cases {
    { "abca"      "abbcccaaaa" "Example 1" }
    {  "xyz"          "xyyzzz" "Example 2" }
    { "code"      "coodddeeee" "Example 3" }
    {"hello" "heelllllllooooo" "Example 4" }
    {    "a"               "a" "Example 5" }
}

proc echo_chamber {str} {
    set cnt 0
    set result ""
    foreach char [split $str ""] {
        append result [string repeat $char [incr cnt]]
    }
    return $result
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        echo_chamber [lindex $case 0]
    } [lindex $case 1]
}

exit 0

