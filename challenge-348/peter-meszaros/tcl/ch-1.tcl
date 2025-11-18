#!/usr/bin/env tclsh
#
# Task 1: String Alike
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string of even length.
# 
# Write a script to find if the given string split into two halves of equal
# lengths and they both have same number of vowels.
# 
# Example 1
# 
#     Input: $str = "textbook"
#     Output: false
# 
#     1st half: "text" (1 vowel)
#     2nd half: "book" (2 vowels)
# 
# Example 2
# 
#     Input: $str = "book"
#     Output: true
# 
#     1st half: "bo" (1 vowel)
#     2nd half: "ok" (1 vowel)
# 
# Example 3
# 
#     Input: $str = "AbCdEfGh"
#     Output: true
# 
#     1st half: "AbCd" (1 vowel)
#     2nd half: "EfGh" (1 vowel)
# 
# Example 4
# 
#     Input: $str = "rhythmmyth"
#     Output: false
# 
#     1st half: "rhyth" (0 vowel)
#     2nd half: "mmyth" (0 vowel)
# 
# Example 5
# 
#     Input: $str = "UmpireeAudio"
#     Output: false
# 
#     1st half: "Umpire" (3 vowels)
#     2nd half: "eAudio" (5 vowels)
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"textbook"     0 "Example 1"}
    {"book"         1 "Example 2"}
    {"AbCdEfGh"     1 "Example 3"}
    {"rhythmmyth"   0 "Example 4"}
    {"UmpireeAudio" 0 "Example 5"}
}

proc string_alike {str} {
    set len [string length $str]

    if {$len % 2 != 0} {
        return 0
    }
    set half [expr $len / 2]
    set first_half [string range $str 0 [expr $half - 1]]
    set second_half [string range $str $half end]

    set vowel_count_first 0
    set vowel_count_second 0

    foreach char [split $first_half ""] {
        if {[string match -nocase {[aeiou]} $char]} {
            incr vowel_count_first
        }
    }

    foreach char [split $second_half ""] {
        if {[string match -nocase {[aeiou]} $char]} {
            incr vowel_count_second
        }
    }

    if {$vowel_count_first > 0 && $vowel_count_first == $vowel_count_second} {
        return 1
    }

    return 0
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        string_alike [lindex $case 0]
    } [lindex $case 1]
}

exit 0

