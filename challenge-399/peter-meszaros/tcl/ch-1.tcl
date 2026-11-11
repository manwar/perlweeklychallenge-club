#!/usr/bin/env tclsh
#
# Task 1: Longest Repeating Character
# 
# Submitted by: Mohammad Sajid Anwar
# 
# You are given a string str and an integer k > 0.  Write a script to choose any
# character of str and change it to another character. You may perform this
# operation up to k times. Return the length of the longest reachable substring
# of a single letter.
# 
# Example 1
# 
#     Input: $str = "AAAAA", $k = 2
#     Output: 5
# 
#     Every character in the string is already the same letter "A".
#     The maximum operations allowed (k = 2) do not even need to be used.
#     The entire string of length 5 is already the longest valid substring.
# 
# Example 2
# 
# Input: $str = "ABCDE", $k = 4
# Output: 5
# 
#     All 5 characters in the string are distinct.
#     The most frequent character occurs only 1 time.
#     To turn the entire string into a single repeated character, we need to replace 5 - 1 = 4 characters.
#     Since k = 4, we can replace "B","C","D", and "E" with "A" to form "AAAAA".
# 
# Example 3
# 
#     Input: $str = "AAABBBBAA", $k = 1
#     Output: 5
# 
#     If we target "A", we could change the "B" in "AAAB" (k=1 replacement) to get length 4 ("AAAA").
#     If we target "B", we can pick the substring "BBBBA" and change the single
#     trailing "A" to "B" (k=1 replacement) to form "BBBBB", which gives a length of 5.
#     Targeting "B" gives better result than targeting "A".
# 
# Example 4
# 
#     Input: $str = "ABACADA", $k = 2
#     Output: 5
# 
#     Look at the substring [0..4] which is "ABACA" (length 5).
#     In this window, "A" appears 3 times, and there are 2 non-"A" characters ("B" and "C").
#     With k = 2, we can replace "B" and "C" with "A" to form "AAAAA".
# 
#     Look at the substring [2..6] which is "ACADA" (length 5).
#     Here, "A" appears 3 times, and non-"A" characters ("C" and "D") count to 2.
#     Replacing them gives "AAAAA".
# 
#     In both cases, the maximum valid length is 5.
# 
# Example 5
# 
#     Input: $str = "BAAABAAAA", $k = 1
#     Output: 8
# 
#     The string has two groups of "A"s separated by a single "B" ("AAABAAAA").
# 
#     We can replace the character 4 "B" with an "A" to get a sequence of 8 "A".
# 

package require Tcl 8.6
package require tcltest

set cases {
    {{AAAAA     2} 5 "Example 1"}
    {{ABCDE     4} 5 "Example 2"}
    {{AAABBBBAA 1} 5 "Example 3"}
    {{ABACADA   2} 5 "Example 4"}
    {{BAAABAAAA 1} 8 "Example 5"}
}

proc longest_repeating_character {p} {
    set str [lindex $p 0]
    set k   [lindex $p 1]

    set len [string length $str]
    set count [lrepeat 26 0]
    set start 0
    set maxCount 0
    set maxLength 0

    for {set end 0} {$end < $len} {incr end} {
        set idx [expr [scan [string index $str $end] %c] - [scan A %c]]

        set c [expr [lindex $count $idx] + 1]
        lset count $idx $c

        if {$c > $maxCount} {
            set maxCount $c
        }

        while {$end - $start + 1 - $maxCount > $k} {
            set idx [expr [scan [string index $str $start] %c] - [scan A %c]]
            lset count $idx [expr [lindex $count $idx] - 1]
            incr start
        }

        set currentLength [expr $end - $start + 1]
        if {$currentLength > $maxLength} {
            set maxLength $currentLength
        }
    }
    return $maxLength
}

tcltest::configure -verbose {pass}
foreach case $cases {
    tcltest::test [lindex $case 2] {} {
        longest_repeating_character [lindex $case 0]
    } [lindex $case 1]
}

exit 0

