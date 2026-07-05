#!/usr/bin/env tclsh
#
# Task 1: Sum of Frequencies
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string consisting of English letters.  Write a script to find
# the vowel and consonant with maximum frequency. Return the sum of two
# frequencies.
# 
# Example 1
# 
#     Input: $str = "banana"
#     Output: 5
# 
#     Vowel: "a" appears 3 times.
#     Consonant: "n" appears 2 times, "b" appears 1 time.
# 
#     Max frequency of vowel: 3
#     Max frequency of consonant: 2
# 
# Example 2
# 
#     Input: $str = "teestett"
#     Output: 7
# 
#     Vowel: "e" appears 3 times.
#     Consonant: "t" appears 4 times, "s" appears 1 time.
# 
#     Max frequency of vowel: 3
#     Max frequency of consonant: 4
# 
# Example 3
# 
#     Input: $str = "aeiouuaa"
#     Output: 3
# 
#     Vowel: "a" appears 3 times, "u" 2 times, "e", "i", "o" 1 time each.
#     Consonant: None.
# 
#     Max frequency of vowel: 3
#     Max frequency of consonant: 0
# 
# Example 4
# 
#     Input: $str = "rhythm"
#     Output: 2
# 
#     Vowel: None
#     Consonant: "h" appears 2 times, "r", "y", "t", "m" 1 time each.
# 
#     Max frequency of vowel: 0
#     Max frequency of consonant: 2
# 
# Example 5
# 
#     Input: $str = "x"
#     Output: 1
# 
#     Vowel: None
#     Consonant: "x" appears 1 time.
# 
#     Max frequency of vowel: 0
#     Max frequency of consonant: 1
# 

package require Tcl 8.6
package require tcltest

set cases {
    {"banana"   5 "Example 1"}
    {"teestett" 7 "Example 2"}
    {"aeiouuaa" 3 "Example 3"}
    {"rhythm"   2 "Example 4"}
    {"x"        1 "Example 5"}
}

proc sum_of_frequencies {str} {
    set vowels {a e i o u}
    array set freq {}
    set max_vowel_freq 0
    set max_consonant_freq 0

    foreach char [split [string tolower $str] ""] {
        incr freq($char)
    }

    foreach char [array names freq] {
        if {[lsearch -exact $vowels $char] >= 0} {
            if {$freq($char) > $max_vowel_freq} {
                set max_vowel_freq $freq($char)
            }
        } else {
            if {$freq($char) > $max_consonant_freq} {
                set max_consonant_freq $freq($char)
            }
        }
    }

    return [expr $max_vowel_freq + $max_consonant_freq]
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        sum_of_frequencies [lindex $case 0]
    } [lindex $case 1]
}

exit 0

