#!/usr/bin/env tclsh
#
# Task 2: Valid Token Counter
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a sentence.  Write a script to split the given sentence into
# space-separated tokens and count how many are valid words. A token is valid if
# it contains no digits, has at most one hyphen surrounded by lowercase letters,
# and at most one punctuation mark (!, ., ,) appearing only at the end.
# 
# Example 1
# 
#     Input: $str = "cat and dog"
#     Output: 3
# 
#     Tokens: "cat", "and", "dog"
# 
# Example 2
# 
#     Input: $str = "a-b c! d,e"
#     Output: 2
# 
#     Tokens: "a-b", "c!", "d,e"
#     "a-b" -> valid (one hyphen between letters)
#     "c!"  -> valid (punctuation at end)
#     "d,e" -> invalid (punctuation not at end)
# 
# Example 3
# 
#     Input: $str = "hello-world! this is fun"
#     Output: 4
# 
#     Tokens: "hello-world!", "this", "is", "fun"
#     All satisfy the rules.
# 
# Example 4
# 
#     Input: $str = "ab- cd-ef gh- ij!"
#     Output: 2
# 
#     Tokens: "ab-", "cd-ef", "gh-", "ij!"
#     "ab-"   -> invalid (hyphen not surrounded by letters)
#     "cd-ef" -> valid
#     "gh-"   -> invalid
#     "ij!"   -> valid
# 
# Example 5
# 
#     Input: $str = "wow! a-b-c nice."
#     Output: 2
# 
#     Tokens: "wow!", "a-b-c", "nice."
#     "wow!"  -> valid
#     "a-b-c" -> invalid (more than one hyphen)
#     "nice." -> valid
# 

package require Tcl 8.6
package require tcltest

set cases {
    {             "cat and dog" 3 "Example 1"}
    {              "a-b c! d,e" 2 "Example 2"}
    {"hello-world! this is fun" 4 "Example 3"}
    {       "ab- cd-ef gh- ij!" 2 "Example 4"}
    {        "wow! a-b-c nice." 2 "Example 5"}
}

proc valid_token_counter {str} {
    set count 0
    foreach token [split $str] {
        if {[regexp {^[a-z]+(-[a-z]+)?[!.,]?$} $token]} {
            incr count
        }
    }
    return $count
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        valid_token_counter [lindex $case 0]
    } [lindex $case 1]
}

exit 0

