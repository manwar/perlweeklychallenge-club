#!/usr/bin/env tclsh
#
# Task 1: Word Count
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a list of words containing alphabetic characters only.
# 
# Write a script to return the count of words either starting with a vowel or
# ending with a vowel.
# 
# Example 1
# 
#     Input: @list = ("unicode", "xml", "raku", "perl")
#     Output: 2
# 
#     The words are "unicode" and "raku".
# 
# Example 2
# 
#     Input: @list = ("the", "weekly", "challenge")
#     Output: 2
# 
# Example 3
# 
#     Input: @list = ("perl", "python", "postgres")
#     Output: 0
# 

package require tcltest

set cases {
    {{unicode xml raku perl} 2 {Example 1}}
    {{the weekly challenge}  2 {Example 2}}
    {{perl python postgres}  0 {Example 3}}
}

proc word_count {words} {
    set count 0
    foreach w $words {
        if {[regexp {^[aeiou]} $w] || [regexp {[aeiou]$} $w]} {
            incr count
        }
    }
    return $count
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        word_count [lindex $case 0]
    } [lindex $case 1]
}

exit 0

