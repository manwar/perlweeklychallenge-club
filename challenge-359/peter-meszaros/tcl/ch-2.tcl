#!/usr/bin/env tclsh
#
# Task 2: String Reduction
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a word containing only alphabets, Write a function that
# repeatedly removes adjacent duplicate characters from a string until no
# adjacent duplicates remain and return the final word.
# 
# Example 1
# 
#     Input: $word = "aabbccdd"
#     Output: ""
# 
#     Iteration 1: remove "aa", "bb", "cc", "dd" => ""
# 
# Example 2
# 
#     Input: $word = "abccba"
#     Output: ""
# 
#     Iteration 1: remove "cc" => "abba"
#     Iteration 2: remove "bb" => "aa"
#     Iteration 3: remove "aa" => ""
# 
# Example 3
# 
#     Input: $word = "abcdef"
#     Output: "abcdef"
# 
#     No duplicate found.
# 
# Example 4
# 
#     Input: $word = "aabbaeaccdd"
#     Output: "aea"
# 
#     Iteration 1: remove "aa", "bb", "cc", "dd" => "aea"
# 
# Example 5
# 
#     Input: $word = "mississippi"
#     Output: "m"
# 
#     Iteration 1: Remove "ss", "ss", "pp" => "miiii"
#     Iteration 2: Remove "ii", "ii" => "m"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {   "aabbccdd"       "" "Example 1"}
    {     "abccba"       "" "Example 2"}
    {     "abcdef" "abcdef" "Example 3"}
    {"aabbaeaccdd"    "aea" "Example 4"}
    {"mississippi"      "m" "Example 5"}
}

proc string_reduction {word} {
    while {[regexp {(.)\1} $word]} {
        regsub -all {(.)\1} $word {} word
    }
    return $word
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        string_reduction [lindex $case 0]
    } [lindex $case 1]
}

exit 0

