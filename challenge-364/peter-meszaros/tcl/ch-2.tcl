#!/usr/bin/env tclsh
#
# Task 2: Goal Parser
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string, $str.  Write a script to interpret the given string
# using Goal Parser.  The Goal Parser interprets "G" as the string "G", "()" as
# the string "o", and "(al)" as the string "al". The interpreted strings are then
# concatenated in the original order.
# 
# Example 1
# 
#     Input: $str = "G()(al)"
#     Output: "Goal"
# 
#     G    -> "G"
#     ()   -> "o"
#     (al) -> "al"
# 
# Example 2
# 
#     Input: $str = "G()()()()(al)"
#     Output: "Gooooal"
# 
#     G       -> "G"
#     four () -> "oooo"
#     (al)    -> "al"
# 
# Example 3
# 
#     Input: $str = "(al)G(al)()()"
#     Output: "alGaloo"
# 
#     (al) -> "al"
#     G    -> "G"
#     (al) -> "al"
#     ()   -> "o"
#     ()   -> "o"
# 
# Example 4
# 
#     Input: $str = "()G()G"
#     Output: "oGoG"
# 
#     () -> "o"
#     G  -> "G"
#     () -> "o"
#     G  -> "G"
# 
# Example 5
# 
#     Input: $str = "(al)(al)G()()"
#     Output: "alalGoo"
# 
#     (al) -> "al"
#     (al) -> "al"
#     G    -> "G"
#     ()   -> "o"
#     ()   -> "o"
# 

package require Tcl 8.6
package require tcltest

set cases {
    {      "G()(al)"    "Goal" "Example 1"}
    {"G()()()()(al)" "Gooooal" "Example 2"}
    {"(al)G(al)()()" "alGaloo" "Example 3"}
    {       "()G()G"    "oGoG" "Example 4"}
    {"(al)(al)G()()" "alalGoo" "Example 5"}
}

proc goal_parser {str} {
    return [regsub -all {\(al\)} [regsub -all {\(\)} $str o] al]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        goal_parser [lindex $case 0]
    } [lindex $case 1]
}

exit 0

