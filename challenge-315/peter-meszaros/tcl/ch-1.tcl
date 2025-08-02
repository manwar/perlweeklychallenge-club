#!/usr/bin/env tclsh
#
# Task 1: Find Words
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of words and a character.
# 
# Write a script to return the index of word in the list where you find the given
# character.
# 
# Example 1
# 
#     Input: @list = ("the", "weekly", "challenge")
#            $char = "e"
#     Output: (0, 1, 2)
# 
# Example 2
# 
#     Input: @list = ("perl", "raku", "python")
#            $char = "p"
#     Output: (0, 2)
# 
# Example 3
# 
#     Input: @list = ("abc", "def", "bbb", "bcd")
#            $char = "b"
#     Output: (0, 2, 3)
# 

package require tcltest

set cases {
    {{{"the" "weekly" "challenge"} "e"} {0 1 2} "Example 1"}
    {{{"perl" "raku" "python"}     "p"} {0 2}   "Example 2"}
    {{{"abc" "def" "bbb" "bcd"}    "b"} {0 2 3} "Example 3"}
}

proc find_words {p} {
    set l [lindex $p 0]
    set c [lindex $p 1]

    set res {}
    foreach w $l {
        if {[string first $c $w] != -1} {
            lappend res [lsearch -exact $l $w]
        }
    }
    return $res
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        find_words [lindex $case 0]
    } [lindex $case 1]
}

exit 0

